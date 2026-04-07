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
        
        // Lấy ID đôi giày
        String shoeID = request.getParameter("sid");
        
        // Lấy danh sách size của đôi giày đó
        AdminDAO dao = new AdminDAO();
        List<ShoeVariant> listV = dao.getVariantsByShoeID(shoeID);
        
        // Đẩy dữ liệu sang trang JSP (gửi kèm cả shoeID để tí nữa làm form thêm size)
        request.setAttribute("listV", listV);
        request.setAttribute("shoeID", shoeID);
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