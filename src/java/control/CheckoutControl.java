package control;

import dao.CartDAO;
import dao.OrderDAO;
import entity.CartItem;
import entity.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutControl", urlPatterns = {"/checkout"})
public class CheckoutControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO dao = new CartDAO();
        List<CartItem> listC = dao.getCartByUserID(u.getUserID());
        
        if (listC.isEmpty()) {
            response.sendRedirect("home");
            return;
        }

        double totalMoney = 0;
        for (CartItem item : listC) {
            totalMoney += (item.getPrice() * item.getQuantity());
        }

        request.setAttribute("listCart", listC);
        request.setAttribute("totalMoney", totalMoney);
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod"); 
        
        CartDAO cartDao = new CartDAO();
        List<CartItem> listC = cartDao.getCartByUserID(u.getUserID());
        
        // ====================================================================
        // ĐÃ SỬA LỖI ĐỎ: Dùng đúng getVariantId() và getShoeName() của sếp
        // ====================================================================
        for (CartItem item : listC) {
            int stock = cartDao.getStock(item.getVariantId()); 
            
            if (item.getQuantity() > stock) {
                String errorMsg = "Rất tiếc! Sản phẩm '" + item.getShoeName() + "' (Size " + item.getSize() + ") hiện chỉ còn " + stock + " đôi do vừa có khách hàng khác thanh toán trước. Vui lòng quay lại giỏ hàng để điều chỉnh!";
                request.setAttribute("mess", errorMsg);
                
                doGet(request, response);
                return; 
            }
        }
        // ====================================================================

        double totalMoney = 0;
        for (CartItem item : listC) {
            totalMoney += (item.getPrice() * item.getQuantity());
        }
        
        OrderDAO orderDao = new OrderDAO();
        boolean success = orderDao.placeOrder(u.getUserID(), totalMoney, phone, address, paymentMethod, listC);
        
        if (success) {
            session.setAttribute("cartSize", 0); 
            request.setAttribute("msg", "Đơn hàng của bạn đã được tiếp nhận!");
            request.getRequestDispatcher("order_success.jsp").forward(request, response);
        } else {
            request.setAttribute("mess", "Đặt hàng thất bại. Hệ thống đang bận!");
            doGet(request, response);
        }
    }
}