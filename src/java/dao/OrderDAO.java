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

    // --- HÀM ĐẾM SỐ ĐƠN HÀNG ĐÃ HỦY (MỚI THÊM) ---
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

    // --- HÀM HỦY ĐƠN HÀNG ---
    public void cancelOrder(String orderId) {
        String queryOrder = "UPDATE Orders SET Status = 'Đã hủy' WHERE OrderID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(queryOrder);
            ps.setString(1, orderId);
            ps.executeUpdate();
            System.out.println(">>> Đã hủy thành công đơn hàng ID: " + orderId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- HÀM XÁC NHẬN ĐÃ NHẬN HÀNG ---
    public void confirmReceived(String orderId) {
        String queryOrder = "UPDATE Orders SET Status = 'Hoàn thành' WHERE OrderID = ?";
        String queryPayment = "UPDATE Payments SET PaymentStatus = 'Đã thanh toán' WHERE OrderID = ?";
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false); 
            ps = conn.prepareStatement(queryOrder);
            ps.setString(1, orderId);
            ps.executeUpdate();
            PreparedStatement psPayment = conn.prepareStatement(queryPayment);
            psPayment.setString(1, orderId);
            psPayment.executeUpdate();
            conn.commit();
        } catch (Exception e) {
            try { if(conn != null) conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
            try { if(conn != null) conn.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- LẤY THÔNG BÁO (Dạng String) ---
    public List<String> getNotisByUserID(int userId) {
        List<String> list = new ArrayList<>();
        String query = "SELECT Message FROM Notifications WHERE UserID = ? ORDER BY CreatedAt DESC LIMIT 5";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("Message"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // --- LẤY THÔNG BÁO (Dạng Object) ---
    public List<Notification> getNotifications(int userId) {
        List<Notification> list = new ArrayList<>();
        String query = "SELECT * FROM Notifications WHERE UserID = ? ORDER BY CreatedAt DESC LIMIT 10";
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
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void markNotiAsRead(int notiId) {
        String query = "UPDATE Notifications SET IsRead = 1 WHERE NotiID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, notiId);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

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
                String msg = "Đơn hàng #LUMA" + orderId + " đã chuyển sang: " + status;
                PreparedStatement psNoti = conn.prepareStatement(queryNoti);
                psNoti.setInt(1, uID);
                psNoti.setString(2, msg);
                psNoti.executeUpdate();
            }
            conn.commit();
        } catch (Exception e) {
            try { conn.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
        } finally {
            try { conn.setAutoCommit(true); } catch (Exception ex) {}
        }
    }

    // --- LẤY TẤT CẢ ĐƠN HÀNG CHO TRANG ADMIN (SỬA LẠI: HIỆN TOÀN BỘ TRỪ ĐƠN ADMIN) ---
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        // SỬA Ở ĐÂY: Chỉ gạt các đơn của Admin ra, còn lại lấy hết kể cả Hủy hay Hoàn thành
        String query = "SELECT o.* FROM Orders o "
                     + "JOIN Users u ON o.UserID = u.UserID "
                     + "WHERE u.Role != 'Admin' "
                     + "ORDER BY o.OrderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(
                    rs.getInt("OrderID"), 
                    rs.getInt("UserID"), 
                    rs.getString("OrderDate"), 
                    rs.getDouble("TotalAmount"), 
                    rs.getString("ShippingPhone"), 
                    rs.getString("ShippingAddress"), 
                    rs.getString("Status")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Order> getOrdersByUserID(int userId) {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

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

            String sqlDetail = "INSERT INTO OrderDetails (OrderID, VariantID, Quantity, UnitPrice) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = conn2.prepareStatement(sqlDetail);
            String sqlUpdateStock = "UPDATE ShoeVariants SET StockQuantity = StockQuantity - ? WHERE VariantID = ?";
            PreparedStatement psStock = conn2.prepareStatement(sqlUpdateStock);
            for (CartItem item : cartItems) {
                psDetail.setInt(1, orderId); psDetail.setInt(2, item.getVariantId()); psDetail.setInt(3, item.getQuantity()); psDetail.setDouble(4, item.getPrice());
                psDetail.executeUpdate();
                psStock.setInt(1, item.getQuantity()); psStock.setInt(2, item.getVariantId());
                psStock.executeUpdate();
            }
            String sqlPayment = "INSERT INTO Payments (OrderID, PaymentMethod, Amount, PaymentStatus) VALUES (?, ?, ?, 'Chưa thanh toán')";
            PreparedStatement psPayment = conn2.prepareStatement(sqlPayment);
            psPayment.setInt(1, orderId); psPayment.setString(2, paymentMethod); psPayment.setDouble(3, totalAmount);
            psPayment.executeUpdate();
            
            String sqlClearCart = "DELETE FROM Cart WHERE CartID = ?";
            PreparedStatement psClear = conn2.prepareStatement(sqlClearCart);
            for (CartItem item : cartItems) {
                psClear.setInt(1, item.getCartId());
                psClear.executeUpdate();
            }
            conn2.commit();
            return true;
        } catch (Exception e) {
            try { if (conn2 != null) conn2.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn2 != null) conn2.setAutoCommit(true); } catch (Exception ex) {}
        }
    }
}