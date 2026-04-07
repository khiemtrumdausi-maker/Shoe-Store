package control;

import dao.OrderDAO;
import entity.Order;
import entity.User; // Đảm bảo import đúng class User của bạn
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "MyOrderControl", urlPatterns = {"/my-orders"})
public class MyOrderControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy Session
        HttpSession session = request.getSession();
        
        // 2. Lấy đối tượng User (Vì bạn đặt tên class là User và lưu trong session là "acc")
        User u = (User) session.getAttribute("acc"); 
        
        // 3. Kiểm tra xem user đã đăng nhập chưa
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 4. Gọi DAO để lấy danh sách đơn hàng
        OrderDAO dao = new OrderDAO();
        
        // Lưu ý: Kiểm tra xem trong class User của bạn là getUserID() hay getId() nhé
        // Ở đây mình dùng u.getUserID() theo code Checkout bạn gửi lúc nãy
        List<Order> list = dao.getOrdersByUserID(u.getUserID()); 
        
        // 5. Đẩy dữ liệu sang trang hiển thị
        request.setAttribute("listOrder", list);
        request.getRequestDispatcher("my_orders.jsp").forward(request, response);
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