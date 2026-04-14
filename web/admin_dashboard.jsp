<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS GIỮ NGUYÊN NHƯ CỦA SẾP VÌ ĐÃ RẤT ĐẸP RỒI */
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; display: flex; height: 100vh; overflow: hidden; }
        .sidebar { width: 260px; background-color: #ffffff; display: flex; flex-direction: column; box-shadow: 2px 0 15px rgba(0,0,0,0.04); z-index: 10; }
        .sidebar-header { padding: 25px 20px; font-size: 24px; font-weight: 900; color: #0056b3; border-bottom: 1px solid #f1f5f9; letter-spacing: 1px; text-align: center; }
        .sidebar-menu { list-style: none; padding: 0; margin: 20px 0; flex: 1; }
        .sidebar-menu a { display: flex; align-items: center; padding: 15px 25px; color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600; transition: 0.3s; border-left: 4px solid transparent; }
        .sidebar-menu a i { margin-right: 15px; font-size: 18px; width: 20px; text-align: center; }
        .sidebar-menu a:hover { background-color: #eff6ff; color: #0056b3; }
        .sidebar-menu a.active { background-color: #eff6ff; color: #0056b3; border-left: 4px solid #0056b3; }
        .sidebar-footer { padding: 20px; border-top: 1px solid #f1f5f9; }
        .sidebar-footer a { color: #e63946; text-decoration: none; font-weight: bold; font-size: 15px; display: flex; align-items: center; transition: 0.3s; }
        .sidebar-footer a:hover { color: #dc2626; background-color: #fef2f2; padding-left: 10px; border-radius: 8px;}
        .content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-title { font-size: 26px; font-weight: 800; color: #0f172a; margin-top: 0; margin-bottom: 30px; }
        .stats-container { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-box { background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; border-bottom: 4px solid #ccc; transition: 0.3s; }
        .stat-box:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,86,179,0.1); }
        .stat-box.primary { border-bottom-color: #0056b3; }
        .stat-box.success { border-bottom-color: #10b981; }
        .stat-box.warning { border-bottom-color: #f59e0b; }
        .stat-box.danger { border-bottom-color: #e63946; }
        .stat-box h3 { font-size: 14px; color: #64748b; font-weight: 600; margin: 0 0 10px 0; text-transform: uppercase; letter-spacing: 0.5px;}
        .stat-box p { font-size: 24px; font-weight: 800; color: #0f172a; margin: 0; }
        .bottom-container { display: grid; grid-template-columns: 2fr 1fr; gap: 25px; }
        .panel { background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; }
        .panel h3 { font-size: 18px; font-weight: 800; color: #0056b3; margin-top: 0; margin-bottom: 15px; border-bottom: 2px solid #eff6ff; padding-bottom: 10px; }
        .activity-text { font-size: 14.5px; color: #334155; margin-bottom: 15px; display: flex; align-items: center; padding: 10px; background: #f8fafc; border-radius: 8px;}
        .activity-text i { color: #10b981; margin-right: 10px; font-size: 18px; }
        .notification { margin-bottom: 15px; border-left: 3px solid #0056b3; padding-left: 15px; background: #f8fafc; padding-top: 10px; padding-bottom: 10px; border-radius: 0 8px 8px 0;}
        .notification strong { font-size: 14px; color: #0f172a; display: block; margin-bottom: 5px; }
        .notification p { margin: 0 0 5px 0; font-size: 13.5px; color: #475569; line-height: 1.4; }
        .noti-time { font-size: 12px; color: #94a3b8; font-weight: 600;}
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">LUMA STORE</div>
        <div class="sidebar-menu">
            <a href="adminDashboard" class="active"><i class="fas fa-chart-pie"></i> Tổng quan</a>
            <a href="manager"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a>
            <a href="managerOrder"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            <a href="managerUser"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
        </div>
        <div class="sidebar-footer">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="content">
        <h2 class="page-title">Dashboard</h2>
        
        <div class="stats-container">
            <div class="stat-box primary">
                <h3>Tổng Doanh Thu</h3>
                <p>
                    <fmt:formatNumber value="${stats.totalRevenue}" type="number" /> đ
                </p>
            </div>

            <div class="stat-box success">
                <h3>Đơn Hàng Mới</h3>
                <p>${stats.totalOrders} Đơn</p>
            </div>

            <div class="stat-box warning">
                <h3>Khách Hàng</h3>
                <p>${stats.totalCustomers} Người</p>
            </div>

            <%-- SỬA Ở ĐÂY: Đổi Hoàn Tiền thành Đơn Đã Hủy và gọi biến canceledCount --%>
            <div class="stat-box danger">
                <h3>Đơn Đã Hủy</h3>
                <p>
                    <c:choose>
                        <c:when test="${not empty canceledCount}">${canceledCount}</c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose> Đơn
                </p>
            </div>
        </div>
        
        <div class="bottom-container">
            <div class="panel panel-main">
                <h3>Hoạt động gần đây</h3>
                <div class="activity-text">
                    <i class="fas fa-check-circle"></i> 
                    Mọi thứ đang vận hành ổn định.
                </div>
            </div>
            
            <div class="panel panel-side">
                <h3>Thông báo hệ thống</h3>
                <div class="notification">
                    <strong>Thông báo</strong>
                    <p>Hệ thống vừa cập nhật dữ liệu mới nhất.</p>
                    <span class="noti-time"><i class="far fa-clock"></i> Vừa xong</span>
                </div>
            </div>
        </div>
    </div>

</body>
</html>