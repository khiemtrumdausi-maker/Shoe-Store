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
                // Xóa luôn
                dao.deleteCartItem(cartId);
            } 
            else if (action.equals("up")) {
                // Tăng 1
                int currentQty = dao.getQuantityByCartID(cartId);
                dao.updateCartQuantity(cartId, currentQty + 1);
            } 
            else if (action.equals("down")) {
                // Giảm 1
                int currentQty = dao.getQuantityByCartID(cartId);
                if (currentQty <= 1) {
                    // Nếu đang là 1 mà giảm tiếp thì xóa luôn
                    dao.deleteCartItem(cartId);
                } else {
                    dao.updateCartQuantity(cartId, currentQty - 1);
                }
            }
        }
        
        // Sau khi update xong, điều hướng ngược lại trang giỏ hàng.
        // Servlet CartControl sẽ tự động chạy lại để tính tiền và cập nhật số chấm đỏ trên icon.
        response.sendRedirect("cart");
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