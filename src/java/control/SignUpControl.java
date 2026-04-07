package control;

import dao.UserDAO;
import entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SignUpControl", urlPatterns = {"/signup"})
public class SignUpControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); 
        
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Cờ đánh dấu xem có lỗi không
        boolean hasError = false;

        // 1. Kiểm tra từng trường một
        if (fullname == null || fullname.trim().isEmpty()) {
            request.setAttribute("errFullname", "Họ tên không được để trống!");
            hasError = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errEmail", "Email không được để trống!");
            hasError = true;
        }
        if (pass == null || pass.trim().isEmpty()) {
            request.setAttribute("errPass", "Mật khẩu không được để trống!");
            hasError = true;
        }
        if (repass == null || repass.trim().isEmpty()) {
            request.setAttribute("errRepass", "Vui lòng xác nhận lại mật khẩu!");
            hasError = true;
        } else if (!pass.equals(repass)) {
            request.setAttribute("errRepass", "Mật khẩu nhập lại không khớp!");
            hasError = true;
        }
        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("errPhone", "Số điện thoại không được để trống!");
            hasError = true;
        }
        if (address == null || address.trim().isEmpty()) {
            request.setAttribute("errAddress", "Địa chỉ không được để trống!");
            hasError = true;
        }

        // 2. Giữ lại dữ liệu người dùng đã nhập (để họ không phải gõ lại)
        request.setAttribute("v_fullname", fullname);
        request.setAttribute("v_email", email);
        request.setAttribute("v_phone", phone);
        request.setAttribute("v_address", address);

        // 3. Nếu có BẤT KỲ lỗi nào -> Quay lại trang đăng ký và in lỗi ra
        if (hasError) {
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return; // Dừng luôn, không chạy code kiểm tra Database nữa
        }
        
        // 4. Nếu mọi thứ hợp lệ -> Kiểm tra Email trùng
        UserDAO dao = new UserDAO();
        User u = dao.checkUserExist(email);
        
        if (u != null) {
            // Nhập đủ nhưng email bị trùng
            request.setAttribute("errEmail", "Email này đã được đăng ký!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        } else {
            // Đăng ký thành công -> Lưu xuống DB và chuyển về trang Login
            dao.signup(fullname, email, pass, phone, address);
            response.sendRedirect("login.jsp");
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