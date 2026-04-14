package control;

import dao.CartDAO;
import dao.OrderDAO;
import dao.UserDAO;
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
            // --- ĐOẠN KIỂM TRA KHÓA TÀI KHOẢN (STATUS = 0) ---
            if (u.getStatus() == 0) {
                request.setAttribute("mess", "Tài khoản của sếp đã bị khóa. Vui lòng liên hệ Admin!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return; // Dừng lại luôn, không cho chạy xuống đoạn tạo Session dưới đây
            }
            // -------------------------------------------------

            HttpSession session = request.getSession();
            session.setAttribute("acc", u);
            
            // --- NẠP DỮ LIỆU HEADER CHUẨN SHOPEE ---
            OrderDAO odao = new OrderDAO();
            CartDAO cdao = new CartDAO();
            
            // 1. Lấy thông báo dạng Object
            List<Notification> listNoti = odao.getNotifications(u.getUserID());
            session.setAttribute("listNoti", listNoti);
            
            // Đếm những thông báo chưa đọc
            int unreadCount = 0;
            if (listNoti != null) {
                for (Notification n : listNoti) {
                    if (!n.isIsRead()) {
                        unreadCount++;
                    }
                }
            }
            session.setAttribute("notiSize", unreadCount); 
            
            // 2. Lấy số lượng giỏ hàng
            int cartSize = cdao.getCartSizeByUserID(u.getUserID());
            session.setAttribute("cartSize", cartSize);
            
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