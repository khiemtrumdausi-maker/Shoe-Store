package control;

import dao.AdminDAO;
import entity.User; // Import đúng class User của sếp
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ManagerUserControl", urlPatterns = {"/managerUser"})
public class ManagerUserControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        AdminDAO dao = new AdminDAO();
        // Gọi hàm getAllUser thay vì getAllAccount
        List<User> list = dao.getAllUser(); 
        
        request.setAttribute("listU", list);
        request.getRequestDispatcher("managerUser.jsp").forward(request, response);
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