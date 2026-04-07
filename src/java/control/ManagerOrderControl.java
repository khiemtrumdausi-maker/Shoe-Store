package control;

import dao.OrderDAO;
import entity.Order;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ManagerOrderControl", urlPatterns = {"/managerOrder"})
public class ManagerOrderControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Gọi DAO lấy danh sách tất cả đơn hàng
        OrderDAO dao = new OrderDAO();
        List<Order> listO = dao.getAllOrders();
        
        // Đẩy sang giao diện
        request.setAttribute("listO", listO);
        request.getRequestDispatcher("admin_orders.jsp").forward(request, response);
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