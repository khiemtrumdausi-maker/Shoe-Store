package control;

import dao.OrderDAO;
import entity.Notification;
import entity.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReadNotiControl", urlPatterns = {"/readNoti"})
public class ReadNotiControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int notiId = Integer.parseInt(idStr);
            OrderDAO dao = new OrderDAO();
            
            // 1. Đánh dấu đã đọc trong DB
            dao.markNotiAsRead(notiId);
            
            // 2. Cập nhật lại listNoti trong Session để số đỏ trừ đi ngay lập tức
            HttpSession session = request.getSession();
            User u = (User) session.getAttribute("acc");
            if (u != null) {
                List<Notification> list = dao.getNotifications(u.getUserID());
                session.setAttribute("listNoti", list);
                
                // Đếm lại số lượng chưa đọc
                int unread = 0;
                for (Notification n : list) {
                    if (!n.isIsRead()) unread++;
                }
                session.setAttribute("notiSize", unread);
            }
        }
        // 3. Chuyển hướng về trang lịch sử đơn hàng
        response.sendRedirect("my-orders");
    }
}