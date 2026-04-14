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
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = u.getUserID();
        String variantIdRaw = request.getParameter("variantId");
        String quantityRaw = request.getParameter("quantity");
        String shoeIdRaw = request.getParameter("shoeId"); 
        
        try {
            int variantId = Integer.parseInt(variantIdRaw);
            int quantity = Integer.parseInt(quantityRaw);
            
            CartDAO dao = new CartDAO();
            
            // ========================================================
            // LOGIC CHẶN ÂM KHO: Tính tổng và so sánh
            // ========================================================
            int stock = dao.getStock(variantId);
            int currentCartQty = dao.getCartQuantity(userId, variantId);
            
            if (currentCartQty + quantity > stock) {
                // Báo lỗi đỏ chót về trang chi tiết, chặn không cho thêm
                request.setAttribute("errorMsg", "Size này chỉ còn " + stock + " đôi. Bạn đang có " + currentCartQty + " đôi trong giỏ rồi!");
                request.getRequestDispatcher("detail?sid=" + shoeIdRaw).forward(request, response);
                return;
            }
            
            // Qua được bước trên nghĩa là đủ hàng -> Cho phép thêm
            dao.addToCart(userId, variantId, quantity);
            
            // Cập nhật lại giỏ hàng trên Header
            List<CartItem> list = dao.getCartByUserID(userId);
            int totalQuantity = 0;
            for (CartItem item : list) {
                totalQuantity += item.getQuantity();
            }
            session.setAttribute("cartSize", totalQuantity);
            
            response.sendRedirect("cart");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("home");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}