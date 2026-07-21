<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportShop - Giỏ hàng</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background-color: #F0F2F5;
            color: #1B2838;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .navbar {
            background: linear-gradient(135deg, #1B2838, #0F1923);
            color: white;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 64px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        .nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .nav-logo-icon { font-size: 28px; }
        .nav-logo-text {
            font-size: 22px; font-weight: 800;
            background: linear-gradient(135deg, #FF6B35, #FF8C42);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .nav-links { display: flex; gap: 8px; }
        .nav-links a {
            color: #8B9BB4; text-decoration: none; font-size: 14px;
            font-weight: 500; padding: 8px 16px; border-radius: 8px;
            transition: all 0.3s ease;
        }
        .nav-links a:hover { color: #fff; background: rgba(255, 107, 53, 0.1); }
        .nav-links a.active { color: #FF6B35; }
        
        .cart-container {
            max-width: 1000px;
            margin: 40px auto;
            width: 100%;
            padding: 0 20px;
            flex: 1;
        }
        .cart-title { font-size: 24px; font-weight: 800; margin-bottom: 24px; color: #1B2838; }
        
        .cart-table {
            width: 100%;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            border-collapse: collapse;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .cart-table th {
            background: #1B2838;
            color: #fff;
            text-align: left;
            padding: 16px;
            font-size: 14px;
            text-transform: uppercase;
        }
        .cart-table td {
            padding: 16px;
            border-bottom: 1px solid #E8ECF0;
            vertical-align: middle;
        }
        .cart-table tr:last-child td { border-bottom: none; }
        
        .item-name { font-weight: 600; font-size: 16px; color: #1B2838; }
        .item-price { color: #FF6B35; font-weight: 700; }
        
        .qty-form { display: flex; align-items: center; gap: 10px; }
        .qty-input {
            width: 60px; padding: 8px; border: 1px solid #E8ECF0;
            border-radius: 6px; text-align: center; font-weight: 600;
        }
        .btn-update {
            background: #F0F2F5; color: #1B2838; border: none; padding: 8px 12px;
            border-radius: 6px; cursor: pointer; font-weight: 600; font-size: 13px;
        }
        .btn-update:hover { background: #E8ECF0; }
        
        .btn-remove {
            color: #FF4757; text-decoration: none; font-weight: 600; font-size: 14px;
        }
        .btn-remove:hover { text-decoration: underline; }
        
        .cart-summary {
            margin-top: 30px;
            background: #fff;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .summary-total { font-size: 20px; font-weight: 700; }
        .summary-total span { color: #FF6B35; font-size: 24px; font-weight: 800; margin-left: 10px; }
        
        .btn-checkout {
            background: linear-gradient(135deg, #FF6B35, #E85A2A);
            color: white; text-decoration: none; padding: 14px 28px;
            border-radius: 10px; font-weight: 700; font-size: 16px;
            box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3); transition: all 0.3s ease;
        }
        .btn-checkout:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4); }
        
        .empty-cart { text-align: center; padding: 50px; background: #fff; border-radius: 12px; }
        .empty-cart h3 { margin-bottom: 16px; color: #1B2838; }
        .btn-shop {
            display: inline-block; background: #1B2838; color: #fff;
            padding: 12px 24px; border-radius: 8px; text-decoration: none; font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-logo">
            <span class="nav-logo-icon">🏀</span>
            <span class="nav-logo-text">SportShop</span>
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
            <a href="#">🔍 Tìm kiếm</a>
            <a href="${pageContext.request.contextPath}/cart" class="active">🛒 Giỏ hàng <c:if test="${not empty sessionScope.cart}"><span style="background:#FF4757; color:white; padding:2px 6px; border-radius:10px; font-size:12px; margin-left:4px;">${sessionScope.cart.size()}</span></c:if></a>
        </div>
    </div>

    <div class="cart-container">
        <h2 class="cart-title">Giỏ hàng của bạn</h2>
        
        <c:choose>
            <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
                <div class="empty-cart">
                    <h3>Giỏ hàng đang trống!</h3>
                    <a href="${pageContext.request.contextPath}/home" class="btn-shop">Tiếp tục mua sắm</a>
                </div>
            </c:when>
            <c:otherwise>
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <tr>
                                <td class="item-name">${item.product.tenSanPham}</td>
                                <td class="item-price"><fmt:formatNumber value="${item.product.gia}" type="number" groupingUsed="true" /> đ</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="POST" class="qty-form">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="id" value="${item.product.id}">
                                        <input type="number" name="quantity" class="qty-input" value="${item.quantity}" min="1">
                                        <button type="submit" class="btn-update">Cập nhật</button>
                                    </form>
                                </td>
                                <td class="item-price"><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true" /> đ</td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}" class="btn-remove">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="cart-summary">
                    <div class="summary-total">Tổng cộng: <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true" /> đ</span></div>
                    <a href="${pageContext.request.contextPath}/checkout" class="btn-checkout">Tiến hành Thanh toán →</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
