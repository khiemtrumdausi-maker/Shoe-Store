package control;

import dao.AdminDAO;
import dao.OrderDAO; // Bổ sung import OrderDAO của anh em mình
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
        
        // 1. Gọi DAO mặc định của Dashboard
        AdminDAO dao = new AdminDAO();
        DashboardDTO stats = dao.getDashboardStats();
        request.setAttribute("stats", stats);
        
        // 2. GỌI THÊM OrderDAO ĐỂ LẤY SỐ ĐƠN HỦY (MỚI THÊM)
        OrderDAO orderDao = new OrderDAO();
        int canceledCount = orderDao.countCanceledOrders();
        request.setAttribute("canceledCount", canceledCount); // Đẩy sang JSP với tên 'canceledCount'
        
        // 3. Mở trang giao diện
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