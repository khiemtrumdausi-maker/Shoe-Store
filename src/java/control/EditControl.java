package control;

import dao.AdminDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EditControl", urlPatterns = {"/edit"})
public class EditControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8"); // Tránh lỗi font tiếng Việt
        
        // Lấy dữ liệu từ form sửa
        String id = request.getParameter("id"); // Lấy cái ID bị giấu
        String name = request.getParameter("name");
        String image = request.getParameter("image");
        String price = request.getParameter("price");
        String discount = request.getParameter("discount");
        
        // Để form đơn giản, mình tạm fix cứng các thông số này (vì lúc thêm mình cũng nhập thế)
        String description = "Mô tả mới cập nhật"; 
        String gender = "1";
        String brand = "1";
        String category = "1";
        
        // Gọi DAO để Update
        AdminDAO dao = new AdminDAO();
        dao.editShoe(name, image, price, discount, description, gender, brand, category, id);
        
        // Quay lại trang danh sách
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