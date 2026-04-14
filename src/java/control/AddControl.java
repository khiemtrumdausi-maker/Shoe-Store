package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AddControl", urlPatterns = {"/add"})
// ĐÃ XÓA @MultipartConfig VÌ KHÔNG CẦN UPLOAD FILE NỮA
public class AddControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String discount = request.getParameter("discountPrice"); 
        String description = request.getParameter("description");
        String gender = request.getParameter("genderID");
        String brand = request.getParameter("brandID");
        String category = request.getParameter("categoryID");
        
        // --- CHẾ ĐỘ CHỌN ẢNH CÓ SẴN ---
        // Lấy tên ảnh sếp nhập vào ô input text (ví dụ: giay1.jpg)
        String fileName = request.getParameter("image");
        // Tự động ghép thêm tiền tố thư mục images/ để vào DB cho chuẩn
        String imagePath = "images/" + fileName;
        
        AdminDAO dao = new AdminDAO();
        dao.insertShoe(name, imagePath, price, discount, description, gender, brand, category);
        
        response.sendRedirect("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}