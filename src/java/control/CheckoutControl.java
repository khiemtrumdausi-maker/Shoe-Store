package control;

import dao.CartDAO;
import dao.OrderDAO;
import entity.CartItem;
import entity.User;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutControl", urlPatterns = {"/checkout"})
public class CheckoutControl extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu khách vô tình gõ /checkout lên thanh địa chỉ, đá nó về giỏ hàng bắt chọn món
        response.sendRedirect("cart");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ====================================================================
        // NGÃ RẼ 1: TỪ GIỎ HÀNG CHUYỂN SANG TRANG CHECKOUT (Có gửi Checkbox)
        // ====================================================================
        String[] selectedItems = request.getParameterValues("selectedItems");
        
        if (selectedItems != null) {
            CartDAO dao = new CartDAO();
            List<CartItem> fullCart = dao.getCartByUserID(u.getUserID());
            List<CartItem> checkoutList = new ArrayList<>();
            double totalMoney = 0;

            // Lọc ra ĐÚNG những món khách đã tích ô
            for (CartItem item : fullCart) {
                for (String selId : selectedItems) {
                    if (item.getCartId() == Integer.parseInt(selId)) {
                        checkoutList.add(item);
                        totalMoney += (item.getPrice() * item.getQuantity());
                        break;
                    }
                }
            }

            if (checkoutList.isEmpty()) {
                request.setAttribute("mess", "Có lỗi xảy ra, vui lòng chọn lại sản phẩm!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // LƯU TẠM DANH SÁCH NÀY VÀO SESSION ĐỂ LÁT NỮA THANH TOÁN
            session.setAttribute("checkoutItems", checkoutList);
            
            // Đẩy sang giao diện điền thông tin địa chỉ
            request.setAttribute("listCart", checkoutList);
            request.setAttribute("totalMoney", totalMoney);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return; // Dừng lại ở đây, không chạy xuống dưới
        }


        // ====================================================================
        // NGÃ RẼ 2: KHÁCH ĐIỀN ĐỊA CHỈ XONG, BẤM NÚT "ĐẶT HÀNG THẬT"
        // ====================================================================
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod"); 
        
        if (phone != null && address != null) {
            
            // Lấy lại danh sách hàng đã lưu ở Ngã rẽ 1
            List<CartItem> listC = (List<CartItem>) session.getAttribute("checkoutItems");
            
            if (listC == null || listC.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }

            CartDAO cartDao = new CartDAO();
            
            // Kiểm tra kho hàng
            for (CartItem item : listC) {
                int stock = cartDao.getStock(item.getVariantId()); 
                
                if (item.getQuantity() > stock) {
                    String errorMsg = "Rất tiếc! Sản phẩm '" + item.getShoeName() + "' (Size " + item.getSize() + ") hiện chỉ còn " + stock + " đôi. Vui lòng quay lại giỏ hàng!";
                    request.setAttribute("mess", errorMsg);
                    
                    // Phục hồi lại trang checkout để khách chọn lại
                    request.setAttribute("listCart", listC);
                    double tempTotal = 0;
                    for (CartItem temp : listC) tempTotal += (temp.getPrice() * temp.getQuantity());
                    request.setAttribute("totalMoney", tempTotal);
                    request.getRequestDispatcher("checkout.jsp").forward(request, response);
                    return; 
                }
            }

            // Tính tổng tiền
            double totalMoney = 0;
            for (CartItem item : listC) {
                totalMoney += (item.getPrice() * item.getQuantity());
            }
            
            OrderDAO orderDao = new OrderDAO();
            // Gửi đúng cái listC (chỉ chứa các món đã chọn) xuống Database
            boolean success = orderDao.placeOrder(u.getUserID(), totalMoney, phone, address, paymentMethod, listC);
            
            if (success) {
                // 1. Đặt xong thì xóa cái danh sách tạm đi
                session.removeAttribute("checkoutItems"); 
                
                // =========================================================
                // 2. FIX: CẬP NHẬT LẠI SỐ LƯỢNG GIỎ HÀNG TRÊN HEADER
                // =========================================================
                CartDAO refreshCartDao = new CartDAO();
                // Chạy vào DB đếm lại xem giỏ của ông này còn bao nhiêu món chưa mua
                List<CartItem> remainingCart = refreshCartDao.getCartByUserID(u.getUserID());
                
                // Cập nhật lại cái biến cartSize (dùng ở header.jsp)
                session.setAttribute("cartSize", remainingCart.size());
                // =========================================================
                
                // 3. Chuyển hướng sang trang thành công
                request.setAttribute("msg", "Đơn hàng của bạn đã được tiếp nhận!");
                request.getRequestDispatcher("order_success.jsp").forward(request, response);
            } else {
                request.setAttribute("mess", "Đặt hàng thất bại. Hệ thống đang bận!");
                request.setAttribute("listCart", listC);
                request.setAttribute("totalMoney", totalMoney);
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        }
    }
}