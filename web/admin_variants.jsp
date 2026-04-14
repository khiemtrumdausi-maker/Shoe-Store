<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="dao.AdminDAO" %>
<%@ page import="entity.ShoeVariant" %>
<%@ page import="java.util.List" %>

<%
    // TỰ ĐỘNG FIX: Nếu Servlet chưa kịp ném listV sang, trang JSP sẽ tự đi lấy luôn
    if (request.getAttribute("listV") == null) {
        String sid = request.getParameter("sid");
        if(sid == null) sid = request.getParameter("id");
        if(sid != null) {
            AdminDAO dao = new AdminDAO();
            List<ShoeVariant> list = dao.getVariantsByShoeID(sid);
            request.setAttribute("listV", list);
        }
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý Size và Kho - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS giữ nguyên như của sếp vì đã rất đẹp rồi */
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
        .product-id-badge { background: #0056b3; color: white; padding: 4px 12px; border-radius: 20px; font-size: 18px; }
        .table-wrapper { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; overflow: hidden; margin-bottom: 30px; }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        th, td { padding: 15px 20px; border-bottom: 1px solid #f1f5f9; font-size: 14.5px; color: #334155; vertical-align: middle; }
        th { background-color: #eff6ff; color: #0056b3; font-weight: 700; text-transform: uppercase; font-size: 13px; letter-spacing: 0.5px; }
        .stock-number { font-weight: bold; color: #10b981; }
        .add-form-container { background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; }
        .add-form-container h3 { margin-top: 0; color: #0f172a; font-size: 18px; border-bottom: 1px solid #f1f5f9; padding-bottom: 15px; margin-bottom: 20px; }
        .form-row { display: flex; gap: 20px; align-items: flex-end; max-width: 600px; }
        .form-group { flex: 1; display: flex; flex-direction: column; }
        .form-group label { font-size: 13px; font-weight: 700; color: #475569; margin-bottom: 8px; text-transform: uppercase;}
        .form-group input { padding: 10px 15px; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 14px; outline: none; transition: 0.3s; font-family: inherit; }
        .btn-submit { background: #10b981; color: white; padding: 11px 25px; border: none; border-radius: 8px; font-weight: bold; font-size: 14px; cursor: pointer; transition: 0.3s; height: 42px; display: flex; align-items: center; gap: 8px;}
    </style>
</head>
<body>

    <div class="sidebar">
        <div class="sidebar-header">LUMA STORE</div>
        <div class="sidebar-menu">
            <a href="adminDashboard"><i class="fas fa-chart-pie"></i> Tổng quan</a>
            <a href="manager" class="active"><i class="fas fa-box-open"></i> Quản lý Sản phẩm</a>
            <a href="managerOrder"><i class="fas fa-shopping-cart"></i> Quản lý Đơn hàng</a>
            <a href="#"><i class="fas fa-users"></i> Quản lý Khách hàng</a>
        </div>
        <div class="sidebar-footer">
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
    </div>

    <div class="content">
        <a href="manager" class="btn-back"><i class="fas fa-arrow-left"></i> Quay lại danh sách sản phẩm</a>
        
        <h2 class="page-title">
            Quản lý Kho & Size cho Sản phẩm: <span class="product-id-badge">ID ${not empty param.sid ? param.sid : param.id}</span>
        </h2>
        
        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>Variant ID</th>
                        <th>Size</th>
                        <th>Số lượng tồn kho</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listV}" var="v">
                        <tr>
                            <td>#${v.variantID}</td>
                            <td style="font-weight: bold;">Size ${v.size}</td>
                            <td class="stock-number">${v.stockQuantity} đôi</td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty listV}">
                        <tr>
                            <td colspan="3" style="color: #94a3b8; font-style: italic; padding: 30px;">Sản phẩm này chưa có size nào trong kho.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="add-form-container">
            <h3><i class="fas fa-plus-circle" style="color: #0056b3; margin-right: 8px;"></i> Thêm Size Mới</h3>
            <form action="addVariant" method="post">
                <input type="hidden" name="shoeID" value="${not empty param.sid ? param.sid : param.id}">
                <div class="form-row">
                    <div class="form-group">
                        <label>Nhập Size</label>
                        <input type="number" name="size" placeholder="VD: 40" required>
                    </div>
                    <div class="form-group">
                        <label>Số lượng kho</label>
                        <input type="number" name="stock" placeholder="VD: 50" min="1" required>
                    </div>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> Thêm vào kho
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>