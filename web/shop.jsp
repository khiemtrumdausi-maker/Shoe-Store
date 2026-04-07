<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cửa Hàng - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Tổng thể */
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f8f9fa; margin: 0; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        a { text-decoration: none; }
        
        /* BỐ CỤC TRANG SHOP */
        .shop-container { display: flex; gap: 30px; width: 90%; margin: 30px auto; flex: 1; }
        
        /* CỘT TRÁI: BỘ LỌC */
        .sidebar { flex: 0 0 250px; background: white; padding: 20px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); height: fit-content; position: sticky; top: 90px; }
        .filter-title { font-size: 18px; font-weight: bold; margin-top: 0; margin-bottom: 20px; border-bottom: 2px solid #eee; padding-bottom: 10px; }
        .filter-group { margin-bottom: 20px; }
        .filter-group label { display: block; font-weight: bold; margin-bottom: 8px; color: #555; font-size: 14px; }
        .filter-group input[type="text"], .filter-group select, .filter-group input[type="number"] { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; }
        .price-range { display: flex; align-items: center; gap: 10px; }
        .price-range input { width: 45%; }
        .btn-filter { width: 100%; background: #0056b3; color: white; padding: 12px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: 0.2s; margin-top: 10px; }
        .btn-filter:hover { background: #004494; }
        .btn-reset { width: 100%; background: #e2e8f0; color: #475569; padding: 12px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; transition: 0.2s; margin-top: 10px; display: block; text-align: center; box-sizing: border-box; }
        .btn-reset:hover { background: #cbd5e1; }

        /* CỘT PHẢI: LƯỚI SẢN PHẨM */
        .main-content { flex: 1; }
        .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .product-card { background: white; padding: 15px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; transition: all 0.3s; border: 1px solid #f0f0f0; display: flex; flex-direction: column; justify-content: space-between; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); border-color: #0056b3; }
        
        /* CSS Ảnh: Chống méo, bo góc đồng bộ Admin */
        .product-card img { 
            width: 100%; 
            height: 220px; 
            object-fit: cover; 
            border-radius: 8px; 
            margin-bottom: 15px; 
            background-color: #fbfcfd;
        }

        .product-title { font-size: 15px; font-weight: 600; color: #333; height: 40px; overflow: hidden; margin-bottom: 10px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; }
        .price-box { margin-bottom: 15px; }
        .price { color: #e63946; font-weight: bold; font-size: 17px; }
        .old-price { text-decoration: line-through; color: #adb5bd; font-size: 13px; margin-left: 8px; }
        .btn-detail { display: block; padding: 10px 0; background-color: #0056b3; color: white; border-radius: 6px; font-weight: bold; margin-top: 15px; }
        
        .empty-result { grid-column: span 3; text-align: center; padding: 50px; color: #888; font-size: 18px; }
    </style>
</head>
<body>

    <c:set var="activePage" value="shop" scope="request" />
    <%@ include file="header.jsp" %>

    <div class="shop-container">
        <aside class="sidebar">
            <h3 class="filter-title"><i class="fas fa-filter"></i> BỘ LỌC TÌM KIẾM</h3>
            <form action="shop" method="get">
                <div class="filter-group">
                    <label>Tên sản phẩm:</label>
                    <input type="text" name="search" placeholder="Nhập từ khóa..." value="${searchVal}">
                </div>

                <div class="filter-group">
                    <label>Thương hiệu:</label>
                    <select name="brand">
                        <option value="">-- Tất cả --</option>
                        <c:forEach items="${brands}" var="b">
                            <option value="${b.key}" ${brandVal == b.key ? 'selected' : ''}>${b.value}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Loại giày:</label>
                    <select name="category">
                        <option value="">-- Tất cả --</option>
                        <c:forEach items="${categories}" var="c">
                            <option value="${c.key}" ${categoryVal == c.key ? 'selected' : ''}>${c.value}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Giới tính:</label>
                    <select name="gender">
                        <option value="">-- Tất cả --</option>
                        <option value="1" ${genderVal == '1' ? 'selected' : ''}>Giày Nam</option>
                        <option value="2" ${genderVal == '2' ? 'selected' : ''}>Giày Nữ</option>
                        <option value="3" ${genderVal == '3' ? 'selected' : ''}>Unisex</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Khoảng giá (VNĐ):</label>
                    <div class="price-range">
                        <input type="number" name="minPrice" placeholder="Từ..." value="${minPriceVal}" min="0">
                        <span>-</span>
                        <input type="number" name="maxPrice" placeholder="Đến..." value="${maxPriceVal}" min="0">
                    </div>
                </div>

                <button type="submit" class="btn-filter"><i class="fas fa-search"></i> ÁP DỤNG LỌC</button>
                <a href="shop" class="btn-reset">Xóa Bộ Lọc</a>
            </form>
        </aside>

        <main class="main-content">
            <h2 style="margin-top: 0;">Sản Phẩm Của Chúng Tôi</h2>
            <div class="product-grid">
                <c:choose>
                    <c:when test="${not empty listS}">
                        <c:forEach items="${listS}" var="o">
                            <div class="product-card">
                                <div>
                                    <img src="${o.image}" 
                                         alt="${o.name}" 
                                         onerror="this.onerror=null; this.src='https://placehold.co/300x300/f1f5f9/94a3b8?text=Luma+Store'">
                                    
                                    <div class="product-title" title="${o.name}">${o.name}</div>
                                </div>
                                <div>
                                    <div class="price-box">
                                        <c:choose>
                                            <c:when test="${o.discountPrice > 0}">
                                                <span class="price"><fmt:formatNumber value="${o.discountPrice}" pattern="#,###"/> đ</span>
                                                <span class="old-price"><fmt:formatNumber value="${o.price}" pattern="#,###"/> đ</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="price"><fmt:formatNumber value="${o.price}" pattern="#,###"/> đ</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <a href="detail?sid=${o.id}" class="btn-detail">Xem chi tiết</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-result">
                            <i class="fas fa-box-open" style="font-size: 50px; color: #ddd; margin-bottom: 15px;"></i>
                            <p>Không tìm thấy sản phẩm nào phù hợp với bộ lọc của bạn.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>