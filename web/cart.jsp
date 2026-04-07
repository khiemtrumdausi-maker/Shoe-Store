<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS Gốc của Khiêm + Tinh chỉnh */
        body { font-family: 'Segoe UI', Tahoma, sans-serif; background: #f8f9fa; margin: 0; color: #333; display: flex; flex-direction: column; min-height: 100vh; }
        .cart-container { width: 85%; margin: 30px auto; display: flex; gap: 30px; flex: 1; }
        
        /* Nút quay lại thông minh */
        .back-btn-box { width: 85%; margin: 20px auto 0; }
        .btn-back { 
            display: inline-flex; align-items: center; gap: 8px; 
            text-decoration: none; color: #64748b; font-size: 14px; 
            font-weight: 600; padding: 10px 18px; background: white; 
            border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); 
            border: 1px solid #eee; cursor: pointer; transition: 0.3s;
        }
        .btn-back:hover { color: #0056b3; transform: translateX(-5px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }

        .cart-items { flex: 2; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .cart-title { font-size: 24px; font-weight: bold; margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 20px; }
        
        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding-bottom: 15px; color: #888; font-size: 14px; text-transform: uppercase; border-bottom: 1px solid #eee; }
        td { padding: 20px 0; border-bottom: 1px solid #eee; vertical-align: middle; }
        
        .product-info { display: flex; gap: 15px; align-items: center; }
        .product-info img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; border: 1px solid #eee; }
        .product-name { font-weight: bold; font-size: 16px; margin-bottom: 5px; }
        .product-size { font-size: 13px; color: #666; }
        
        .qty-box { display: flex; align-items: center; justify-content: flex-start; gap: 5px; }
        .btn-qty { display: inline-block; width: 30px; height: 30px; line-height: 28px; text-align: center; border: 1px solid #ddd; background: #f8f9fa; color: #555; text-decoration: none; border-radius: 4px; font-weight: bold; transition: 0.2s; }
        .btn-qty:hover { background: #e2e6ea; border-color: #ccc; }
        .quantity-input { width: 45px; height: 30px; text-align: center; border: 1px solid #ddd; border-radius: 4px; font-weight: bold; pointer-events: none; }
        
        .btn-delete { color: #dc3545; text-decoration: none; font-size: 18px; transition: 0.2s; padding: 5px; }
        .btn-delete:hover { color: #a71d2a; transform: scale(1.1); }

        .cart-summary { flex: 1; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); height: fit-content; position: sticky; top: 90px; }
        .summary-title { font-size: 18px; font-weight: bold; margin-top: 0; border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 20px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 15px; }
        .total-row { font-size: 20px; font-weight: bold; color: #e63946; border-top: 1px solid #eee; padding-top: 15px; margin-top: 10px; }
        
        .btn-checkout { display: block; width: 100%; text-align: center; background: #28a745; color: white; padding: 15px 0; border-radius: 6px; text-decoration: none; font-size: 16px; font-weight: bold; margin-top: 20px; transition: 0.3s; border: none; cursor: pointer; }
        .btn-checkout:hover { background: #218838; transform: translateY(-2px); }
        
        .empty-cart { text-align: center; padding: 60px 0; color: #94a3b8; }
        .empty-cart i { font-size: 70px; color: #e2e8f0; margin-bottom: 20px; }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="back-btn-box">
        <button onclick="history.back()" class="btn-back">
            <i class="fas fa-arrow-left"></i> Quay lại trang trước
        </button>
    </div>

    <div class="cart-container">
        <div class="cart-items">
            <h2 class="cart-title">Giỏ hàng của bạn</h2>
            
            <c:choose>
                <c:when test="${not empty listCart}">
                    <table>
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Đơn giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th style="width: 50px;"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${listCart}" var="c">
                                <tr>
                                    <td>
                                        <div class="product-info">
                                            <img src="${pageContext.request.contextPath}/images/${c.image.replace('images/', '')}" alt="giày">
                                            <div>
                                                <div class="product-name">${c.shoeName}</div>
                                                <div class="product-size">Size: ${c.size}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="font-weight: 600; color: #555;">
                                        <fmt:formatNumber value="${c.price}" pattern="#,###"/> đ
                                    </td>
                                    <td>
                                        <div class="qty-box">
                                            <a href="updateCart?action=down&id=${c.cartId}" class="btn-qty">-</a>
                                            <input type="text" class="quantity-input" value="${c.quantity}" readonly>
                                            <a href="updateCart?action=up&id=${c.cartId}" class="btn-qty">+</a>
                                        </div>
                                    </td>
                                    <td style="font-weight: bold; color: #e63946;">
                                        <fmt:formatNumber value="${c.price * c.quantity}" pattern="#,###"/> đ
                                    </td>
                                    <td style="text-align: center;">
                                        <a href="updateCart?action=del&id=${c.cartId}" class="btn-delete" title="Xóa"><i class="fas fa-trash-alt"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-cart">
                        <i class="fas fa-shopping-basket"></i>
                        <h3>Giỏ hàng đang trống!</h3>
                        <p>Hãy lấp đầy nó bằng những đôi giày cực chất từ Luma Store nhé.</p>
                        <a href="shop" style="color: #0056b3; font-weight: bold; text-decoration: none; margin-top: 15px; display: inline-block;">Đến cửa hàng ngay &rarr;</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="cart-summary">
            <h3 class="summary-title">Tóm tắt đơn hàng</h3>
            <div class="summary-row">
                <span>Tạm tính:</span>
                <span><fmt:formatNumber value="${totalMoney}" pattern="#,###"/> đ</span>
            </div>
            <div class="summary-row">
                <span>Phí vận chuyển:</span>
                <span style="color: #28a745; font-weight: bold;">Miễn phí</span>
            </div>
            <div class="summary-row total-row">
                <span>Tổng cộng:</span>
                <span><fmt:formatNumber value="${totalMoney}" pattern="#,###"/> đ</span>
            </div>
            
            <c:if test="${not empty listCart}">
                <a href="checkout" class="btn-checkout">TIẾN HÀNH THANH TOÁN</a>
            </c:if>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>