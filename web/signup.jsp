<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f8fafc; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            min-height: 100vh; 
            margin: 0; 
            padding: 20px 0;
        }

        .signup-box { 
            background: white; 
            padding: 35px 40px; 
            border-radius: 16px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.05); 
            width: 420px; 
            text-align: center; 
            border: 1px solid #f1f5f9;
        }

        .brand-name { font-size: 24px; font-weight: 900; color: #0056b3; margin-bottom: 5px; }
        h2 { color: #0f172a; font-weight: 800; margin: 10px 0; font-size: 22px; }
        .subtitle { color: #64748b; font-size: 14px; margin-bottom: 25px; }

        .form-group { text-align: left; margin-bottom: 12px; }
        .form-group input { 
            width: 100%; 
            padding: 12px 15px; 
            border: 1px solid #e2e8f0; 
            border-radius: 10px; 
            box-sizing: border-box; 
            font-family: inherit;
            transition: 0.3s;
            background-color: #fbfcfd;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: #2563eb;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        .error { 
            color: #e63946; 
            font-size: 11px; 
            margin-top: 3px; 
            display: block; 
            font-style: italic;
            min-height: 15px;
        }

        /* NÚT BẤM ĐÃ ĐỔI VỀ XANH DƯƠNG LUMA */
        button { 
            width: 100%; 
            padding: 13px; 
            background-color: #0056b3; 
            color: white; 
            border: none; 
            border-radius: 10px; 
            font-weight: bold; 
            font-size: 16px;
            cursor: pointer; 
            transition: 0.3s;
            margin-top: 10px;
        }
        button:hover { 
            background-color: #004494; 
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 86, 179, 0.2);
        }

        .footer-link { font-size: 14px; margin-top: 20px; color: #64748b; }
        .footer-link a { color: #2563eb; text-decoration: none; font-weight: 600; }
        .footer-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>

    <div class="signup-box">
        <div class="brand-name">LUMA STORE</div>
        <h2>Tạo tài khoản mới</h2>
        <p class="subtitle">Chào mừng bạn đến với thế giới giày của LUMA</p>
        
        <form action="signup" method="post">
            <div class="form-group">
                <input type="text" name="fullname" placeholder="Họ và tên" value="${v_fullname}">
                <span class="error">${errFullname}</span>
            </div>
            
            <div class="form-group">
                <input type="text" name="email" placeholder="Email của bạn" value="${v_email}">
                <span class="error">${errEmail}</span>
            </div>
            
            <div class="form-group">
                <input type="password" name="pass" placeholder="Mật khẩu">
                <span class="error">${errPass}</span>
            </div>
            
            <div class="form-group">
                <input type="password" name="repass" placeholder="Nhập lại mật khẩu">
                <span class="error">${errRepass}</span>
            </div>
            
            <div class="form-group">
                <input type="text" name="phone" placeholder="Số điện thoại" value="${v_phone}">
                <span class="error">${errPhone}</span>
            </div>
            
            <div class="form-group">
                <input type="text" name="address" placeholder="Địa chỉ nhận hàng" value="${v_address}">
                <span class="error">${errAddress}</span>
            </div>
            
            <button type="submit">Đăng ký ngay</button>
        </form>
        
        <div class="footer-link">
            Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a>
        </div>

        <div style="margin-top: 15px;">
            <a href="home" style="font-size: 13px; color: #94a3b8; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Quay lại trang chủ
            </a>
        </div>
    </div>

</body>
</html>