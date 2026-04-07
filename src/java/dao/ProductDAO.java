package dao;

import context.DBContext;
import entity.Shoe;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class ProductDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // ==========================================
    // CÁC HÀM CŨ (Đã có sẵn)
    // ==========================================

    // Lấy toàn bộ giày trong kho ra để trưng bày
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Lấy chi tiết 1 sản phẩm theo ID
    public Shoe getShoeByID(String id) {
        String query = "SELECT * FROM Shoes WHERE ShoeID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, id);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3), 
                        rs.getDouble(4), rs.getDouble(5), rs.getString(6), 
                        rs.getInt(7), rs.getInt(8), rs.getInt(9));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy danh sách các Size của đôi giày đó (chỉ lấy size còn hàng)
    public List<entity.ShoeVariant> getVariantsByShoeID(String shoeID) {
        List<entity.ShoeVariant> list = new ArrayList<>();
        String query = "SELECT * FROM ShoeVariants WHERE ShoeID = ? AND StockQuantity > 0";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, shoeID);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new entity.ShoeVariant(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ==========================================
    // CÁC HÀM MỚI CHO TRANG CỬA HÀNG (SHOP & FILTER)
    // ==========================================

    // Lấy danh sách Thương Hiệu (Brand) để hiển thị lên bộ lọc
    public Map<Integer, String> getAllBrands() {
        Map<Integer, String> map = new HashMap<>();
        String query = "SELECT * FROM Brands";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {}
        return map;
    }

    // Lấy danh sách Loại Giày (Category) để hiển thị lên bộ lọc
    public Map<Integer, String> getAllCategories() {
        Map<Integer, String> map = new HashMap<>();
        String query = "SELECT * FROM Categories";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt(1), rs.getString(2));
            }
        } catch (Exception e) {}
        return map;
    }

    // Hàm Siêu Lọc Đa Năng
    public List<Shoe> getFilteredShoes(String search, String brandID, String categoryID, String genderID, String minPrice, String maxPrice) {
        List<Shoe> list = new ArrayList<>();
        // Khởi tạo câu lệnh SQL gốc (1=1 để dễ dàng nối các đuôi AND phía sau)
        String query = "SELECT * FROM Shoes WHERE 1=1 ";

        if (search != null && !search.trim().isEmpty()) {
            query += " AND Name LIKE ? ";
        }
        if (brandID != null && !brandID.isEmpty()) {
            query += " AND BrandID = ? ";
        }
        if (categoryID != null && !categoryID.isEmpty()) {
            query += " AND CategoryID = ? ";
        }
        if (genderID != null && !genderID.isEmpty()) {
            query += " AND GenderID = ? ";
        }
        if (minPrice != null && !minPrice.isEmpty()) {
            query += " AND IF(DiscountPrice > 0, DiscountPrice, Price) >= ? ";
        }
        if (maxPrice != null && !maxPrice.isEmpty()) {
            query += " AND IF(DiscountPrice > 0, DiscountPrice, Price) <= ? ";
        }

        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            
            // Nhồi giá trị (Set Parameter) tương ứng vào các dấu hỏi chấm (?)
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) ps.setString(paramIndex++, "%" + search + "%");
            if (brandID != null && !brandID.isEmpty()) ps.setString(paramIndex++, brandID);
            if (categoryID != null && !categoryID.isEmpty()) ps.setString(paramIndex++, categoryID);
            if (genderID != null && !genderID.isEmpty()) ps.setString(paramIndex++, genderID);
            if (minPrice != null && !minPrice.isEmpty()) ps.setString(paramIndex++, minPrice);
            if (maxPrice != null && !maxPrice.isEmpty()) ps.setString(paramIndex++, maxPrice);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Shoe(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getDouble(4), rs.getDouble(5), rs.getString(6),
                        rs.getInt(7), rs.getInt(8), rs.getInt(9)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}