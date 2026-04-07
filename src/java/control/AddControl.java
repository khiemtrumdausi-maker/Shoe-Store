package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddControl", urlPatterns = {"/add"})
public class AddControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Chỉnh encoding để nhận tiếng Việt có dấu từ Form không bị lỗi font
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy dữ liệu người dùng nhập từ các ô input (name="..." trong form)
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount");
        String description = request.getParameter("description");
        String gender = request.getParameter("gender");
        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        
        // 2. Gọi DAO và truyền cục dữ liệu này vào để nó cất xuống DB
        AdminDAO dao = new AdminDAO();
        dao.insertShoe(name, image, price, discount, description, gender, brand, category);
        
        // 3. Thêm xong thì tự động quay về trang danh sách để xem thành quả
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