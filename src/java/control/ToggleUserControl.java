package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ToggleUserControl", urlPatterns = {"/toggleUser"})
public class ToggleUserControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy ID và trạng thái hiện tại từ link bấm
        String uid = request.getParameter("uid");
        String currentStatusStr = request.getParameter("status");
        
        if (uid != null && currentStatusStr != null) {
            int currentStatus = Integer.parseInt(currentStatusStr);
            
            // 2. Gọi DAO để đảo ngược trạng thái (1 -> 0 hoặc 0 -> 1)
            AdminDAO dao = new AdminDAO();
            dao.toggleUserStatus(uid, currentStatus);
        }
        
        // 3. Xử lý xong thì quay lại trang quản lý khách hàng luôn
        response.sendRedirect("managerUser");
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