<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sửa Sản Phẩm - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS giữ nguyên như bản cũ của sếp vì đã rất đẹp rồi */
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
        .btn-back { color: #64748b; text-decoration: none; font-size: 14.5px; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; margin-bottom: 20px; transition: 0.2s; }
        .btn-back:hover { color: #0056b3; transform: translateX(-5px); }
        .page-title { font-size: 24px; font-weight: 800; color: #0f172a; margin-top: 0; margin-bottom: 25px; display: flex; align-items: center; gap: 10px; }
        .product-id-badge { background: #f59e0b; color: white; padding: 4px 12px; border-radius: 20px; font-size: 16px; }
        .form-container { background: #fff; padding: 35px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; max-width: 700px; }
        .form-group { margin-bottom: 20px; display: flex; flex-direction: column; }
        .form-row { display: flex; gap: 20px; }
        .form-row .form-group { flex: 1; }
        .form-group label { font-size: 13.5px; font-weight: 700; color: #475569; margin-bottom: 8px; }
        .form-group input { padding: 12px 15px; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 14.5px; outline: none; transition: 0.3s; font-family: inherit; color: #1e293b; background-color: #fbfcfd; }
        .form-group input:focus { border-color: #0056b3; box-shadow: 0 0 0 3px rgba(0,86,179,0.1); background-color: #fff; }
        .form-actions { display: flex; gap: 15px; margin-top: 30px; border-top: 1px solid #f1f5f9; padding-top: 25px; }
        .btn-submit { background: #0056b3; color: white; padding: 12px 25px; border: none; border-radius: 8px; font-weight: bold; font-size: 15px; cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 8px; }
        .btn-submit:hover { background: #004494; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0,86,179,0.2); }
        .btn-cancel { background: #f1f5f9; color: #475569; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; font-size: 15px; transition: 0.3s; display: flex; align-items: center; justify-content: center; }
        .btn-cancel:hover { background: #e2e8f0; color: #0f172a; }
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">LUMA STORE</div>
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
        <a href="manager" class="btn-back"><i class="fas fa-arrow-left"></i> Quay lại danh sách sản phẩm</a>
        
        <h2 class="page-title">
            Chỉnh Sửa Sản Phẩm <span class="product-id-badge">ID: ${detail.id}</span>
        </h2>
        
        <div class="form-container">
            <form action="edit" method="post">
                <input type="hidden" name="id" value="${detail.id}">
                <input type="hidden" name="oldImage" value="${detail.image}">
                
                <div class="form-group">
                    <label>Tên giày</label>
                    <input type="text" name="name" value="${detail.name}" placeholder="Nhập tên sản phẩm..." required>
                </div>
                 
                <div class="form-group">
                    <label>Tên file ảnh (Trong thư mục images)</label>
                    <div style="display: flex; align-items: center;">
                        <span style="background: #e2e8f0; padding: 12px; border-radius: 8px 0 0 8px; border: 1px solid #cbd5e1; border-right: none; font-size: 14px; color: #475569;">images/</span>
                        <input type="text" name="image" 
                               value="${detail.image.replace('images/', '')}" 
                               style="border-radius: 0 8px 8px 0; flex: 1;" 
                               placeholder="VD: giay1.jpg">
                    </div>
                    <small style="color: #64748b; margin-top: 5px;">Ảnh cũ: <b>${detail.image}</b>. Nhập tên file mới để thay đổi.</small>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Giá gốc (VNĐ)</label>
                        <input type="number" name="price" value="${detail.price}" required>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá Sale (VNĐ)</label>
                        <input type="number" name="discount" value="${detail.discountPrice}" required>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Lưu Cập Nhật
                    </button>
                    <a href="manager" class="btn-cancel">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>

</body>
</html>