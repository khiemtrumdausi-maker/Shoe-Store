package control;

import dao.OrderDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateOrderStatusControl", urlPatterns = {"/updateOrderStatus"})
public class UpdateOrderStatusControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy mã đơn hàng và trạng thái mới từ đường link gửi lên
        request.setCharacterEncoding("UTF-8");
        String oid = request.getParameter("oid");
        String status = request.getParameter("status");
        
        // 2. Gọi DAO để cập nhật
        OrderDAO dao = new OrderDAO();
        dao.updateOrderStatus(oid, status);
        
        // 3. Tải lại trang danh sách đơn hàng
        response.sendRedirect("managerOrder");
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