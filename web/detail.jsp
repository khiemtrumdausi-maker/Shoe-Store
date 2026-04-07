<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết - ${detail.name}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Tổng thể */
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f8f9fa; margin: 0; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        
        /* Nút quay lại thông minh */
        .back-btn-box { width: 85%; margin: 25px auto 0; }
        .btn-back { 
            display: inline-flex; align-items: center; gap: 8px; 
            text-decoration: none; color: #64748b; font-size: 14px; 
            font-weight: 600; padding: 10px 18px; background: white; 
            border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            border: 1px solid #eee; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { color: #0056b3; transform: translateX(-5px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }

        /* Container Chi tiết */
        .container { display: flex; gap: 50px; background: white; padding: 40px; border-radius: 15px; width: 85%; margin: 20px auto 50px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); flex: 1; }
        .img-box { flex: 1; text-align: center; }
        .img-box img { width: 100%; max-width: 500px; border-radius: 12px; object-fit: cover; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        
        .info-box { flex: 1; display: flex; flex-direction: column; }
        .product-title { font-size: 32px; font-weight: 800; margin: 0 0 15px 0; color: #0f172a; }
        
        .price-box { margin-bottom: 25px; border-bottom: 1px solid #f1f5f9; padding-bottom: 20px; }
        .price { color: #e63946; font-size: 30px; font-weight: 800; }
        .old-price { text-decoration: line-through; color: #adb5bd; font-size: 18px; margin-left: 12px; }
        
        .desc { font-size: 15px; color: #64748b; line-height: 1.7; margin-bottom: 30px; }
        
        /* Chọn Size (Radio Button Custom) */
        .size-container { margin-bottom: 30px; }
        .size-title { font-weight: 700; margin-bottom: 15px; display: block; font-size: 16px; color: #334155; }
        .size-options { display: flex; flex-wrap: wrap; gap: 12px; }
        .size-options input[type="radio"] { display: none; }
        .size-options label { 
            padding: 12px 22px; border: 2px solid #e2e8f0; border-radius: 8px; 
            cursor: pointer; text-align: center; background: #fff; 
            font-weight: 700; transition: 0.2s; min-width: 45px; 
        }
        .size-options label:hover { border-color: #0056b3; color: #0056b3; }
        .size-options input[type="radio"]:checked + label { background: #0f172a; color: white; border-color: #0f172a; box-shadow: 0 4px 10px rgba(0,0,0,0.2); }
        .size-options input[type="radio"]:disabled + label { background: #f8fafc; color: #cbd5e1; border-color: #f1f5f9; text-decoration: line-through; cursor: not-allowed; }

        /* Mẹo chọn size */
        .size-guide { background: #eff6ff; padding: 18px; border-radius: 10px; font-size: 13.5px; color: #1e40af; margin-bottom: 30px; line-height: 1.6; border-left: 5px solid #3b82f6; }
        .size-guide i { color: #3b82f6; margin-right: 8px; }

        .stock-info { font-size: 13px; color: #10b981; margin-top: 10px; display: flex; align-items: center; gap: 6px; font-weight: 600; }

        /* Action box */
        .action-box { display: flex; gap: 20px; align-items: flex-end; margin-top: auto; }
        .quantity-box { display: flex; flex-direction: column; }
        .quantity-box label { font-weight: 700; margin-bottom: 10px; font-size: 14px; color: #334155; }
        .quantity-box input { padding: 12px; width: 65px; border: 1px solid #e2e8f0; border-radius: 8px; text-align: center; font-size: 18px; font-weight: 800; }
        
        .btn-add { 
            flex: 1; background: #0f172a; color: white; padding: 16px; 
            border: none; border-radius: 8px; font-size: 16px; cursor: pointer; 
            font-weight: 800; text-transform: uppercase; transition: 0.3s; 
            display: flex; justify-content: center; align-items: center; gap: 10px; 
        }
        .btn-add:hover { background: #2563eb; transform: translateY(-2px); box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3); }

        @media (max-width: 900px) {
            .container { flex-direction: column; padding: 25px; width: 90%; }
            .img-box img { max-width: 100%; }
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="back-btn-box">
        <button onclick="history.back()" class="btn-back">
            <i class="fas fa-arrow-left"></i> Quay lại trang trước
        </button>
    </div>

    <div class="container">
        <div class="img-box">
            <img src="${pageContext.request.contextPath}/images/${detail.image.replace('images/', '')}" alt="Ảnh ${detail.name}">
        </div>

        <div class="info-box">
            <h1 class="product-title">${detail.name}</h1>
            
            <div class="price-box">
                <c:choose>
                    <c:when test="${detail.discountPrice > 0}">
                        <span class="price"><fmt:formatNumber value="${detail.discountPrice}" pattern="#,###"/> đ</span>
                        <span class="old-price"><fmt:formatNumber value="${detail.price}" pattern="#,###"/> đ</span>
                    </c:when>
                    <c:otherwise>
                        <span class="price"><fmt:formatNumber value="${detail.price}" pattern="#,###"/> đ</span>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <p class="desc">${detail.description != null ? detail.description : "Đôi giày mang phong cách hiện đại, hỗ trợ vận động tối ưu và cực kỳ êm ái cho đôi chân của bạn."}</p>
            
            <div class="size-guide">
                <strong><i class="fas fa-ruler-horizontal"></i> Mẹo chọn kích cỡ:</strong><br>
                Bảng size VN/EU dựa trên chiều dài bàn chân: Nữ (35-40), Nam (39-45). <br>
                <em>*Nên đo chân vào cuối ngày, cộng thêm 0.5 - 1cm để tạo độ thoải mái.</em>
            </div>
            
            <form action="addToCart" method="post" style="display: flex; flex-direction: column; flex: 1;">
                <input type="hidden" name="shoeId" value="${detail.id}">
                
                <div class="size-container">
                    <span class="size-title">Chọn Size (VN/EU):</span>
                    <div class="size-options">
                        <c:forEach items="${standardSizes}" var="sz">
                            <c:set var="variant" value="${variantMap[sz]}" />
                            <c:choose>
                                <c:when test="${not empty variant}">
                                    <input type="radio" name="variantId" id="size_${sz}" value="${variant.variantID}" required>
                                    <label for="size_${sz}" title="Còn ${variant.stockQuantity} đôi">${sz}</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="radio" name="variantId" id="size_${sz}" value="" disabled>
                                    <label for="size_${sz}" title="Hết hàng">${sz}</label>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <span class="stock-info"><i class="fas fa-check-circle"></i> Sản phẩm có sẵn tại kho</span>
                </div>
                
                <div class="action-box">
                    <div class="quantity-box">
                        <label>Số lượng</label>
                        <input type="number" name="quantity" value="1" min="1" max="10" required>
                    </div>
                    
                    <button type="submit" class="btn-add">
                        <i class="fas fa-cart-plus"></i> THÊM VÀO GIỎ HÀNG
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>