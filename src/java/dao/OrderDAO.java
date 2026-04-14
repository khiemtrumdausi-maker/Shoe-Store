package dao;

import context.DBContext;
import entity.Order;
import entity.CartItem;
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

    // --- LẤY THÔNG BÁO CHO USER ---
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // --- ADMIN DUYỆT ĐƠN + TỰ ĐẺ THÔNG BÁO ---
    public void updateOrderStatus(String orderId, String status) {
        String queryUpdate = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        String queryGetUID = "SELECT UserID FROM Orders WHERE OrderID = ?";
        String queryNoti = "INSERT INTO Notifications (UserID, Message) VALUES (?, ?)";
        
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false); 

            // 1. Cập nhật Status
            ps = conn.prepareStatement(queryUpdate);
            ps.setString(1, status);
            ps.setString(2, orderId);
            ps.executeUpdate();

            // 2. Tìm User
            PreparedStatement psGet = conn.prepareStatement(queryGetUID);
            psGet.setString(1, orderId);
            ResultSet rsUID = psGet.executeQuery();
            
            if (rsUID.next()) {
                int uID = rsUID.getInt("UserID");
                String msg = "Đơn hàng #LUMA" + orderId + " đã chuyển sang: " + status;
                
                // 3. Chèn Noti
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

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT * FROM Orders ORDER BY OrderDate DESC";
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
            
            // 1. Tạo Order
            String sqlOrder = "INSERT INTO Orders (UserID, TotalAmount, ShippingPhone, ShippingAddress, Status) VALUES (?, ?, ?, ?, 'Chờ xác nhận')";
            PreparedStatement psOrder = conn2.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, totalAmount);
            psOrder.setString(3, phone);
            psOrder.setString(4, address);
            psOrder.executeUpdate();
            
            ResultSet rsKey = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rsKey.next()) orderId = rsKey.getInt(1);

            // 2. Thêm Chi tiết đơn hàng & Trừ kho
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
            
            // 3. Thêm Payment
            String sqlPayment = "INSERT INTO Payments (OrderID, PaymentMethod, Amount, PaymentStatus) VALUES (?, ?, ?, 'Chưa thanh toán')";
            PreparedStatement psPayment = conn2.prepareStatement(sqlPayment);
            psPayment.setInt(1, orderId); psPayment.setString(2, paymentMethod); psPayment.setDouble(3, totalAmount);
            psPayment.executeUpdate();
            
            // =========================================================
            // 4. FIX LỖI: CHỈ XÓA NHỮNG MÓN ĐÃ MUA (Dựa theo CartID)
            // =========================================================
            String sqlClearCart = "DELETE FROM Cart WHERE CartID = ?";
            PreparedStatement psClear = conn2.prepareStatement(sqlClearCart);
            for (CartItem item : cartItems) {
                psClear.setInt(1, item.getCartId());
                psClear.executeUpdate();
            }
            // =========================================================

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