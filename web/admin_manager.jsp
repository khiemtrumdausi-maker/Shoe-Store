<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Sản Phẩm - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 1. Reset & Global */
        body { margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8fafc; display: flex; height: 100vh; overflow: hidden; }

        /* 2. Sidebar (Nền trắng, chữ xanh chuẩn Luma) */
        .sidebar { width: 260px; background-color: #ffffff; display: flex; flex-direction: column; box-shadow: 2px 0 15px rgba(0,0,0,0.04); z-index: 10; }
        .sidebar-header { padding: 25px 20px; font-size: 24px; font-weight: 900; color: #0056b3; border-bottom: 1px solid #f1f5f9; letter-spacing: 1px; text-align: center; }
        .sidebar-menu { list-style: none; padding: 0; margin: 20px 0; flex: 1; }
        .sidebar-menu a { display: flex; align-items: center; padding: 15px 25px; color: #64748b; text-decoration: none; font-size: 15px; font-weight: 600; transition: 0.3s; border-left: 4px solid transparent; }
        .sidebar-menu a i { margin-right: 15px; font-size: 18px; width: 20px; text-align: center; }
        .sidebar-menu a:hover { background-color: #eff6ff; color: #0056b3; }
        
        /* Đang ở trang Quản lý Sản phẩm -> Class active */
        .sidebar-menu a.active { background-color: #eff6ff; color: #0056b3; border-left: 4px solid #0056b3; }

        .sidebar-footer { padding: 20px; border-top: 1px solid #f1f5f9; }
        .sidebar-footer a { color: #e63946; text-decoration: none; font-weight: bold; font-size: 15px; display: flex; align-items: center; transition: 0.3s; }
        .sidebar-footer a i { margin-right: 10px; }
        .sidebar-footer a:hover { color: #dc2626; background-color: #fef2f2; padding-left: 10px; border-radius: 8px;}

        /* 3. Main Content */
        .content { flex: 1; padding: 30px 40px; overflow-y: auto; }
        
        /* Header của trang (Tiêu đề + Nút thêm) */
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .page-title { font-size: 26px; font-weight: 800; color: #0f172a; margin: 0; }
        
        /* Nút Thêm Giày Mới */
        .btn-add { 
            background-color: #0056b3; color: white; padding: 10px 20px; border-radius: 8px; 
            text-decoration: none; font-weight: 600; font-size: 15px; display: flex; align-items: center; 
            gap: 8px; transition: 0.3s; box-shadow: 0 4px 10px rgba(0,86,179,0.2); border: none; cursor: pointer;
        }
        .btn-add:hover { background-color: #004494; transform: translateY(-2px); }

        /* 4. Khung Bảng (Table) */
        .table-wrapper {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.03);
            border: 1px solid #f1f5f9;
            overflow: hidden; 
        }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        th, td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; font-size: 14.5px; color: #334155; vertical-align: middle; }
        th { background-color: #eff6ff; color: #0056b3; font-weight: 700; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        tr:last-child td { border-bottom: none; }
        tr:hover { background-color: #f8fafc; }

        /* Cột ảnh sản phẩm */
        .img-preview { width: 60px; height: 60px; object-fit: cover; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); border: 1px solid #e2e8f0; }

        /* Cột hành động (Links) */
        .action-links { display: flex; justify-content: center; gap: 8px; }
        .action-links a { text-decoration: none; font-weight: 600; font-size: 13px; transition: 0.2s; padding: 6px 10px; border-radius: 6px; display: inline-flex; align-items: center; gap: 5px; }
        .btn-size { color: #0056b3; background: #eff6ff; }
        .btn-edit { color: #f59e0b; background: #fef3c7; }
        .btn-delete { color: #e63946; background: #fee2e2; }
        
        .action-links a:hover { opacity: 0.8; transform: scale(1.05); }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">
            LUMA STORE
        </div>
        <div class="sidebar-menu">
            <a href="adminDashboard"><i class="fas fa-chart-pie"></i> Tổng quan</a>
            <a href="manager" class="active"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a>
            <a href="managerOrder"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            <a href="managerUser"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
        </div>
        <div class="sidebar-footer">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="content">
        <div class="page-header">
            <h2 class="page-title">Danh sách Sản phẩm</h2>
            <a href="add_shoe.jsp" class="btn-add"><i class="fas fa-plus"></i> Thêm Sản phẩm</a>
        </div>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th style="text-align: left;">Tên Sản phẩm</th>
                        <th>Ảnh</th>
                        <th>Giá Gốc</th>
                        <th>Giá Khuyến Mãi</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listS}" var="o">
                        <tr>
                            <td>${o.id}</td>
                            <td style="text-align: left; font-weight: 600;">${o.name}</td>
                            <td>
                                <img src="${o.image}" alt="${o.name}" class="img-preview" onerror="this.onerror=null; this.src='https://placehold.co/60x60/eeeeee/999999?text=No+Img'">
                            </td>
                            <td style="color: #64748b; text-decoration: line-through;">${o.price} đ</td>
                            
                            <td style="color: #e63946; font-weight: bold;">${o.discountPrice} đ</td>
                            
                            <td class="action-links">
                                <a href="admin_variants.jsp?id=${o.id}" class="btn-size"><i class="fas fa-tags"></i> Kho/Size</a>
                                <a href="loadShoe?sid=${o.id}" class="btn-edit"><i class="fas fa-edit"></i> Sửa</a>
                                <a href="deleteControl?id=${o.id}" class="btn-delete"><i class="fas fa-trash-alt"></i> Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>