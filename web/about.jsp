<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giới Thiệu - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reset và Font chữ */
        body { font-family: 'Segoe UI', Tahoma, sans-serif; margin: 0; padding: 0; background-color: #ffffff; display: flex; flex-direction: column; min-height: 100vh; }
        
        /* PHẦN 1: GIÁ TRỊ CỐT LÕI (Nằm ngay dưới Header, nền trắng) */
        .core-values-section { padding: 100px 20px; text-align: center; background-color: white; flex: 1; }
        .subtitle { color: #2563eb; font-weight: bold; font-size: 14px; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 15px; }
        .main-title { font-size: 38px; color: #0f172a; font-weight: 900; margin-top: 0; margin-bottom: 50px; }

        .values-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; max-width: 1100px; margin: 0 auto; text-align: left; }
        .value-card { background: white; padding: 40px 30px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.04); transition: all 0.3s ease; border: 1px solid #f1f5f9; }
        .value-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(37, 99, 235, 0.1); border-color: #bfdbfe; }
        
        .icon-box { width: 60px; height: 60px; background-color: #eff6ff; color: #2563eb; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 24px; margin-bottom: 25px; }
        .value-card h3 { font-size: 22px; color: #0f172a; margin: 0 0 15px 0; font-weight: 800; }
        .value-card p { color: #64748b; font-size: 15px; line-height: 1.7; margin: 0; }

        /* PHẦN 2: BANNER TỐI MÀU (Nằm dưới cùng) */
        .about-hero { background-color: #111827; color: white; text-align: center; padding: 120px 20px 80px; }
        .about-hero h1 { font-size: 52px; font-weight: 900; margin: 0 0 20px 0; letter-spacing: 1px; }
        .about-hero p { font-size: 18px; color: #9ca3af; max-width: 800px; margin: 0 auto; line-height: 1.6; }

        /* PHẦN 3: THANH THỐNG KÊ MÀU XANH NỔI BẬT (Nằm sát dưới phần tối, ngay trên Footer) */
        .stats-bar { background-color: #2563eb; display: flex; justify-content: center; gap: 150px; padding: 60px 20px; color: white; text-align: center; }
        .stat-item h2 { font-size: 48px; font-weight: 900; margin: 0 0 5px 0; }
        .stat-item p { font-size: 18px; margin: 0; opacity: 0.9; font-weight: 500; }

        /* Reponsive cho màn hình nhỏ */
        @media (max-width: 900px) {
            .values-grid { grid-template-columns: 1fr; max-width: 500px; }
            .stats-bar { flex-direction: column; gap: 40px; padding: 50px 20px;}
        }
    </style>
</head>
<body>

    <c:set var="activePage" value="about" scope="request" />
    <%@ include file="header.jsp" %>

    <section class="core-values-section">
        <div class="subtitle">Giá Trị Cốt Lõi</div>
        <h2 class="main-title">Cam kết của LUMA STORE</h2>
        
        <div class="values-grid">
            <div class="value-card">
                <div class="icon-box"><i class="fas fa-bullseye"></i></div>
                <h3>Tầm nhìn</h3>
                <p>Trở thành điểm đến mua sắm trực tuyến số 1 tại Việt Nam dành cho giới trẻ, nơi cung cấp những đôi giày thể thao mang đậm phong cách cá nhân và chất lượng vượt trội.</p>
            </div>
            
            <div class="value-card">
                <div class="icon-box"><i class="far fa-heart"></i></div>
                <h3>Khách hàng là trọng tâm</h3>
                <p>Mọi quyết định của chúng tôi đều bắt nguồn từ sự hài lòng của bạn. Chúng tôi cam kết mang đến trải nghiệm mua sắm mượt mà, tiện lợi và dịch vụ chăm sóc tận tình nhất.</p>
            </div>
            
            <div class="value-card">
                <div class="icon-box"><i class="fas fa-clipboard-check"></i></div>
                <h3>Chất lượng đảm bảo</h3>
                <p>Sản phẩm luôn được kiểm định nghiêm ngặt về chất liệu và phom dáng trước khi đến tay người tiêu dùng, đảm bảo sự êm ái và độ bền bỉ trong từng bước chạy.</p>
            </div>
        </div>
    </section>

    <section class="about-hero">
        <h1>Về Chúng Tôi</h1>
        <p>Hành trình của Luma Store bắt đầu từ một niềm đam mê mãnh liệt với thời trang và chất lượng. Chúng tôi tin rằng mỗi bước đi của các bạn sinh viên đều xứng đáng được nâng niu bởi những đôi giày tốt nhất.</p>
    </section>

    <section class="stats-bar">
        <div class="stat-item">
            <h2>10,000+</h2>
            <p>Khách hàng hài lòng</p>
        </div>
        <div class="stat-item">
            <h2>5,000+</h2>
            <p>Sản phẩm đa dạng</p>
        </div>
        <div class="stat-item">
            <h2>5+</h2>
            <p>Năm kinh nghiệm</p>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

</body>
</html>