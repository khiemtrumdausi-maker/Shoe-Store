<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử đơn hàng - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f1f5f9; margin: 0; display: flex; flex-direction: column; min-height: 100vh; }
        .container { width: 75%; margin: 40px auto; flex: 1; }
        
        /* Nút quay lại thông minh */
        .back-btn { 
            display: inline-flex; align-items: center; gap: 8px; 
            text-decoration: none; color: #64748b; font-size: 14px; 
            font-weight: 600; margin-bottom: 20px; transition: 0.3s; 
            padding: 8px 15px; background: white; border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05); border: none; cursor: pointer;
        }
        .back-btn:hover { color: #0056b3; transform: translateX(-5px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }

        h2 { color: #0f172a; margin-bottom: 25px; display: flex; align-items: center; gap: 12px; font-size: 26px; font-weight: 800; }
        .order-card { 
            background: white; border-radius: 15px; padding: 30px; 
            margin-bottom: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            border-left: 6px solid #cbd5e1; transition: 0.3s;
        }
        .order-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #f1f5f9; padding-bottom: 18px; margin-bottom: 18px; }
        .order-id { font-weight: bold; color: #0056b3; font-size: 19px; }
        .status-badge { padding: 8px 16px; border-radius: 25px; font-size: 12px; font-weight: 700; display: flex; align-items: center; gap: 6px; }
        .st-pending { background: #fff7ed; color: #ea580c; border: 1px solid #fdba74; }
        .st-confirmed { background: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; }
        .order-body { display: grid; grid-template-columns: 2fr 1fr; gap: 20px; font-size: 15px; color: #475569; }
        .total-amount { font-size: 24px; color: #e63946; font-weight: 800; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <button onclick="history.back()" class="back-btn">
            <i class="fas fa-arrow-left"></i> Quay lại trang trước
        </button>

        <h2><i class="fas fa-box-open" style="color: #0056b3;"></i> Lịch sử đơn hàng</h2>

        <c:choose>
            <c:when test="${empty listOrder}">
                <div style="text-align: center; padding: 80px 20px; background: white; border-radius: 15px;">
                    <p>Bạn chưa có đơn hàng nào.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${listOrder}" var="o">
                    <div class="order-card" style="border-left-color: ${o.status == 'Chờ xác nhận' ? '#ea580c' : '#16a34a'}">
                        <div class="order-header">
                            <span class="order-id">#LUMA${o.orderID}</span>
                            <span class="status-badge ${o.status == 'Chờ xác nhận' ? 'st-pending' : 'st-confirmed'}">
                                <i class="fas ${o.status == 'Chờ xác nhận' ? 'fa-hourglass-half' : 'fa-check-circle'}"></i> 
                                ${o.status}
                            </span>
                        </div>
                        <div class="order-body">
                            <div class="order-info">
                                <p><i class="fas fa-calendar-day"></i> Ngày đặt: <b>${o.orderDate}</b></p>
                                <p><i class="fas fa-map-marker-alt"></i> Địa chỉ: <b>${o.shippingAddress}</b></p>
                                <p><i class="fas fa-phone-alt"></i> Điện thoại: <b>${o.shippingPhone}</b></p>
                            </div>
                            <div class="order-total">
                                <span style="color: #94a3b8; font-size: 13px;">TỔNG THANH TOÁN</span>
                                <span class="total-amount"><fmt:formatNumber value="${o.totalAmount}" pattern="#,###"/> đ</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>