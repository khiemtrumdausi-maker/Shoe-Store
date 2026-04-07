<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /* CSS cho Footer mới */
    .site-footer { background-color: #0b1120; color: #94a3b8; padding: 50px 0 20px; font-family: 'Segoe UI', Tahoma, sans-serif; line-height: 1.6; margin-top: auto; }
    .footer-container { width: 85%; margin: 0 auto; display: grid; grid-template-columns: 2fr 1fr 1fr 1.5fr; gap: 30px; border-bottom: 1px solid #1e293b; padding-bottom: 30px; margin-bottom: 20px; }
    .footer-col h3 { color: #ffffff; font-size: 18px; margin-bottom: 20px; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
    .footer-col p { margin-bottom: 15px; font-size: 14px; }
    .footer-col ul { list-style: none; padding: 0; margin: 0; }
    .footer-col ul li { margin-bottom: 12px; }
    .footer-col ul li a { color: #94a3b8; text-decoration: none; transition: 0.3s; font-size: 14px; }
    .footer-col ul li a:hover { color: #ffffff; padding-left: 5px; }
    .footer-contact i { margin-right: 10px; color: #e63946; width: 15px; text-align: center; }
    .footer-bottom { text-align: center; font-size: 13px; color: #64748b; }
</style>

<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-col">
            <h3>LUMA STORE</h3>
            <p>Chúng tôi tự hào mang đến cho bạn những sản phẩm giày thể thao chất lượng, dẫn đầu xu hướng và phù hợp với mọi phong cách. Tự tin thể hiện cá tính trên mỗi bước đi.</p>
        </div>
        
        <div class="footer-col">
            <h3>Danh Mục</h3>
            <ul>
                <li><a href="shop?gender=1">Giày Nam</a></li>
                <li><a href="shop?gender=2">Giày Nữ</a></li>
                <li><a href="shop?gender=3">Giày Unisex</a></li>
                <li><a href="shop">Phụ kiện</a></li>
            </ul>
        </div>
        
        <div class="footer-col">
            <h3>Chính Sách</h3>
            <ul>
                <li><a href="#">Vận chuyển & Giao nhận</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Bảo mật thông tin</a></li>
                <li><a href="#">Điều khoản dịch vụ</a></li>
            </ul>
        </div>
        
        <div class="footer-col">
            <h3>Liên Hệ</h3>
            <p class="footer-contact"><i class="fas fa-map-marker-alt"></i> Học viện Công nghệ Bưu chính Viễn thông, Hà Nội</p>
            <p class="footer-contact"><i class="fas fa-phone-alt"></i> +84 123 456 789</p>
            <p class="footer-contact"><i class="fas fa-envelope"></i> support@lumastore.vn</p>
        </div>
    </div>
    <div class="footer-bottom">
        &copy; 2026 LUMA STORE. Tất cả các quyền được bảo lưu.
    </div>
</footer>