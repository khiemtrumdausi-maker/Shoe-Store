<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.User"%>
<%@page import="dao.OrderDAO"%>
<%@page import="dao.CartDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // LOGIC TỰ ĐỘNG LẤY DỮ LIỆU CHO HEADER (Vì trang này gọi trực tiếp .jsp)
    User userSession = (User) session.getAttribute("acc");
    if (userSession != null) {
        OrderDAO odao = new OrderDAO();
        CartDAO cdao = new CartDAO();
        
        // Lấy thông báo và số lượng giỏ hàng mới nhất từ DB
        List<String> listN = odao.getNotisByUserID(userSession.getUserID());
        int cSize = cdao.getCartSizeByUserID(userSession.getUserID());
        
        // Đẩy vào session để file header.jsp hiển thị được luôn
        session.setAttribute("listNoti", listN);
        session.setAttribute("cartSize", cSize);
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên Hệ - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { display: flex; flex-direction: column; min-height: 100vh; margin: 0; background: #f8f9fa; font-family: 'Segoe UI', Tahoma, sans-serif; }
        .content { 
            width: 80%; margin: 50px auto; flex: 1; display: grid; 
            grid-template-columns: 1fr 1fr; gap: 40px; background: white; 
            padding: 40px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); 
        }
        .contact-info h2 { color: #0056b3; margin-top: 0; font-weight: 800; font-size: 28px; }
        .contact-info p { color: #64748b; line-height: 1.8; margin-bottom: 20px; font-size: 15px; }
        .contact-form input, .contact-form textarea { 
            width: 100%; padding: 15px; margin-bottom: 15px; border: 1px solid #e2e8f0; 
            border-radius: 8px; box-sizing: border-box; font-family: inherit; font-size: 14px;
        }
        .contact-form input:focus, .contact-form textarea:focus { outline: none; border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); }
        .btn-submit { 
            background: #0056b3; color: white; padding: 15px 30px; border: none; 
            border-radius: 8px; cursor: pointer; font-weight: bold; width: 100%; 
            font-size: 16px; transition: 0.3s; text-transform: uppercase;
        }
        .btn-submit:hover { background: #004494; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0,86,179,0.2); }
        
        .info-item { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; color: #1e293b; font-weight: 600; }
        .info-item i { width: 20px; font-size: 18px; }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="content">
        <div class="contact-info">
            <h2>Kết nối với Luma Store</h2>
            <p>Nếu bạn có bất kỳ thắc mắc nào về sản phẩm, đơn hàng hay cần tư vấn size giày, đừng ngần ngại gửi tin nhắn cho chúng tôi. Đội ngũ hỗ trợ sẽ phản hồi bạn trong thời gian sớm nhất.</p>
            
            <div class="info-item">
                <i class="fas fa-map-marker-alt" style="color:#e63946;"></i> 
                Học viện Công nghệ BCVT, Hà Nội
            </div>
            <div class="info-item">
                <i class="fas fa-phone-alt" style="color:#0056b3;"></i> 
                +84 123 456 789
            </div>
            <div class="info-item">
                <i class="fas fa-envelope" style="color:#28a745;"></i> 
                support@lumastore.vn
            </div>
        </div>

        <form class="contact-form" action="home" method="get">
            <input type="text" placeholder="Họ và tên của bạn" required>
            <input type="email" placeholder="Email liên hệ" required>
            <textarea rows="5" placeholder="Nội dung tin nhắn..." required></textarea>
            <button type="submit" class="btn-submit">Gửi Tin Nhắn</button>
        </form>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>