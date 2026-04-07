package control;

import dao.AdminDAO;
import entity.Shoe;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoadShoeControl", urlPatterns = {"/loadShoe"})
public class LoadShoeControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy ID của đôi giày khi Admin bấm nút "Sửa"
        String id = request.getParameter("sid");
        
        // 2. Gọi DAO để tìm chính xác đôi giày đó trong Database
        AdminDAO dao = new AdminDAO();
        Shoe s = dao.getShoeByID(id);
        
        // 3. Đóng gói dữ liệu đôi giày đó (đặt tên là "detail") và gửi sang trang form sửa
        request.setAttribute("detail", s);
        request.getRequestDispatcher("edit_shoe.jsp").forward(request, response);
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