<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SportShop - Thanh toán</title>
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
            color: white; padding: 0 40px; display: flex;
            justify-content: space-between; align-items: center;
            height: 64px; box-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }
        .nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .nav-logo-icon { font-size: 28px; }
        .nav-logo-text {
            font-size: 22px; font-weight: 800;
            background: linear-gradient(135deg, #FF6B35, #FF8C42);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        
        .checkout-container {
            max-width: 900px; margin: 40px auto; width: 100%;
            padding: 0 20px; flex: 1;
        }
        
        .checkout-grid {
            display: grid; grid-template-columns: 1.5fr 1fr; gap: 30px;
        }
        
        .box {
            background: #fff; padding: 30px; border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        
        h3 { font-size: 18px; margin-bottom: 20px; color: #1B2838; border-bottom: 1px solid #E8ECF0; padding-bottom: 10px; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 14px; font-weight: 600; color: #4A5E75; margin-bottom: 8px; }
        .form-group input, .form-group select {
            width: 100%; padding: 12px; border: 1px solid #E8ECF0;
            border-radius: 8px; outline: none; font-family: 'Inter'; font-size: 14px;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: #FF6B35;
        }
        
        .order-item {
            display: flex; justify-content: space-between;
            margin-bottom: 15px; font-size: 14px;
        }
        .order-item .name { font-weight: 600; }
        .order-item .price { color: #8B9BB4; }
        
        .total-row {
            display: flex; justify-content: space-between;
            border-top: 2px dashed #E8ECF0; padding-top: 15px; margin-top: 15px;
            font-size: 18px; font-weight: 800;
        }
        .total-row .price { color: #FF6B35; }
        
        .btn-submit {
            display: block; width: 100%; background: linear-gradient(135deg, #FF6B35, #E85A2A);
            color: white; border: none; padding: 15px; border-radius: 10px;
            font-weight: 700; font-size: 16px; cursor: pointer; margin-top: 20px;
            transition: all 0.3s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4); }
        
        .success-box { background: rgba(0,214,127,0.1); border: 1px solid #00D67F; color: #00D67F; padding: 20px; border-radius: 10px; text-align: center; }
        .error-box { background: rgba(255,71,87,0.1); border: 1px solid #FF4757; color: #FF4757; padding: 20px; border-radius: 10px; text-align: center; }
        .btn-back { display: inline-block; margin-top: 15px; text-decoration: none; color: #fff; background: #1B2838; padding: 10px 20px; border-radius: 8px; font-weight: 600; }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-logo">
            <span class="nav-logo-icon">🏀</span>
            <span class="nav-logo-text">SportShop</span>
        </a>
    </div>

    <div class="checkout-container">
        <c:choose>
            <c:when test="${not empty successMessage}">
                <div class="success-box">
                    <h2>🎉 Đặt hàng thành công!</h2>
                    <p style="margin-top: 10px;">${successMessage}</p>
                    <a href="${pageContext.request.contextPath}/home" class="btn-back">Về trang chủ</a>
                </div>
            </c:when>
            <c:when test="${not empty errorMessage}">
                <div class="error-box">
                    <h2>⚠️ Lỗi</h2>
                    <p style="margin-top: 10px;">${errorMessage}</p>
                    <a href="${pageContext.request.contextPath}/cart" class="btn-back">Về giỏ hàng</a>
                </div>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/checkout" method="POST" class="checkout-grid">
                    <div class="box">
                        <h3>Thông tin thanh toán</h3>
                        <div class="form-group">
                            <label>Họ và tên người nhận</label>
                            <input type="text" value="${sessionScope.currentUser.hoTen}" disabled>
                        </div>
                        <div class="form-group">
                            <label>Phương thức thanh toán</label>
                            <select name="paymentMethod">
                                <option value="Tiền mặt (COD)">Thanh toán khi nhận hàng (COD)</option>
                                <option value="Thẻ Visa/Mastercard">Thẻ Visa/Mastercard</option>
                                <option value="Ví MoMo">Ví MoMo</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="box">
                        <h3>Đơn hàng của bạn</h3>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <div class="order-item">
                                <span class="name">${item.product.tenSanPham} (x${item.quantity})</span>
                                <span class="price"><fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true" /> đ</span>
                            </div>
                        </c:forEach>
                        <div class="total-row">
                            <span>Tổng cộng:</span>
                            <span class="price"><fmt:formatNumber value="${total}" type="number" groupingUsed="true" /> đ</span>
                        </div>
                        <button type="submit" class="btn-submit">Xác nhận Đặt hàng →</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
