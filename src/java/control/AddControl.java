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
        
        request.setCharacterEncoding("UTF-8");
        
        // Lấy thông tin từ form
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String discount = request.getParameter("discountPrice"); 
        String description = request.getParameter("description");
        String gender = request.getParameter("genderID");
        String brand = request.getParameter("brandID");
        String category = request.getParameter("categoryID");
        
        // --- XỬ LÝ ẢNH KIỂU CHỌN CÓ SẴN ---
        // Lấy cái tên file sếp nhập (vd: giay-nike.jpg)
        String fileName = request.getParameter("image");
        // Ghép thêm tiền tố thư mục để lưu vào DB cho đúng: images/giay-nike.jpg
        String imagePath = "images/" + fileName;
        
        // Gọi DAO lưu vào Database
        AdminDAO dao = new AdminDAO();
        dao.insertShoe(name, imagePath, price, discount, description, gender, brand, category);
        
        response.sendRedirect("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}