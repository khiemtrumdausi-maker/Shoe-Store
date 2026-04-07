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

    // Chạy khi người dùng từ giỏ hàng sang trang thanh toán (Hiển thị trang)
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

    // Chạy khi người dùng bấm nút "XÁC NHẬN ĐẶT HÀNG" (Xử lý lưu DB)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        // Lấy dữ liệu từ Form (Đảm bảo tên name trong jsp phải khớp)
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod"); 
        
        CartDAO cartDao = new CartDAO();
        List<CartItem> listC = cartDao.getCartByUserID(u.getUserID());
        
        double totalMoney = 0;
        for (CartItem item : listC) {
            totalMoney += (item.getPrice() * item.getQuantity());
        }
        
        OrderDAO orderDao = new OrderDAO();
        // Gọi hàm placeOrder để lưu vào DB và xóa giỏ hàng trong DB luôn
        boolean success = orderDao.placeOrder(u.getUserID(), totalMoney, phone, address, paymentMethod, listC);
        
        if (success) {
            // Đặt hàng thành công:
            session.setAttribute("cartSize", 0); // Reset icon giỏ hàng trên header
            
            // Thay vì đá về home, mình gửi thông báo sang trang thành công
            request.setAttribute("msg", "Đơn hàng của bạn đã được tiếp nhận!");
            request.getRequestDispatcher("order_success.jsp").forward(request, response);
        } else {
            // Thất bại: Trả về trang checkout và hiện lỗi
            request.setAttribute("mess", "Đặt hàng thất bại. Hệ thống đang bận!");
            doGet(request, response);
        }
    }
}