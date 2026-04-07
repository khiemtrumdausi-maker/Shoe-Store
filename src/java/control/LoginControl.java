package control;

import dao.CartDAO;
import dao.OrderDAO;
import dao.UserDAO;
import entity.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginControl", urlPatterns = {"/login"})
public class LoginControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String email = request.getParameter("user"); 
        String pass = request.getParameter("pass");
        
        UserDAO dao = new UserDAO();
        User u = dao.login(email, pass);
        
        if (u == null) {
            request.setAttribute("mess", "Sai Email hoặc mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("acc", u);
            
            // --- PHẦN QUAN TRỌNG: LẤY DỮ LIỆU HEADER NGAY KHI ĐĂNG NHẬP THÀNH CÔNG ---
            OrderDAO odao = new OrderDAO();
            CartDAO cdao = new CartDAO();
            
            // 1. Lấy danh sách thông báo
            List<String> listNoti = odao.getNotisByUserID(u.getUserID());
            session.setAttribute("listNoti", listNoti);
            
            // 2. Lấy số lượng giỏ hàng
            int cartSize = cdao.getCartSizeByUserID(u.getUserID());
            session.setAttribute("cartSize", cartSize);
            // -----------------------------------------------------------------------
            
            // Phân quyền theo Role
            if ("Admin".equalsIgnoreCase(u.getRole())) {
                response.sendRedirect("adminDashboard"); 
            } else {
                response.sendRedirect("home"); 
            }
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