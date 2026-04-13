package control;

import dao.AdminDAO;
import entity.ShoeVariant;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VariantControl", urlPatterns = {"/variant"})
public class VariantControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy ID đôi giày từ URL (Hỗ trợ cả tham số sid hoặc id)
        String sid = request.getParameter("sid");
        if(sid == null) sid = request.getParameter("id");
        
        // 2. Gọi DAO lấy danh sách size từ Database
        AdminDAO dao = new AdminDAO();
        List<ShoeVariant> listV = dao.getVariantsByShoeID(sid);
        
        // 3. Đẩy danh sách vào biến mang tên "listV"
        request.setAttribute("listV", listV);
        // Gửi thêm sid để tí nữa dùng cho Form thêm mới
        request.setAttribute("currentSid", sid);
        
        // 4. Mở trang JSP lên
        request.getRequestDispatcher("admin_variants.jsp").forward(request, response);
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