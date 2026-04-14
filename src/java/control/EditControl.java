package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditControl", urlPatterns = {"/edit"})
// ĐÃ XÓA @MultipartConfig VÌ KHÔNG CẦN UPLOAD FILE NỮA
public class EditControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        
        String id = request.getParameter("id"); 
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount");
        
        // --- XỬ LÝ LẤY TÊN ẢNH KIỂU CHỌN CÓ SẴN ---
        String fileName = request.getParameter("image");
        String finalImageName;

        // Nếu sếp để trống ô nhập ảnh thì lấy lại ảnh cũ, nếu nhập thì ghép thêm images/
        if (fileName == null || fileName.trim().isEmpty()) {
            finalImageName = request.getParameter("oldImage");
        } else {
            finalImageName = "images/" + fileName;
        }
        
        // Các thông số khác sếp có thể lấy từ Parameter nếu form có đủ
        String description = request.getParameter("description"); 
        String gender = request.getParameter("genderID");
        String brand = request.getParameter("brandID");
        String category = request.getParameter("categoryID");
        
        AdminDAO dao = new AdminDAO();
        dao.editShoe(name, finalImageName, price, discount, description, gender, brand, category, id);
        
        response.sendRedirect("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}