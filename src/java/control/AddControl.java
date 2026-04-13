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

@WebServlet(name = "AddControl", urlPatterns = {"/add"})
// BẮT BUỘC CÓ DÒNG NÀY ĐỂ UPLOAD FILE
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AddControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        
        // Đã fix lại tên các tham số cho khớp với thẻ <select name="..."> trong add_shoe.jsp
        String discount = request.getParameter("discountPrice"); 
        String description = request.getParameter("description");
        String gender = request.getParameter("genderID");
        String brand = request.getParameter("brandID");
        String category = request.getParameter("categoryID");
        
        // --- XỬ LÝ UPLOAD ẢNH ---
        Part part = request.getPart("image");
        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadFilePath = applicationPath + File.separator + "images";
        
        File fileSaveDir = new File(uploadFilePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }
        
        // Lưu file vào thư mục images
        part.write(uploadFilePath + File.separator + fileName);
        
        // Gọi DAO lưu vào Database
        AdminDAO dao = new AdminDAO();
        dao.insertShoe(name, fileName, price, discount, description, gender, brand, category);
        
        response.sendRedirect("manager");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { processRequest(request, response); }
}