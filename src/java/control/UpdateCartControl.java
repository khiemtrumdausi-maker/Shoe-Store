package control;

import dao.CartDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateCartControl", urlPatterns = {"/updateCart"})
public class UpdateCartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int cartId = Integer.parseInt(request.getParameter("id"));
        
        CartDAO dao = new CartDAO();
        
        if (action != null) {
            if (action.equals("del")) {
                // Xóa sản phẩm khỏi giỏ
                dao.deleteCartItem(cartId);
            } 
            else if (action.equals("up")) {
                // LOGIC CHẶN ÂM KHO: Gọi hàm Safe, nếu số lượng giỏ >= kho thì MySQL tự động chặn, không cho tăng
                dao.increaseQuantitySafe(cartId);
            } 
            else if (action.equals("down")) {
                // Giảm 1, nếu về 0 thì xóa
                int currentQty = dao.getQuantityByCartID(cartId);
                if (currentQty <= 1) {
                    dao.deleteCartItem(cartId);
                } else {
                    dao.updateCartQuantity(cartId, currentQty - 1);
                }
            }
        }
        
        // Quay lại trang giỏ hàng
        response.sendRedirect("cart");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}