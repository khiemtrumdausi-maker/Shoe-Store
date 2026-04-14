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
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Lấy dữ liệu từ form gửi lên (Khớp 100% tên biến của sếp)
        String shoeID = request.getParameter("shoeID");
        String size = request.getParameter("size");
        String stock = request.getParameter("stock");
        
        // ==============================================================
        // 2. CHỐT CHẶN TƯỜNG LỬA: Kiểm tra nếu khách gửi lên chuỗi rỗng ""
        // ==============================================================
        if (shoeID == null || shoeID.trim().isEmpty() ||
            size == null || size.trim().isEmpty() ||
            stock == null || stock.trim().isEmpty()) {
            
            // Nếu có ô bị bỏ trống -> Đá thẳng về trang cũ, tuyệt đối KHÔNG cho gọi Database để tránh sập web
            String redirectUrl = (shoeID != null && !shoeID.isEmpty()) ? "variant?sid=" + shoeID : "manager";
            response.sendRedirect(redirectUrl);
            return; // Dừng chương trình ngay tại đây!
        }
        
        try {
            // 3. Ép kiểu thử xem sếp có nhập đúng là "Số" hay không (Chống nhập chữ ABC)
            Integer.parseInt(size);
            Integer.parseInt(stock);

            // 4. Nếu an toàn vượt qua mọi cửa ải -> Gọi DAO để cất vào Database
            AdminDAO dao = new AdminDAO();
            dao.insertVariant(shoeID, size, stock);
            
            // 5. Thêm xong phải Load lại trang size của đúng đôi giày đó
            response.sendRedirect("variant?sid=" + shoeID);
            
        } catch (NumberFormatException e) {
            // Bắt lỗi nếu sếp cố tình lách luật nhập chữ cái vào ô số lượng
            System.out.println("Lỗi nhập dữ liệu không phải số: " + e.getMessage());
            response.sendRedirect("variant?sid=" + shoeID);
        }
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