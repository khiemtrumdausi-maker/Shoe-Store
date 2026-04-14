package dao;

import context.DBContext;
import entity.Order;
import entity.CartItem;
import entity.Notification;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // --- 1. ĐẾM SỐ ĐƠN HÀNG ĐÃ HỦY (Cho Dashboard Admin) ---
    public int countCanceledOrders() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM Orders WHERE Status = 'Đã hủy'";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    // --- 2. HỦY ĐƠN HÀNG & BÁO CHO ADMIN (ĐÃ SỬA CHUẨN) ---
    public void cancelOrder(String orderId) {
        String queryOrder = "UPDATE Orders SET Status = 'Đã hủy' WHERE OrderID = ?";
        String queryNotiAdmin = "INSERT INTO Notifications (UserID, Message) VALUES (1, ?)";
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false); // Dùng transaction để đảm bảo cả 2 lệnh đều chạy

            // Cập nhật trạng thái đơn
            ps = conn.prepareStatement(queryOrder);
            ps.setString(1, orderId);
            ps.executeUpdate();

            // Bắn tin cho Admin Dashboard
            PreparedStatement psAdmin = conn.prepareStatement(queryNotiAdmin);
            psAdmin.setString(1, "HỆ THỐNG: Đơn hàng #LUMA" + orderId + " đã bị hủy!");
            psAdmin.executeUpdate();

            conn.commit();
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- 3. KHÁCH XÁC NHẬN NHẬN HÀNG -> BÁO CHO ADMIN ---
    public void confirmReceived(String orderId) {
        String queryOrder = "UPDATE Orders SET Status = 'Hoàn thành' WHERE OrderID = ?";
        String queryPayment = "UPDATE Payments SET PaymentStatus = 'Đã thanh toán' WHERE OrderID = ?";
        String queryNotiAdmin = "INSERT INTO Notifications (UserID, Message) VALUES (1, ?)";
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);
            
            ps = conn.prepareStatement(queryOrder);
            ps.setString(1, orderId);
            ps.executeUpdate();

            PreparedStatement psPayment = conn.prepareStatement(queryPayment);
            psPayment.setString(1, orderId);
            psPayment.executeUpdate();
            
            PreparedStatement psAdmin = conn.prepareStatement(queryNotiAdmin);
            psAdmin.setString(1, "HỆ THỐNG: Đơn hàng #LUMA" + orderId + " khách đã xác nhận nhận hàng thành công!");
            psAdmin.executeUpdate();

            conn.commit();
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- 4. LẤY TOÀN BỘ THÔNG BÁO CHO CHUÔNG CỦA KHÁCH ---
    public List<String> getNotisByUserID(int userId) {
        List<String> list = new ArrayList<>();
        String query = "SELECT Message FROM Notifications WHERE UserID = ? ORDER BY CreatedAt DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Message"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- 5. LẤY THÔNG BÁO DẠNG OBJECT ---
    public List<Notification> getNotifications(int userId) {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT * FROM Notifications WHERE UserID = ? ORDER BY CreatedAt DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Notification(
                        rs.getInt("NotiID"), rs.getInt("UserID"), rs.getString("Message"),
                        rs.getBoolean("IsRead"), rs.getString("CreatedAt")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- 6. ADMIN DUYỆT ĐƠN -> BÁO CHO CẢ 2 BÊN ---
    public void updateOrderStatus(String orderId, String status) {
        String queryUpdate = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        String queryGetUID = "SELECT UserID FROM Orders WHERE OrderID = ?";
        String queryNoti = "INSERT INTO Notifications (UserID, Message) VALUES (?, ?)";
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            ps = conn.prepareStatement(queryUpdate);
            ps.setString(1, status);
            ps.setString(2, orderId);
            ps.executeUpdate();

            PreparedStatement psGet = conn.prepareStatement(queryGetUID);
            psGet.setString(1, orderId);
            ResultSet rsUID = psGet.executeQuery();
            if (rsUID.next()) {
                int uID = rsUID.getInt("UserID");
                
                PreparedStatement psNotiK = conn.prepareStatement(queryNoti);
                psNotiK.setInt(1, uID);
                psNotiK.setString(2, "Đơn hàng #LUMA" + orderId + " đã chuyển sang: " + status);
                psNotiK.executeUpdate();

                PreparedStatement psNotiA = conn.prepareStatement(queryNoti);
                psNotiA.setInt(1, 1); 
                psNotiA.setString(2, "HỆ THỐNG: Đơn hàng #LUMA" + orderId + " đã được cập nhật trạng thái: " + status);
                psNotiA.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
            try { if (conn != null) conn.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- 7. LẤY TẤT CẢ ĐƠN HÀNG (Admin) ---
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT o.* FROM Orders o JOIN Users u ON o.UserID = u.UserID WHERE u.Role != 'Admin' ORDER BY o.OrderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // --- 8. LẤY ĐƠN HÀNG THEO USER ID ---
    public List<Order> getOrdersByUserID(int userId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), 
                        rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // --- 9. ĐẶT HÀNG & BÁO ADMIN ---
    public boolean placeOrder(int userId, double totalAmount, String phone, String address, String paymentMethod, List<CartItem> cartItems) {
        Connection conn2 = null;
        try {
            conn2 = new DBContext().getConnection();
            conn2.setAutoCommit(false);

            String sqlOrder = "INSERT INTO Orders (UserID, TotalAmount, ShippingPhone, ShippingAddress, Status) VALUES (?, ?, ?, ?, 'Chờ xác nhận')";
            PreparedStatement psOrder = conn2.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId); psOrder.setDouble(2, totalAmount); psOrder.setString(3, phone); psOrder.setString(4, address);
            psOrder.executeUpdate();

            ResultSet rsKey = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rsKey.next()) orderId = rsKey.getInt(1);

            String sqlD = "INSERT INTO OrderDetails (OrderID, VariantID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
            PreparedStatement psD = conn2.prepareStatement(sqlD);
            String sqlS = "UPDATE ShoeVariants SET StockQuantity = StockQuantity - ? WHERE VariantID = ?";
            PreparedStatement psS = conn2.prepareStatement(sqlS);
            for (CartItem item : cartItems) {
                psD.setInt(1, orderId); psD.setInt(2, item.getVariantId()); psD.setInt(3, item.getQuantity()); psD.setDouble(4, item.getPrice());
                psD.executeUpdate();
                psS.setInt(1, item.getQuantity()); psS.setInt(2, item.getVariantId());
                psS.executeUpdate();
            }

            String sqlP = "INSERT INTO Payments (OrderID, PaymentMethod, Amount, PaymentStatus) VALUES (?, ?, ?, 'Chưa thanh toán')";
            PreparedStatement psP = conn2.prepareStatement(sqlP);
            psP.setInt(1, orderId); psP.setString(2, paymentMethod); psP.setDouble(3, totalAmount);
            psP.executeUpdate();

            String sqlAdminNoti = "INSERT INTO Notifications (UserID, Message) VALUES (1, ?)";
            PreparedStatement psA = conn2.prepareStatement(sqlAdminNoti);
            psA.setString(1, "KHÁCH HÀNG: Có đơn hàng mới #LUMA" + orderId + " đang chờ duyệt!");
            psA.executeUpdate();

            conn2.commit();
            return true;
        } catch (Exception e) {
            try { if (conn2 != null) conn2.rollback(); } catch (Exception ex) {}
            return false;
        } finally {
            try { if (conn2 != null) conn2.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- 10. LẤY TIN CHO ADMIN DASHBOARD ---
    public List<String> getAdminSystemNotifications() {
        List<String> list = new ArrayList<>();
        String query = "SELECT Message FROM Notifications WHERE UserID = 1 ORDER BY CreatedAt DESC LIMIT 15";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Message"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}