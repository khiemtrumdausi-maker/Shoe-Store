package control;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import entity.Shoe;
import entity.User;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "HomeControl", urlPatterns = {"/home"})
public class HomeControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. CẬP NHẬT DỮ LIỆU HEADER (Thông báo & Giỏ hàng)
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            OrderDAO odao = new OrderDAO();
            CartDAO cdao = new CartDAO();
            
            // Luôn lấy dữ liệu mới nhất từ DB để đẩy vào Header
            session.setAttribute("listNoti", odao.getNotisByUserID(u.getUserID()));
            session.setAttribute("cartSize", cdao.getCartSizeByUserID(u.getUserID()));
        }
        
        // 2. LẤY DANH SÁCH GIÀY ĐỂ HIỂN THỊ
        ProductDAO dao = new ProductDAO();
        List<Shoe> list = dao.getAllShoes();
        
        // Đẩy danh sách giày sang trang home.jsp
        request.setAttribute("listS", list);
        request.getRequestDispatcher("home.jsp").forward(request, response);
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