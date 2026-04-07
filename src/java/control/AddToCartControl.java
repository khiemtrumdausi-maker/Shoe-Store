package control;

import dao.CartDAO;
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

@WebServlet(name = "AddToCartControl", urlPatterns = {"/addToCart"})
public class AddToCartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra đăng nhập
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // 2. Lấy thông tin từ form
        int userId = u.getUserID();
        String variantIdRaw = request.getParameter("variantId");
        String quantityRaw = request.getParameter("quantity");
        
        try {
            int variantId = Integer.parseInt(variantIdRaw);
            int quantity = Integer.parseInt(quantityRaw);
            
            // 3. Thêm vào Database
            CartDAO dao = new CartDAO();
            dao.addToCart(userId, variantId, quantity);
            
            // 4. Tính lại tổng số lượng giày trong giỏ để hiển thị lên cái chấm đỏ
            List<CartItem> list = dao.getCartByUserID(userId);
            int totalQuantity = 0;
            for (CartItem item : list) {
                totalQuantity += item.getQuantity();
            }
            // Lưu con số này vào session
            session.setAttribute("cartSize", totalQuantity);
            
            // 5. Chuyển thẳng sang trang giỏ hàng
            response.sendRedirect("cart");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}