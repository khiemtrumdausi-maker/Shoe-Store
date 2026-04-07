package control;

import dao.AdminDAO;
import entity.Shoe;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ManagerControl", urlPatterns = {"/manager"})
public class ManagerControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Gọi DAO lấy danh sách giày
        AdminDAO dao = new AdminDAO();
        List<Shoe> list = dao.getAllShoes();
        
        // 2. Nhét danh sách này vào request với cái tên là "listS"
        request.setAttribute("listS", list);
        
        // 3. Đá sang trang admin_manager.jsp để hiển thị
        request.getRequestDispatcher("admin_manager.jsp").forward(request, response);
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