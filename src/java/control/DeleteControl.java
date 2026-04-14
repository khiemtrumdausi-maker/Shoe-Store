package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Đã sửa lại url cho khớp với link sếp bấm
@WebServlet(name = "DeleteControl", urlPatterns = {"/deleteControl"}) 
public class DeleteControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy đúng tham số "id" từ link ?id=...
        String id = request.getParameter("id"); 
        
        // 2. Gọi DAO để xóa
        if (id != null) {
            AdminDAO dao = new AdminDAO();
            dao.deleteShoe(id);
        }
        
        // 3. Xóa xong thì chuyển hướng quay lại trang quản lý
        response.sendRedirect("manager");
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