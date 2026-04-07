package dao;

import context.DBContext;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 1. Kiểm tra Đăng nhập bằng Email và Pass
    public User login(String email, String pass) {
        String query = "SELECT * FROM Users WHERE Email = ? AND Password = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                // ĐÃ FIX: Thêm rs.getInt(8) cho cột Status
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), 
                        rs.getString(4), rs.getString(5), rs.getString(6), 
                        rs.getString(7), rs.getInt(8));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 2. Kiểm tra Email đã tồn tại chưa
    public User checkUserExist(String email) {
        String query = "SELECT * FROM Users WHERE Email = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                // ĐÃ FIX: Thêm rs.getInt(8) cho cột Status
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), 
                        rs.getString(4), rs.getString(5), rs.getString(6), 
                        rs.getString(7), rs.getInt(8));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Đăng ký tài khoản (Mặc định Role là 'Customer', Status mặc định là 1)
    public void signup(String fullName, String email, String pass, String phone, String address) {
        // Lưu ý: Cột Status sẽ tự lấy DEFAULT là 1 nếu sếp đã chạy lệnh ALTER TABLE trong MySQL
        String query = "INSERT INTO Users (FullName, Email, Password, Phone, Address, Role) VALUES (?, ?, ?, ?, ?, 'Customer')";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}