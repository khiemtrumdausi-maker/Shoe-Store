<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="entity.User"%>
<%@page import="dao.OrderDAO"%>
<%@page import="dao.CartDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // LOGIC TỰ ĐỘNG LẤY DỮ LIỆU CHO HEADER
    User userSession = (User) session.getAttribute("acc");
    if (userSession != null) {
        OrderDAO odao = new OrderDAO();
        CartDAO cdao = new CartDAO();
        
        List<String> listN = odao.getNotisByUserID(userSession.getUserID());
        int cSize = cdao.getCartSizeByUserID(userSession.getUserID());
        
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
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            margin: 0; padding: 0; 
            background-color: #f1f5f9; 
            color: #333; 
            display: flex; flex-direction: column; min-height: 100vh; 
        }
        
        /* Banner Liên Hệ */
        .page-header { background: #0056b3; padding: 60px 0; text-align: center; color: white; margin-bottom: 50px; }
        .page-header h1 { margin: 0; font-size: 36px; font-weight: 800; letter-spacing: 1px; }
        .page-header p { margin: 10px 0 0 0; font-size: 16px; opacity: 0.9; }

        /* Khung nội dung chính */
        .contact-container { max-width: 1100px; margin: 0 auto 80px auto; padding: 0 20px; flex: 1; }
        
        .contact-card { 
            background: #fff; 
            border-radius: 15px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.05); 
            overflow: hidden; 
            display: flex; 
        }

        /* Phần thông tin (Trái) */
        .contact-info { flex: 1; padding: 50px; }
        .contact-info h2 { color: #0f172a; font-size: 28px; margin-top: 0; margin-bottom: 10px; font-weight: 800; }
        .contact-desc { color: #64748b; margin-bottom: 40px; line-height: 1.6; font-size: 15px; }

        .info-item { display: flex; align-items: flex-start; margin-bottom: 30px; }
        .info-icon { 
            background: #eff6ff; color: #0056b3; 
            width: 50px; height: 50px; border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; 
            font-size: 20px; margin-right: 20px; flex-shrink: 0; 
        }
        .info-text h4 { margin: 0 0 8px 0; color: #1e293b; font-size: 17px; font-weight: bold; }
        .info-text p { margin: 0; color: #475569; line-height: 1.5; font-size: 15px; }

        /* Mạng xã hội */
        .social-title { font-size: 16px; font-weight: bold; color: #1e293b; margin-top: 40px; margin-bottom: 15px; }
        .social-links { display: flex; gap: 15px; }
        .social-links a { 
            background: #f1f5f9; color: #475569; 
            width: 45px; height: 45px; border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; 
            text-decoration: none; transition: 0.3s; font-size: 18px; 
        }
        .social-links a:hover { background: #0056b3; color: #fff; transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,86,179,0.3); }

        /* Phần Bản đồ (Phải) */
        .contact-map { flex: 1; min-height: 100%; position: relative; background: #e2e8f0; }
        .contact-map iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0; }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="page-header">
        <h1>Kết nối với Luma Store</h1>
        <p>Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn</p>
    </div>

    <div class="contact-container">
        <div class="contact-card">
            
            <div class="contact-info">
                <h2>Thông Tin Liên Hệ</h2>
                <p class="contact-desc">Mọi thắc mắc về sản phẩm, chính sách bảo hành hoặc trải nghiệm mua sắm, xin vui lòng liên hệ với Luma qua các thông tin dưới đây. Đội ngũ CSKH sẽ phản hồi nhanh nhất có thể!</p>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-map-marker-alt"></i></div>
                    <div class="info-text">
                        <h4>Địa chỉ cửa hàng</h4>
                        <p>Học viện Công nghệ Bưu chính Viễn thông<br>Km10, Đường Nguyễn Trãi, Q.Hà Đông, Hà Nội</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-phone-alt"></i></div>
                    <div class="info-text">
                        <h4>Hotline hỗ trợ</h4>
                        <p><b>032 545 8936</b><br>Thời gian: 8:00 - 22:00 (Tất cả các ngày)</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon"><i class="fas fa-envelope"></i></div>
                    <div class="info-text">
                        <h4>Email liên hệ</h4>
                        <p>support@lumastore.vn<br>cskh.lumastore@gmail.com</p>
                    </div>
                </div>

                <div class="social-title">Theo dõi chúng tôi tại:</div>
                <div class="social-links">
                    <a href="#" title="Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" title="Instagram"><i class="fab fa-instagram"></i></a>
                    <a href="#" title="Tiktok"><i class="fab fa-tiktok"></i></a>
                    <a href="#" title="Youtube"><i class="fab fa-youtube"></i></a>
                </div>
            </div>

            <div class="contact-map">
                <iframe 
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3725.2948607106093!2d105.7848624153315!3d20.980812986024194!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135accdd8a1ad71%3A0xa2f9b16036648187!2zSOG7jWMgdmnhu4duIEPDtG5nIG5naOG7hyBCxrB1IGNow61uaCB2aeG7hW4gdGjDtG5n!5e0!3m2!1svi!2s!4v1683901234567!5m2!1svi!2s" 
                    allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>

        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>