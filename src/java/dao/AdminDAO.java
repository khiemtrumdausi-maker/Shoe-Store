package dao;

import context.DBContext;
import entity.Shoe;
import entity.ShoeVariant;
import entity.User; 
import entity.Category;
import entity.Brand; // ĐÃ THÊM IMPORT BRAND
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Shoe> getAllShoes() {
        List<Shoe> list = new ArrayList<>();
        String query = "SELECT * FROM Shoes";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), 
                        rs.getDouble(4), rs.getDouble(5), rs.getString(6), 
                        rs.getInt(7), rs.getInt(8), rs.getInt(9)));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public void deleteShoe(String id) {
        String query = "DELETE FROM Shoes WHERE ShoeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            ps.executeUpdate();
        } catch (Exception e) { System.out.println("Lỗi khi xóa: " + e.getMessage()); }
    }
    
    public void insertShoe(String name, String image, String price, String discount, String desc, String gender, String brand, String cate) {
        String query = "INSERT INTO Shoes (Name, Image, Price, DiscountPrice, Description, GenderID, BrandID, CategoryID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name); ps.setString(2, image); ps.setString(3, price);
            ps.setString(4, discount); ps.setString(5, desc); ps.setString(6, gender);
            ps.setString(7, brand); ps.setString(8, cate);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    public Shoe getShoeByID(String id) {
        String query = "SELECT * FROM Shoes WHERE ShoeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getDouble(5), rs.getString(6), rs.getInt(7), rs.getInt(8), rs.getInt(9));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void editShoe(String name, String image, String price, String discount, String desc, String gender, String brand, String cate, String id) {
        String query = "UPDATE Shoes SET Name=?, Image=?, Price=?, DiscountPrice=?, Description=?, GenderID=?, BrandID=?, CategoryID=? WHERE ShoeID=?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, name); ps.setString(2, image); ps.setString(3, price);
            ps.setString(4, discount); ps.setString(5, desc); ps.setString(6, gender);
            ps.setString(7, brand); ps.setString(8, cate); ps.setString(9, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
    
    public List<ShoeVariant> getVariantsByShoeID(String shoeID) {
        List<ShoeVariant> list = new ArrayList<>();
        String query = "SELECT * FROM ShoeVariants WHERE ShoeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, shoeID);
            rs = ps.executeQuery();
            while (rs.next()) { list.add(new ShoeVariant(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4))); }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void insertVariant(String shoeID, String size, String stock) {
        String query = "INSERT INTO ShoeVariants (ShoeID, Size, StockQuantity) VALUES (?, ?, ?)";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, shoeID); ps.setString(2, size); ps.setString(3, stock);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String query = "SELECT * FROM users WHERE Role = 'Customer'"; 
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8)));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void toggleUserStatus(String uid, int currentStatus) {
        int newStatus = (currentStatus == 1) ? 0 : 1;
        String query = "UPDATE users SET Status = ? WHERE UserID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, newStatus); ps.setString(2, uid);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Category> getAllCategory() {
        List<Category> list = new ArrayList<>();
        String query = "SELECT * FROM categories";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) { list.add(new Category(rs.getInt("CategoryID"), rs.getString("CategoryName"))); }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // ==========================================
    // ĐÃ THÊM: HÀM LẤY DANH SÁCH THƯƠNG HIỆU (BRAND)
    // ==========================================
    public List<Brand> getAllBrands() {
        List<Brand> list = new ArrayList<>();
        String query = "SELECT * FROM brands";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Brand(rs.getInt("BrandID"), rs.getString("BrandName")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}