package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutControl", urlPatterns = {"/logout"})
public class LogoutControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy session hiện tại
        HttpSession session = request.getSession();
        
        // 2. Hủy bỏ toàn bộ session (Xóa sạch acc, giỏ hàng, và các dữ liệu tạm thời)
        session.invalidate(); 
        
        // 3. Chuyển hướng thẳng về trang đăng nhập
        // Lưu ý: Nếu file của bạn là login.jsp thì để nguyên, nếu dùng Servlet thì đổi thành "login"
        response.sendRedirect("login.jsp"); 
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