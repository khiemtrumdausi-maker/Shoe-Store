package control;

import dao.AdminDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "EditControl", urlPatterns = {"/edit"})
// BẮT BUỘC CÓ DÒNG NÀY ĐỂ UPLOAD FILE
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class EditControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); 
        
        String id = request.getParameter("id"); 
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount");
        
        // --- XỬ LÝ UPLOAD ẢNH THÔNG MINH ---
        Part part = request.getPart("image");
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String finalImageName = request.getParameter("oldImage"); // Mặc định lấy ảnh cũ
        
        // Nếu sếp có chọn upload file mới
        if (fileName != null && !fileName.trim().isEmpty()) {
            String uploadFilePath = request.getServletContext().getRealPath("") + File.separator + "images";
            File fileSaveDir = new File(uploadFilePath);
            if (!fileSaveDir.exists()) fileSaveDir.mkdirs();
            
            part.write(uploadFilePath + File.separator + fileName);
            finalImageName = fileName; // Đổi tên ảnh sang file mới
        }
        
        // Giữ nguyên các thuộc tính mặc định của sếp
        String description = "Mô tả mới cập nhật"; 
        String gender = "1";
        String brand = "1";
        String category = "1";
        
        AdminDAO dao = new AdminDAO();
        dao.editShoe(name, finalImageName, price, discount, description, gender, brand, category, id);
        
        response.sendRedirect("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}