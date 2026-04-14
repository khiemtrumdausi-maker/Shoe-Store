<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.OrderDAO" %>

<%
    // LẤY DỮ LIỆU THÔNG BÁO HỆ THỐNG MỚI NHẤT CHO ADMIN
    OrderDAO odao = new OrderDAO();
    List<String> adminNotis = odao.getAdminSystemNotifications();
    request.setAttribute("adminNotis", adminNotis);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
        .stat-box h3 { font-size: 13px; color: #64748b; font-weight: 600; margin: 0 0 10px 0; text-transform: uppercase; letter-spacing: 0.5px;}
        .stat-box p { font-size: 22px; font-weight: 800; color: #0f172a; margin: 0; }
        
        .bottom-container { display: grid; grid-template-columns: 1.5fr 1fr; gap: 25px; align-items: start; }
        .panel { background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; }
        .panel h3 { font-size: 18px; font-weight: 800; color: #0056b3; margin-top: 0; margin-bottom: 20px; border-bottom: 2px solid #eff6ff; padding-bottom: 10px; display: flex; align-items: center; gap: 10px; }
        
        /* Style cho danh sách thông báo trượt */
        .notification-list { max-height: 400px; overflow-y: auto; padding-right: 5px; }
        .notification-list::-webkit-scrollbar { width: 5px; }
        .notification-list::-webkit-scrollbar-thumb { background: #e2e8f0; border-radius: 10px; }
        
        .noti-item { 
            padding: 15px; border-left: 4px solid #0056b3; background: #f8fafc; 
            margin-bottom: 12px; border-radius: 0 8px 8px 0; transition: 0.2s;
        }
        .noti-item:hover { background: #f1f5f9; }
        .noti-item.order-new { border-left-color: #10b981; }
        .noti-item.order-cancel { border-left-color: #e63946; }
        
        .noti-content { font-size: 14px; color: #334155; line-height: 1.5; margin: 0; }
        .noti-time { font-size: 11px; color: #94a3b8; display: block; margin-top: 8px; font-weight: 600; }
        
        .activity-status { display: flex; align-items: center; gap: 15px; padding: 20px; background: #f0fdf4; border-radius: 10px; color: #15803d; font-weight: 600; }
        .activity-status i { font-size: 24px; }
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
        <h2 class="page-title">Hệ thống quản trị</h2>
        
        <div class="stats-container">
            <div class="stat-box primary">
                <h3>Tổng Doanh Thu</h3>
                <p><fmt:formatNumber value="${stats.totalRevenue}" type="number" /> đ</p>
            </div>

            <div class="stat-box success">
                <h3>Đơn Hàng Mới</h3>
                <p>${stats.totalOrders} Đơn</p>
            </div>

            <div class="stat-box warning">
                <h3>Khách Hàng</h3>
                <p>${stats.totalCustomers} Người</p>
            </div>

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
            <div class="panel">
                <h3><i class="fas fa-tasks"></i> Trạng thái vận hành</h3>
                <div class="activity-status">
                    <i class="fas fa-shield-alt"></i>
                    <div>
                        Hệ thống đang hoạt động bình thường
                        <div style="font-size: 12px; font-weight: normal; opacity: 0.8;">Toàn bộ dữ liệu đã được đồng bộ với Database.</div>
                    </div>
                </div>
                <div style="margin-top: 20px; padding: 15px; border: 1px dashed #cbd5e1; border-radius: 8px; color: #64748b; font-size: 13px;">
                    <i class="fas fa-info-circle"></i> Mẹo: Sếp có thể qua phần Quản lý đơn hàng để cập nhật trạng thái nhanh cho khách.
                </div>
            </div>
            
            <div class="panel">
                <h3><i class="fas fa-bell"></i> Thông báo hệ thống</h3>
                <div class="notification-list">
                    <c:choose>
                        <c:when test="${not empty adminNotis}">
                            <c:forEach items="${adminNotis}" var="noti">
                                <div class="noti-item ${noti.contains('hủy') ? 'order-cancel' : (noti.contains('mới') ? 'order-new' : '')}">
                                    <p class="noti-content">
                                        <c:choose>
                                            <c:when test="${noti.contains('mới')}"><i class="fas fa-shopping-basket" style="color:#10b981"></i></c:when>
                                            <c:when test="${noti.contains('hủy')}"><i class="fas fa-times-circle" style="color:#e63946"></i></c:when>
                                            <c:otherwise><i class="fas fa-info-circle" style="color:#0056b3"></i></c:otherwise>
                                        </c:choose>
                                        &nbsp;${noti}
                                    </p>
                                    <span class="noti-time"><i class="far fa-clock"></i> Cập nhật từ Database</span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="text-align: center; padding: 40px 0; color: #94a3b8;">
                                <i class="fas fa-comment-slash" style="font-size: 30px; margin-bottom: 10px; display: block;"></i>
                                Chưa có hoạt động nào mới.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

</body>
</html>