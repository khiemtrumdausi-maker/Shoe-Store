<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Luma Store - Trang Chủ</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* CSS Tổng thể */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f8f9fa; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }
        
        /* --- SLIDER CSS --- */
        .slider-container { width: 100%; height: 500px; overflow: hidden; position: relative; background: #000; }
        .slider-wrapper { width: 200%; height: 100%; display: flex; animation: slideAuto 10s infinite; }
        .slide { width: 50%; height: 100%; position: relative; }
        .slide img { width: 100%; height: 100%; object-fit: cover; opacity: 0.8; }
        
        @keyframes slideAuto {
            0%, 45% { transform: translateX(0); }       
            50%, 95% { transform: translateX(-50%); }   
            100% { transform: translateX(0); }          
        }

        .slide-content { position: absolute; top: 50%; left: 10%; transform: translateY(-50%); color: white; max-width: 500px; z-index: 10; text-shadow: 0 2px 4px rgba(0,0,0,0.5); }
        .slide-content h2 { font-size: 48px; font-weight: 900; margin: 0 0 15px 0; text-transform: uppercase; letter-spacing: 1px; }
        .slide-content p { font-size: 18px; margin: 0 0 30px 0; line-height: 1.5; }
        .btn-shop-now { display: inline-block; padding: 12px 30px; background-color: #0056b3; color: white; border-radius: 30px; font-weight: bold; text-transform: uppercase; font-size: 14px; transition: 0.3s; }
        .btn-shop-now:hover { background-color: #ffffff; color: #0056b3; }

        /* --- THANH DỊCH VỤ --- */
        .service-bar { background: white; padding: 25px 0; box-shadow: 0 2px 10px rgba(0,0,0,0.03); border-bottom: 1px solid #eee; }
        .service-container { width: 85%; margin: 0 auto; display: flex; justify-content: space-around; text-align: center; }
        .service-item { display: flex; align-items: center; gap: 15px; }
        .service-icon { font-size: 32px; color: #0056b3; }
        .service-text h4 { margin: 0; font-size: 16px; font-weight: bold; color: #333; }
        .service-text p { margin: 3px 0 0 0; font-size: 13px; color: #777; }

        /* --- LƯỚI SẢN PHẨM --- */
        .main-content { flex: 1; width: 85%; margin: 50px auto; }
        .section-title { text-align: center; margin-bottom: 40px; font-size: 32px; font-weight: 800; color: #1a1a1a; position: relative; padding-bottom: 15px; }
        .section-title::after { content: ''; position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); width: 80px; height: 4px; background-color: #0056b3; border-radius: 2px; }
        
        .product-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; }
        .product-card { background: white; padding: 15px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; transition: all 0.3s ease; border: 1px solid #f0f0f0; display: flex; flex-direction: column; justify-content: space-between;}
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); border-color: #0056b3; }
        
        /* CSS Ảnh cho trang chủ (Chống lệch khung) */
        .product-card img { 
            width: 100%; 
            height: 230px; 
            object-fit: cover; 
            border-radius: 8px; 
            margin-bottom: 15px; 
            background-color: #f8fafc;
        }

        .product-title { font-size: 15px; font-weight: 600; color: #333; height: 40px; overflow: hidden; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; margin-bottom: 10px; padding: 0 5px;}
        .price-box { margin-bottom: 15px; }
        .price { color: #e63946; font-weight: bold; font-size: 17px; }
        .old-price { text-decoration: line-through; color: #adb5bd; font-size: 13px; margin-left: 8px; }
        .btn-detail { display: block; padding: 10px 0; background-color: #0056b3; color: white; border-radius: 6px; font-weight: bold; transition: 0.2s; font-size: 14px; }
        .btn-detail:hover { background-color: #004494; }
    </style>
</head>
<body>

    <c:set var="activePage" value="home" scope="request" />
    <%@ include file="header.jsp" %>

    <div class="slider-container">
        <div class="slider-wrapper">
            <div class="slide">
                <img src="${pageContext.request.contextPath}/images/banner.jpg" alt="Summer Sale">
                <div class="slide-content">
                    <h2>New Arrival</h2>
                    <p>Khám phá bộ sưu tập giày thể thao mới nhất. Phong cách năng động, trải nghiệm êm ái.</p>
                    <a href="shop" class="btn-shop-now">Mua ngay</a>
                </div>
            </div>
            <div class="slide">
                <img src="${pageContext.request.contextPath}/images/banner_moi_2.jpg" alt="Banner 2">
                <div class="slide-content">
                    <h2>Summer Sale</h2>
                    <p>Ưu đãi cực sốc lên tới 50% cho các dòng giày chạy bộ hot nhất. Đừng bỏ lỡ!</p>
                    <a href="shop" class="btn-shop-now">Xem ưu đãi</a>
                </div>
            </div>
        </div>
    </div>

    <div class="service-bar">
        <div class="service-container">
            <div class="service-item">
                <i class="fas fa-shipping-fast service-icon"></i>
                <div class="service-text">
                    <h4>Miễn phí vận chuyển</h4>
                    <p>Cho mọi đơn hàng toàn quốc</p>
                </div>
            </div>
            <div class="service-item">
                <i class="fas fa-shield-alt service-icon"></i>
                <div class="service-text">
                    <h4>Thanh toán an toàn</h4>
                    <p>Bảo mật thông tin 100%</p>
                </div>
            </div>
            
            <%-- SỬA Ở ĐÂY: Đổi Hoàn trả thành Cam Kết Chính Hãng --%>
            <div class="service-item">
                <i class="fas fa-award service-icon"></i>
                <div class="service-text">
                    <h4>Cam Kết Chính Hãng</h4>
                    <p>Chuẩn Authentic 100%</p>
                </div>
            </div>
        </div>
    </div>

    <main class="main-content">
        <h2 class="section-title">SẢN PHẨM NỔI BẬT</h2>
        <div class="product-grid">
            <c:forEach items="${listS}" var="o">
                <div class="product-card">
                    <div>
                        <img src="${pageContext.request.contextPath}/images/${o.image.replace('images/', '')}" 
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
        </div>
    </main>

    <%@ include file="footer.jsp" %>

</body>
</html>