<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Khách hàng - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 1. Reset & Global */
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; display: flex; height: 100vh; overflow: hidden; }

        /* 2. Sidebar (Đầy đủ Menu và Footer) */
        .sidebar { width: 260px; background-color: #ffffff; display: flex; flex-direction: column; box-shadow: 2px 0 15px rgba(0,0,0,0.04); z-index: 10; }
        .sidebar-header { padding: 25px 20px; font-size: 24px; font-weight: 900; color: #0056b3; border-bottom: 1px solid #f1f5f9; letter-spacing: 1px; text-align: center; }
        .sidebar-menu { list-style: none; padding: 0; margin: 20px 0; flex: 1; }
        .sidebar-menu a { display: flex; align-items: center; padding: 15px 25px; color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600; transition: 0.3s; border-left: 4px solid transparent; }
        .sidebar-menu a i { margin-right: 15px; font-size: 18px; width: 20px; text-align: center; }
        .sidebar-menu a:hover { background-color: #eff6ff; color: #0056b3; }
        .sidebar-menu a.active { background-color: #eff6ff; color: #0056b3; border-left: 4px solid #0056b3; }
        
        /* Sidebar Footer (Nút Đăng xuất) */
        .sidebar-footer { padding: 20px; border-top: 1px solid #f1f5f9; }
        .sidebar-footer a { color: #e63946; text-decoration: none; font-weight: bold; font-size: 15px; display: flex; align-items: center; transition: 0.3s; }
        .sidebar-footer a i { margin-right: 10px; }
        .sidebar-footer a:hover { color: #dc2626; background-color: #fef2f2; padding-left: 10px; border-radius: 8px;}

        /* 3. Main Content */
        .content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-title { font-size: 26px; font-weight: 800; color: #0f172a; margin: 0 0 30px 0; }
        .table-wrapper { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th, td { padding: 16px 20px; border-bottom: 1px solid #f1f5f9; font-size: 14.5px; color: #334155; vertical-align: middle; }
        th { background-color: #eff6ff; color: #0056b3; font-weight: 700; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }

        /* 4. Trạng thái & Nút bấm */
        .status-badge { padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 700; display: inline-block; margin-right: 10px; }
        .status-active { background: #d1fae5; color: #059669; }
        .status-locked { background: #fee2e2; color: #dc2626; }

        .btn-toggle { 
            padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; font-weight: 600; 
            display: inline-flex; align-items: center; gap: 5px; transition: all 0.2s ease;
        }
        .btn-lock { color: #c2410c; background: #fff7ed; border: 1px solid #ffedd5; }
        .btn-lock:hover { background: #ffedd5; transform: translateY(-1px); }
        .btn-unlock { color: #1d4ed8; background: #eff6ff; border: 1px solid #dbeafe; }
        .btn-unlock:hover { background: #dbeafe; transform: translateY(-1px); }

        .user-info { display: flex; align-items: center; gap: 12px; }
        .user-avatar { width: 35px; height: 35px; border-radius: 50%; background: #e2e8f0; display: flex; align-items: center; justify-content: center; color: #64748b; font-weight: bold; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">LUMA STORE</div>
        <div class="sidebar-menu">
            <a href="adminDashboard"><i class="fas fa-chart-pie"></i> Tổng quan</a>
            <a href="manager"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a>
            <a href="managerOrder"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            <a href="managerUser" class="active"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
        </div>
        <div class="sidebar-footer">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="content">
        <h2 class="page-title">Quản lý Tài khoản Khách hàng</h2>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th style="width: 70px;">ID</th>
                        <th>Họ tên</th>
                        <th>Email / Tài khoản</th>
                        <th>Số điện thoại</th>
                        <th>Trạng thái & Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listU}" var="u">
                        <tr>
                            <td style="font-weight: bold;">#${u.userID}</td>
                            <td>
                                <div class="user-info">
                                    <div class="user-avatar">
                                        ${not empty u.fullName ? u.fullName.substring(0,1).toUpperCase() : "U"}
                                    </div>
                                    <div style="font-weight: 600;">${u.fullName}</div>
                                </div>
                            </td>
                            <td>${u.email}</td>
                            <td>${empty u.phone ? "<span style='color:#94a3b8;'>Chưa cập nhật</span>" : u.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${u.status == 1}">
                                        <span class="status-badge status-active">Đang hoạt động</span>
                                        <a href="toggleUser?uid=${u.userID}&status=1" class="btn-toggle btn-lock" 
                                           onclick="return confirm('Sếp có chắc chắn muốn KHÓA tài khoản ${u.fullName}?')">
                                            <i class="fas fa-lock"></i> Khóa
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-locked">Đã bị khóa</span>
                                        <a href="toggleUser?uid=${u.userID}&status=0" class="btn-toggle btn-unlock">
                                            <i class="fas fa-lock-open"></i> Mở khóa
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listU}">
                        <tr>
                            <td colspan="5" style="text-align: center; padding: 30px; color: #94a3b8; font-style: italic;">
                                Chưa có tài khoản khách hàng nào.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>