package control;

import dao.ProductDAO;
import entity.Shoe;
import entity.ShoeVariant;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "DetailControl", urlPatterns = {"/detail"})
public class DetailControl extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String id = request.getParameter("sid");
        ProductDAO dao = new ProductDAO();
        
        Shoe s = dao.getShoeByID(id);
        List<ShoeVariant> listV = dao.getVariantsByShoeID(id);
        
        // 1. Đưa các Size CÒN HÀNG vào một cái Map (Từ điển) để JSP dễ tra cứu
        Map<Integer, ShoeVariant> variantMap = new HashMap<>();
        for (ShoeVariant v : listV) {
            variantMap.put(v.getSize(), v);
        }
        
        // 2. Tạo danh sách Size Chuẩn dựa vào Giới tính (1: Nam, 2: Nữ, 3: Unisex)
        List<Integer> standardSizes = new ArrayList<>();
        int startSize = 35;
        int endSize = 45;
        
        if (s.getGenderID() == 1) { // Giày Nam
            startSize = 39;
            endSize = 45;
        } else if (s.getGenderID() == 2) { // Giày Nữ
            startSize = 35;
            endSize = 40;
        } // Unisex thì để nguyên 35 -> 45
        
        for (int i = startSize; i <= endSize; i++) {
            standardSizes.add(i);
        }
        
        // 3. Đẩy sang giao diện
        request.setAttribute("detail", s);
        request.setAttribute("variantMap", variantMap);
        request.setAttribute("standardSizes", standardSizes);
        
        request.getRequestDispatcher("detail.jsp").forward(request, response);
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