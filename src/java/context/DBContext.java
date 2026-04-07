package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/shoe_store_db";
        String user = "root";
        String pass = "123456"; // Mật khẩu MySQL của Khiêm
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    // Test thử xem kết nối được chưa
    public static void main(String[] args) {
        try {
            System.out.println(new DBContext().getConnection());
            System.out.println("Kết nối thành công rồi Khiêm ơi!");
        } catch (Exception e) {
            System.out.println("Lỗi rồi: " + e.getMessage());
        }
    }
}