<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán đơn hàng - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f8f9fa; margin: 0; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        .checkout-container { width: 85%; margin: 30px auto; display: flex; gap: 30px; flex: 1; }
        
        /* Cột trái: Form thông tin */
        .checkout-form { flex: 2; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .section-title { font-size: 20px; font-weight: bold; margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 20px; color: #0f172a; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 8px; color: #555; }
        .form-group input[type="text"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 15px; box-sizing: border-box; }
        
        .payment-methods { display: flex; flex-direction: column; gap: 10px; margin-bottom: 30px; }
        .payment-methods label { display: flex; align-items: center; gap: 10px; padding: 15px; border: 1px solid #ddd; border-radius: 6px; cursor: pointer; transition: 0.3s; }
        .payment-methods label:hover { border-color: #0056b3; background: #f0f8ff; }
        .payment-methods input[type="radio"] { width: 18px; height: 18px; }
        
        /* Cột phải: Hóa đơn */
        .order-summary { flex: 1; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); height: fit-content; position: sticky; top: 90px; }
        .summary-item { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; border-bottom: 1px dashed #eee; padding-bottom: 15px; }
        .item-info { font-size: 14px; }
        .item-name { font-weight: bold; margin-bottom: 5px; color: #333; }
        .item-price { font-weight: bold; color: #e63946; }
        
        .total-row { display: flex; justify-content: space-between; font-size: 20px; font-weight: bold; color: #e63946; border-top: 2px solid #eee; padding-top: 15px; margin-top: 10px; }
        
        .btn-order { display: block; width: 100%; text-align: center; background: #0f172a; color: white; padding: 16px 0; border: none; border-radius: 6px; font-size: 18px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .btn-order:hover { background: #2563eb; transform: translateY(-2px); }
        
        .back-link { margin-bottom: 20px; display: inline-block; color: #0056b3; font-weight: bold; text-decoration: none; }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="checkout-container">
        <div class="checkout-form">
            <a href="cart" class="back-link"><i class="fas fa-arrow-left"></i> Quay lại Giỏ hàng</a>
            
            <h2 class="section-title">Thông tin giao hàng</h2>
            <p style="color: #dc3545; font-weight: bold;">${mess}</p>
            
            <form action="checkout" method="post">
                <div class="form-group">
                    <label>Họ và tên người nhận</label>
                    <input type="text" value="${sessionScope.acc.fullName}" readonly style="background: #f1f5f9; cursor: not-allowed;">
                </div>
                
                <div class="form-group">
                    <label>Số điện thoại liên hệ</label>
                    <input type="text" name="phone" value="${sessionScope.acc.phone}" placeholder="Nhập số điện thoại nhận hàng..." required>
                </div>
                
                <div class="form-group">
                    <label>Địa chỉ nhận hàng</label>
                    <input type="text" name="address" value="${sessionScope.acc.address}" placeholder="Số nhà, tên đường, phường/xã..." required>
                </div>
                
                <h2 class="section-title" style="margin-top: 40px;">Phương thức thanh toán</h2>
                <div class="payment-methods">
                    <label>
                        <input type="radio" name="paymentMethod" value="Tiền mặt" checked>
                        <i class="fas fa-money-bill-wave" style="color: #28a745; font-size: 20px;"></i> Thanh toán khi nhận hàng (COD)
                    </label>
                    <label>
                        <input type="radio" name="paymentMethod" value="Chuyển khoản">
                        <i class="fas fa-credit-card" style="color: #007bff; font-size: 20px;"></i> Chuyển khoản ngân hàng
                    </label>
                </div>
                
                <button type="submit" class="btn-order">XÁC NHẬN ĐẶT HÀNG</button>
            </form>
        </div>

        <div class="order-summary">
            <h3 class="section-title">Đơn hàng của bạn</h3>
            
            <c:forEach items="${listCart}" var="c">
                <div class="summary-item">
                    <div class="item-info">
                        <div class="item-name">${c.shoeName} (x${c.quantity})</div>
                        <div style="color: #666; font-size: 13px;">Size: ${c.size}</div>
                    </div>
                    <div class="item-price"><fmt:formatNumber value="${c.price * c.quantity}" pattern="#,###"/> đ</div>
                </div>
            </c:forEach>
            
            <div style="display: flex; justify-content: space-between; margin-top: 20px; color: #666;">
                <span>Phí vận chuyển:</span>
                <span style="color: #28a745; font-weight: bold;">Miễn phí</span>
            </div>
            
            <div class="total-row">
                <span>Tổng thanh toán:</span>
                <span><fmt:formatNumber value="${totalMoney}" pattern="#,###"/> đ</span>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>