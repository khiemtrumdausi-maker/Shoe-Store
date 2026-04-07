<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Đơn Hàng - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 1. Reset & Global */
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; display: flex; height: 100vh; overflow: hidden; }

        /* 2. Sidebar (Chuẩn Luma) */
        .sidebar { width: 260px; background-color: #ffffff; display: flex; flex-direction: column; box-shadow: 2px 0 15px rgba(0,0,0,0.04); z-index: 10; }
        .sidebar-header { padding: 25px 20px; font-size: 24px; font-weight: 900; color: #0056b3; border-bottom: 1px solid #f1f5f9; letter-spacing: 1px; text-align: center; }
        .sidebar-menu { list-style: none; padding: 0; margin: 20px 0; flex: 1; }
        .sidebar-menu a { display: flex; align-items: center; padding: 15px 25px; color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600; transition: 0.3s; border-left: 4px solid transparent; }
        .sidebar-menu a i { margin-right: 15px; font-size: 18px; width: 20px; text-align: center; }
        .sidebar-menu a:hover { background-color: #eff6ff; color: #0056b3; }
        
        /* Đang ở trang Đơn hàng -> Active */
        .sidebar-menu a.active { background-color: #eff6ff; color: #0056b3; border-left: 4px solid #0056b3; }

        .sidebar-footer { padding: 20px; border-top: 1px solid #f1f5f9; }
        .sidebar-footer a { color: #e63946; text-decoration: none; font-weight: bold; font-size: 15px; display: flex; align-items: center; transition: 0.3s; }
        .sidebar-footer a i { margin-right: 10px; }
        .sidebar-footer a:hover { color: #dc2626; background-color: #fef2f2; padding-left: 10px; border-radius: 8px;}

        /* 3. Main Content */
        .content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        .page-header { margin-bottom: 30px; }
        .page-title { font-size: 26px; font-weight: 800; color: #0f172a; margin: 0; }

        /* 4. Khung Bảng (Table) */
        .table-wrapper { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        th, td { padding: 16px 20px; border-bottom: 1px solid #f1f5f9; font-size: 14.5px; color: #334155; vertical-align: middle; }
        th { background-color: #eff6ff; color: #0056b3; font-weight: 700; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #f8fafc; }

        /* 5. Màu sắc Trạng thái (Status Badges) */
        .status-badge { padding: 6px 12px; border-radius: 20px; font-size: 12.5px; font-weight: bold; display: inline-block; }
        .status-pending { background-color: #fef3c7; color: #d97706; } /* Màu cam - Chờ xác nhận */
        .status-shipping { background-color: #d1fae5; color: #059669; } /* Màu xanh - Đang giao */
        .status-canceled { background-color: #fee2e2; color: #dc2626; } /* Màu đỏ - Đã hủy */

        /* 6. Nút Duyệt Đơn */
        .btn-approve { 
            background-color: #10b981; color: white; padding: 8px 14px; border-radius: 6px; 
            text-decoration: none; font-weight: 600; font-size: 13px; display: inline-flex; 
            align-items: center; gap: 6px; transition: 0.2s; border: none; cursor: pointer;
        }
        .btn-approve:hover { background-color: #059669; transform: scale(1.05); }
        .btn-approve i { font-size: 14px; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            LUMA STORE
        </div>
        <div class="sidebar-menu">
            <a href="adminDashboard"><i class="fas fa-chart-pie"></i> Tổng quan</a>
            <a href="manager"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a>
            <a href="managerOrder" class="active"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            <a href="managerUser"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
        </div>
        <div class="sidebar-footer">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="content">
        <div class="page-header">
            <h2 class="page-title">Danh Sách Đơn Hàng</h2>
        </div>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Mã Đơn</th>
                        <th>Khách ID</th>
                        <th>Ngày Đặt</th>
                        <th>Số điện thoại</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listO}" var="o">
                        <tr>
                            <td style="font-weight: bold; color: #0f172a;">#${o.orderID}</td>
                            <td>${o.userID}</td>
                            <td>${o.orderDate}</td>
                            <td>${o.shippingPhone}</td>
                            <td style="color: #0056b3; font-weight: bold;">${o.totalAmount} đ</td>
                            
                            <td>
                                <c:choose>
                                    <c:when test="${o.status == 'Chờ xác nhận'}">
                                        <span class="status-badge status-pending">${o.status}</span>
                                    </c:when>
                                    <c:when test="${o.status == 'Đang giao' || o.status == 'Đã giao'}">
                                        <span class="status-badge status-shipping">${o.status}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-canceled">${o.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            
                            <td>
                                <c:if test="${o.status == 'Chờ xác nhận'}">
                                    <a href="approveOrderControl?id=${o.orderID}" class="btn-approve">
                                        <i class="fas fa-check-circle"></i> Duyệt Đơn
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>