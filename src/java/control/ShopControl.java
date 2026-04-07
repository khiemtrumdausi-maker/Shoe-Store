package control;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import entity.Shoe;
import entity.User;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ShopControl", urlPatterns = {"/shop"})
public class ShopControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fix lỗi font chữ khi search tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. CẬP NHẬT DỮ LIỆU HEADER (Thông báo & Giỏ hàng)
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            OrderDAO odao = new OrderDAO();
            CartDAO cdao = new CartDAO();
            
            // Làm mới Session để Header luôn nhảy số chuẩn
            session.setAttribute("listNoti", odao.getNotisByUserID(u.getUserID()));
            session.setAttribute("cartSize", cdao.getCartSizeByUserID(u.getUserID()));
        }

        // 2. Lấy các tham số từ URL (nếu có) để lọc sản phẩm
        String search = request.getParameter("search");
        String brandID = request.getParameter("brand");
        String categoryID = request.getParameter("category");
        String genderID = request.getParameter("gender");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");

        ProductDAO dao = new ProductDAO();

        // 3. Lấy dữ liệu cho thanh Menu Lọc (Sidebar)
        Map<Integer, String> brands = dao.getAllBrands();
        Map<Integer, String> categories = dao.getAllCategories();

        // 4. Lấy danh sách sản phẩm theo bộ lọc
        List<Shoe> listS = dao.getFilteredShoes(search, brandID, categoryID, genderID, minPrice, maxPrice);

        // 5. Đẩy dữ liệu sang JSP
        request.setAttribute("brands", brands);
        request.setAttribute("categories", categories);
        request.setAttribute("listS", listS);

        // Giữ lại các giá trị khách vừa chọn để hiển thị lại trên Form
        request.setAttribute("searchVal", search);
        request.setAttribute("brandVal", brandID);
        request.setAttribute("categoryVal", categoryID);
        request.setAttribute("genderVal", genderID);
        request.setAttribute("minPriceVal", minPrice);
        request.setAttribute("maxPriceVal", maxPrice);

        request.getRequestDispatcher("shop.jsp").forward(request, response);
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