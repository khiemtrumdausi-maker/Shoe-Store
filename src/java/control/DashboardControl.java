package control;

import dao.AdminDAO;
import entity.DashboardDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DashboardControl", urlPatterns = {"/adminDashboard"})
public class DashboardControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Gọi DAO
        AdminDAO dao = new AdminDAO();
        
        // 2. Lấy số liệu thực tế từ Database
        DashboardDTO stats = dao.getDashboardStats();
        
        // 3. Đẩy dữ liệu sang JSP với tên biến là "stats"
        request.setAttribute("stats", stats);
        
        // 4. Mở trang giao diện
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
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