package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddVariantControl", urlPatterns = {"/addVariant"})
public class AddVariantControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy dữ liệu từ form gửi lên
        String shoeID = request.getParameter("shoeID");
        String size = request.getParameter("size");
        String stock = request.getParameter("stock");
        
        // 2. Gọi DAO để cất vào Database
        AdminDAO dao = new AdminDAO();
        dao.insertVariant(shoeID, size, stock);
        
        // 3. Cực kỳ quan trọng: Thêm xong phải Load lại trang size của đúng đôi giày đó
        response.sendRedirect("variant?sid=" + shoeID);
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