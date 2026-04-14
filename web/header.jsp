<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .navbar { background: #fff; padding: 15px 50px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 1000; font-family: 'Segoe UI', Tahoma, sans-serif; }
    .logo a { font-size: 24px; font-weight: 900; color: #0056b3; text-decoration: none; letter-spacing: 1px; }
    .nav-links { display: flex; gap: 30px; list-style: none; margin: 0; padding: 0; }
    .nav-links a { text-decoration: none; color: #555; font-weight: 600; transition: 0.3s; position: relative; padding-bottom: 5px; }
    .nav-links a.active { color: #0056b3 !important; }
    .nav-links a.active::after { content: ''; position: absolute; width: 100%; height: 3px; background: #0056b3; bottom: 0; left: 0; border-radius: 2px; }
    .user-actions { display: flex; align-items: center; gap: 25px; }
    .header-icons { display: flex; align-items: center; gap: 20px; }
    .icon-item { position: relative; font-size: 20px; color: #0056b3; cursor: pointer; text-decoration: none; }
    .icon-badge { position: absolute; top: -8px; right: -10px; background: #e63946; color: white; border-radius: 50%; padding: 2px 6px; font-size: 10px; font-weight: bold; }
    
    .noti-wrapper { position: relative; display: flex; align-items: center; }
    
    /* DROPDOWN CÓ THANH CUỘN */
    .noti-dropdown { 
        visibility: hidden; opacity: 0; position: absolute; top: 100%; right: 0; 
        background: white; width: 320px; border-radius: 12px; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.15); z-index: 1001; 
        border: 1px solid #f0f0f0; transform: translateY(10px); transition: 0.3s;
        
        /* Chỉnh ở đây để có thanh trượt */
        max-height: 350px; 
        overflow-y: auto; 
        overflow-x: hidden;
    }
    
    /* Tùy chỉnh thanh cuộn cho đẹp hơn */
    .noti-dropdown::-webkit-scrollbar { width: 6px; }
    .noti-dropdown::-webkit-scrollbar-thumb { background: #cbd5e1; border-radius: 10px; }

    .noti-wrapper:hover .noti-dropdown { visibility: visible; opacity: 1; transform: translateY(5px); }
    .noti-header { padding: 12px 15px; background: #f8f9fa; font-size: 14px; font-weight: bold; border-bottom: 1px solid #eee; position: sticky; top: 0; z-index: 10; }
    .noti-item { padding: 15px; border-bottom: 1px solid #f9f9f9; display: flex; gap: 12px; text-decoration: none; color: #444; font-size: 13px; transition: 0.2s; }
    .noti-item:hover { background: #f1f5f9; }
    
    .user-profile { display: flex; align-items: center; gap: 10px; padding-left: 15px; border-left: 1px solid #eee; }
    .user-name { font-size: 14px; font-weight: 700; color: #1e293b; }
    .logout-btn { font-size: 11px; color: #e63946; text-decoration: none; font-weight: bold; border: 1px solid #e63946; padding: 3px 7px; border-radius: 4px; }
</style>

<c:set var="uri" value="${pageContext.request.requestURI.toLowerCase()}" />

<header class="navbar">
    <div class="logo"><a href="home">LUMA STORE</a></div>
    <ul class="nav-links">
        <li><a href="home" class="${uri.contains('/home') || uri.endsWith('/') ? 'active' : ''}">Trang Chủ</a></li>
        <li><a href="shop" class="${uri.contains('/shop') ? 'active' : ''}">Cửa Hàng</a></li>
        <li><a href="about.jsp" class="${uri.contains('about') ? 'active' : ''}">Giới Thiệu</a></li>
        <li><a href="contact.jsp" class="${uri.contains('contact') ? 'active' : ''}">Liên Hệ</a></li>
    </ul>

    <div class="user-actions">
        <div class="header-icons">
            <a href="my-orders" class="icon-item"><i class="fas fa-history"></i></a>
            <div class="noti-wrapper">
                <div class="icon-item">
                    <i class="fas fa-bell"></i>
                    <c:if test="${not empty sessionScope.listNoti}">
                        <span class="icon-badge">${sessionScope.listNoti.size()}</span>
                    </c:if>
                </div>
                <div class="noti-dropdown">
                    <div class="noti-header">Thông báo mới</div>
                    <c:choose>
                        <c:when test="${not empty sessionScope.listNoti}">
                            <c:forEach items="${sessionScope.listNoti}" var="n">
                                <a href="my-orders" class="noti-item">
                                    <i class="fas fa-info-circle" style="color:#28a745; margin-top: 3px;"></i>
                                    <span>${n}</span>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="padding: 20px; text-align: center; color: #999;">Không có thông báo mới</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <a href="cart" class="icon-item">
                <i class="fas fa-shopping-cart"></i>
                <c:if test="${sessionScope.cartSize > 0}">
                    <span class="icon-badge">${sessionScope.cartSize}</span>
                </c:if>
            </a>
        </div>

        <c:choose>
            <c:when test="${sessionScope.acc != null}">
                <div class="user-profile">
                    <span class="user-name">${sessionScope.acc.fullName}</span>
                    <a href="logout" class="logout-btn">Thoát</a>
                </div>
            </c:when>
            <c:otherwise>
                <a href="login.jsp" style="color:#0056b3; font-weight:bold;">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
    </div>
</header>