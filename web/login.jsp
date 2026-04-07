<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Luma Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* 1. Đồng bộ Font và Nền */
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f8fafc; /* Nền xám nhạt đồng bộ trang Shop */
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }

        /* 2. Box Đăng nhập bo góc tròn và đổ bóng mờ */
        .login-box { 
            background: white; 
            padding: 40px; 
            border-radius: 16px; 
            box-shadow: 0 10px 25px rgba(0,0,0,0.05); 
            width: 350px; 
            text-align: center; 
            border: 1px solid #f1f5f9;
        }

        /* 3. Logo và Tiêu đề */
        .login-box h2 { 
            color: #0f172a; 
            font-weight: 800; 
            margin-bottom: 10px; 
            letter-spacing: -0.5px;
        }
        .login-box p.subtitle {
            color: #64748b;
            font-size: 14px;
            margin-bottom: 25px;
        }

        /* 4. Ô nhập liệu (Input) */
        .input-group {
            text-align: left;
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"] { 
            width: 100%; 
            padding: 12px 15px; 
            margin-top: 5px;
            border: 1px solid #e2e8f0; 
            border-radius: 10px; 
            box-sizing: border-box; 
            font-family: inherit;
            transition: 0.3s;
            background-color: #fbfcfd;
        }
        input:focus {
            outline: none;
            border-color: #2563eb;
            background-color: #fff;
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
        }

        /* 5. Nút bấm màu xanh LUMA */
        button { 
            width: 100%; 
            padding: 12px; 
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

        /* 6. Lỗi và Link điều hướng */
        .error { 
            color: #e63946; 
            font-size: 13px; 
            background: #fff1f2;
            padding: 8px;
            border-radius: 6px;
            margin-bottom: 15px;
            display: ${mess == null || mess == "" ? "none" : "block"};
        }
        .footer-link { 
            font-size: 14px; 
            margin-top: 20px; 
            color: #64748b;
        }
        .footer-link a { 
            color: #2563eb; 
            text-decoration: none; 
            font-weight: 600; 
        }
        .footer-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <div style="font-size: 24px; font-weight: 900; color: #0056b3; margin-bottom: 5px;">LUMA STORE</div>
        <h2>Chào mừng trở lại!</h2>
        <p class="subtitle">Vui lòng đăng nhập vào tài khoản của bạn</p>

        <div class="error">${mess}</div> 

        <form action="login" method="post">
            <div class="input-group">
                <input type="text" name="user" placeholder="Tên đăng nhập" required>
            </div>
            <div class="input-group">
                <input type="password" name="pass" placeholder="Mật khẩu" required>
            </div>
            <button type="submit">Đăng nhập</button>
        </form>

        <div class="footer-link">
            Chưa có tài khoản? <a href="signup.jsp">Đăng ký ngay</a>
        </div>
        
        <div style="margin-top: 15px;">
            <a href="home" style="font-size: 13px; color: #94a3b8; text-decoration: none;">
                <i class="fas fa-arrow-left"></i> Quay lại trang chủ
            </a>
        </div>
    </div>

</body>
</html>