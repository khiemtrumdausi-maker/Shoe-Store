package control;

import dao.OrderDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Đường dẫn link sẽ là: confirmOrder
@WebServlet(name = "ConfirmOrderControl", urlPatterns = {"/confirmOrder"})
public class ConfirmOrderControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy mã đơn hàng từ link truyền sang
        String orderId = request.getParameter("id");
        
        if (orderId != null) {
            // 2. Gọi hàm confirmReceived mà sếp vừa thêm ở Bước 1
            OrderDAO dao = new OrderDAO();
            dao.confirmReceived(orderId);
        }
        
        // 3. Sau khi xác nhận xong, đẩy khách quay lại trang Lịch sử đơn hàng
        response.sendRedirect("my-orders");
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