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

@WebServlet(name = "CartControl", urlPatterns = {"/cart"})
public class CartControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
        
        double totalMoney = 0;
        int totalQuantity = 0;
        
        // Tính tổng tiền và tổng số lượng
        for (CartItem item : listC) {
            totalMoney += (item.getPrice() * item.getQuantity());
            totalQuantity += item.getQuantity();
        }
        
        // Đảm bảo icon giỏ hàng luôn đúng số lượng
        session.setAttribute("cartSize", totalQuantity); 
        
        // Đẩy dữ liệu sang cart.jsp
        request.setAttribute("listCart", listC);
        request.setAttribute("totalMoney", totalMoney);
        
        request.getRequestDispatcher("cart.jsp").forward(request, response);
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