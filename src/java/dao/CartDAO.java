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

    public int getCartSizeByUserID(int userId) {
        String query = "SELECT SUM(Quantity) FROM Cart WHERE UserID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); 
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ========================================================
    // LOGIC CHẶN ÂM KHO: Lấy số lượng tồn kho
    // ========================================================
    public int getStock(int variantId) {
        String query = "SELECT StockQuantity FROM shoevariants WHERE VariantID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, variantId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch(Exception e) { e.printStackTrace(); }
        return 0;
    }

    // LOGIC CHẶN ÂM KHO: Lấy số lượng khách đã bỏ sẵn vào giỏ
    public int getCartQuantity(int userId, int variantId) {
        String query = "SELECT Quantity FROM Cart WHERE UserID = ? AND VariantID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setInt(2, variantId);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch(Exception e) { e.printStackTrace(); }
        return 0;
    }

    // LOGIC CHẶN ÂM KHO: Tăng số lượng trong giỏ CHỈ KHI nhỏ hơn tồn kho
    public void increaseQuantitySafe(int cartId) {
        String query = "UPDATE Cart c JOIN shoevariants v ON c.VariantID = v.VariantID "
                     + "SET c.Quantity = c.Quantity + 1 "
                     + "WHERE c.CartID = ? AND c.Quantity < v.StockQuantity";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // ========================================================
    // CÁC HÀM XỬ LÝ GIỎ HÀNG
    // ========================================================
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
        } catch (Exception e) { e.printStackTrace(); }
    }

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
                        rs.getInt(1), rs.getInt(2), rs.getString(3), 
                        rs.getString(4), rs.getInt(5), rs.getDouble(6), rs.getInt(7)
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public int getQuantityByCartID(int cartId) {
        String query = "SELECT Quantity FROM Cart WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();
            if (rs.next()) { return rs.getInt(1); }
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public void updateCartQuantity(int cartId, int newQuantity) {
        String query = "UPDATE Cart SET Quantity = ? WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteCartItem(int cartId) {
        String query = "DELETE FROM Cart WHERE CartID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}