package dao;

import context.DBContext;
import entity.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // ========================================================
    // HÀM MỚI: Đếm tổng số lượng giày trong giỏ (Dùng cho Header)
    // ========================================================
    public int getCartSizeByUserID(int userId) {
        // Dùng SUM(Quantity) để lấy tổng số đôi giày thay vì chỉ đếm dòng
        String query = "SELECT SUM(Quantity) FROM Cart WHERE UserID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số lượng (ví dụ: 2 đôi Nike + 1 đôi Adidas = 3)
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ========================================================
    // CÁC HÀM CŨ CỦA SẾP KHIÊM (GIỮ NGUYÊN)
    // ========================================================

    // 1. Hàm thêm sản phẩm vào giỏ hàng (Có xử lý cộng dồn nếu trùng Size)
    public void addToCart(int userId, int variantId, int quantity) {
        String checkQuery = "SELECT * FROM Cart WHERE UserID = ? AND VariantID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(checkQuery);
            ps.setInt(1, userId);
            ps.setInt(2, variantId);
            rs = ps.executeQuery();

            if (rs.next()) {
                String updateQuery = "UPDATE Cart SET Quantity = Quantity + ? WHERE UserID = ? AND VariantID = ?";
                PreparedStatement psUpdate = conn.prepareStatement(updateQuery);
                psUpdate.setInt(1, quantity);
                psUpdate.setInt(2, userId);
                psUpdate.setInt(3, variantId);
                psUpdate.executeUpdate();
            } else {
                String insertQuery = "INSERT INTO Cart (UserID, VariantID, Quantity) VALUES (?, ?, ?)";
                PreparedStatement psInsert = conn.prepareStatement(insertQuery);
                psInsert.setInt(1, userId);
                psInsert.setInt(2, variantId);
                psInsert.setInt(3, quantity);
                psInsert.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 2. Hàm lấy danh sách toàn bộ sản phẩm trong giỏ hàng
    public List<CartItem> getCartByUserID(int userId) {
        List<CartItem> list = new ArrayList<>();
        String query = "SELECT c.CartID, c.VariantID, s.Name, s.Image, v.Size, "
                     + "IF(s.DiscountPrice > 0, s.DiscountPrice, s.Price) as FinalPrice, "
                     + "c.Quantity "
                     + "FROM Cart c "
                     + "JOIN ShoeVariants v ON c.VariantID = v.VariantID "
                     + "JOIN Shoes s ON v.ShoeID = s.ShoeID "
                     + "WHERE c.UserID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CartItem(
                        rs.getInt(1), 
                        rs.getInt(2), 
                        rs.getString(3), 
                        rs.getString(4), 
                        rs.getInt(5), 
                        rs.getDouble(6), 
                        rs.getInt(7)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // 3. Hàm lấy số lượng hiện tại của 1 dòng trong giỏ
    public int getQuantityByCartID(int cartId) {
        String query = "SELECT Quantity FROM Cart WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 4. Hàm cập nhật lại số lượng (+ hoặc -)
    public void updateCartQuantity(int cartId, int newQuantity) {
        String query = "UPDATE Cart SET Quantity = ? WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. Hàm xóa 1 sản phẩm khỏi giỏ hàng
    public void deleteCartItem(int cartId) {
        String query = "DELETE FROM Cart WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}