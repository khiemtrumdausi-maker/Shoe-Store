<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { display: flex; flex-direction: column; min-height: 100vh; margin: 0; background: #f8f9fa; font-family: 'Segoe UI', sans-serif; }
        .success-wrapper { flex: 1; display: flex; justify-content: center; align-items: center; padding: 50px 20px; }
        .success-card { background: white; padding: 50px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); max-width: 600px; width: 100%; text-align: center; }
        
        .icon-check { font-size: 70px; color: #10b981; margin-bottom: 25px; animation: scaleIn 0.5s ease-out; }
        .success-card h1 { color: #0f172a; font-size: 28px; font-weight: 900; margin-bottom: 15px; }
        .success-card p { color: #64748b; font-size: 16px; line-height: 1.6; margin-bottom: 10px; }
        
        /* Thông báo quan trọng về Admin */
        .admin-notice { background: #f0f9ff; border-left: 4px solid #0056b3; padding: 15px; margin: 25px 0; text-align: left; border-radius: 4px; }
        .admin-notice i { color: #0056b3; margin-right: 10px; }
        .admin-notice span { font-size: 14px; color: #1e40af; font-weight: 600; }

        .btn-group { display: flex; gap: 15px; justify-content: center; margin-top: 30px; }
        .btn { padding: 12px 25px; border-radius: 8px; font-weight: bold; text-decoration: none; transition: 0.3s; font-size: 14px; }
        .btn-home { background: #0056b3; color: white; }
        .btn-home:hover { background: #004494; transform: translateY(-2px); }
        .btn-history { background: white; color: #334155; border: 1px solid #e2e8f0; }
        .btn-history:hover { background: #f8fafc; }

        @keyframes scaleIn {
            0% { transform: scale(0); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="success-wrapper">
        <div class="success-card">
            <i class="fas fa-check-circle icon-check"></i>
            <h1>ĐẶT HÀNG HOÀN TẤT!</h1>
            <p>Cảm ơn bạn đã tin tưởng và lựa chọn sản phẩm tại <strong>Luma Store</strong>.</p>
            
            <div class="admin-notice">
                <i class="fas fa-clock"></i>
                <span>Trạng thái: <strong>Đang chờ xác nhận</strong></span>
                <p style="margin: 5px 0 0 25px; font-size: 13px; color: #1e40af; font-weight: 400;">
                    Đơn hàng của bạn đã được gửi đến hệ thống. Admin sẽ kiểm tra và xác nhận trong giây lát.
                </p>
            </div>

            <p>Chúng tôi sẽ liên hệ với bạn qua số điện thoại <strong>${sessionScope.acc.phone}</strong> ngay sau khi đơn hàng được duyệt.</p>

            <div class="btn-group">
                <a href="home" class="btn btn-home">Tiếp tục mua sắm</a>
                <a href="my-orders" class="btn btn-history">Xem lịch sử đơn hàng</a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>