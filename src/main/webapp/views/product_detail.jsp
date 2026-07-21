<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${product.tenSanPham} | SportShop</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Inter', sans-serif; background-color: #F0F2F5; color: #1B2838; min-height: 100vh; display: flex; flex-direction: column; }
.navbar { background: linear-gradient(135deg, #1B2838, #0F1923); color: white; padding: 0 40px; display: flex; justify-content: space-between; align-items: center; height: 64px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); }
.nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
.nav-logo-text { font-size: 22px; font-weight: 800; background: linear-gradient(135deg, #FF6B35, #FF8C42); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
.nav-links { display: flex; align-items: center; gap: 8px; }
.nav-links a { color: #8B9BB4; text-decoration: none; font-size: 14px; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: 0.3s; }
.nav-links a:hover { color: #fff; background: rgba(255, 107, 53, 0.1); }
.nav-links a.active { color: #FF6B35; }
.container { max-width: 1000px; margin: 40px auto; width: 100%; padding: 0 20px; flex: 1; }

.product-detail-card {
    background: #fff; border-radius: 14px; padding: 40px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05); display: flex; gap: 40px; margin-bottom: 40px;
}
.product-image {
    flex: 1; background: linear-gradient(135deg, rgba(255, 107, 53, 0.05), rgba(255, 140, 66, 0.1));
    border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 100px; min-height: 300px;
}
.product-info { flex: 1; display: flex; flex-direction: column; justify-content: center; }
.product-info h1 { font-size: 28px; font-weight: 800; margin-bottom: 10px; color: #1B2838; line-height: 1.3; }
.rating-summary { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; }
.stars { color: #FFB830; font-size: 18px; letter-spacing: 2px; }
.review-count { color: #8B9BB4; font-size: 14px; }
.price { font-size: 28px; font-weight: 800; color: #FF6B35; margin-bottom: 20px; }
.stock-status { display: inline-block; padding: 6px 12px; background: rgba(0, 214, 127, 0.1); color: #00D67F; font-weight: 600; font-size: 13px; border-radius: 20px; margin-bottom: 30px; align-self: flex-start; }
.btn-add-cart {
    background: linear-gradient(135deg, #FF6B35, #E85A2A); color: white; border: none; padding: 14px 28px;
    border-radius: 10px; font-weight: 700; font-size: 16px; text-decoration: none; display: inline-block; text-align: center;
    box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3); transition: all 0.3s; width: 100%; max-width: 300px;
}
.btn-add-cart:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255, 107, 53, 0.4); }

.reviews-section { background: #fff; border-radius: 14px; padding: 40px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
.reviews-section h2 { font-size: 22px; margin-bottom: 24px; border-bottom: 1px solid #E8ECF0; padding-bottom: 15px; }

.review-form { margin-bottom: 40px; background: #F8F9FA; padding: 24px; border-radius: 12px; }
.form-group { margin-bottom: 15px; }
.form-group label { display: block; font-weight: 600; font-size: 14px; margin-bottom: 8px; color: #4A5E75; }
.form-group select, .form-group textarea {
    width: 100%; padding: 12px; border: 1px solid #E8ECF0; border-radius: 8px; font-family: 'Inter'; font-size: 14px; outline: none;
}
.form-group select:focus, .form-group textarea:focus { border-color: #FF6B35; }
.btn-submit { background: #1B2838; color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.3s; }
.btn-submit:hover { background: #0F1923; }

.review-list { display: flex; flex-direction: column; gap: 20px; }
.review-item { padding-bottom: 20px; border-bottom: 1px solid #E8ECF0; }
.review-item:last-child { border-bottom: none; padding-bottom: 0; }
.reviewer-name { font-weight: 700; color: #1B2838; font-size: 15px; display: flex; align-items: center; gap: 10px; margin-bottom: 5px; }
.review-date { font-size: 12px; color: #8B9BB4; font-weight: 400; }
.review-stars { color: #FFB830; font-size: 14px; margin-bottom: 8px; }
.review-content { color: #4A5E75; font-size: 14px; line-height: 1.6; }

.msg { padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; font-weight: 500; }
.msg.success { background: rgba(0,214,127,0.1); color: #00A360; }
.msg.error { background: rgba(255,71,87,0.1); color: #E02334; }
</style>
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-logo">
            <span style="font-size: 28px;">🏀</span><span class="nav-logo-text">SportShop</span>
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
            <a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a>
            <c:if test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/profile">👤 Tài khoản</a>
                <a href="${pageContext.request.contextPath}/login" class="logout">🚪 Đăng xuất</a>
            </c:if>
        </div>
    </div>

    <div class="container">
        <div class="product-detail-card">
            <div class="product-image">🎁</div>
            <div class="product-info">
                <h1>${product.tenSanPham}</h1>
                <div class="rating-summary">
                    <span class="stars">
                        <c:forEach begin="1" end="5" var="i">${i <= avgRating ? '★' : '☆'}</c:forEach>
                    </span>
                    <span class="review-count">(${reviews.size()} đánh giá)</span>
                </div>
                <div class="price"><fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" /> đ</div>
                <div class="stock-status">Kho: Còn ${product.soLuongTon} sản phẩm</div>
                <a href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}" class="btn-add-cart">🛒 Thêm vào giỏ hàng ngay</a>
            </div>
        </div>

        <div class="reviews-section">
            <h2>Đánh giá & Nhận xét</h2>
            <c:if test="${not empty sessionScope.msgReview}"><div class="msg success">${sessionScope.msgReview}</div><c:remove var="msgReview" scope="session"/></c:if>
            <c:if test="${not empty sessionScope.errorReview}"><div class="msg error">${sessionScope.errorReview}</div><c:remove var="errorReview" scope="session"/></c:if>

            <c:choose>
                <c:when test="${not empty sessionScope.currentUser and sessionScope.currentUser.role == 'CUSTOMER'}">
                    <div class="review-form">
                        <form action="${pageContext.request.contextPath}/product/review" method="POST">
                            <input type="hidden" name="productId" value="${product.id}">
                            <div class="form-group">
                                <label>Đánh giá của bạn (1-5 sao)</label>
                                <select name="soSao" required>
                                    <option value="5">★★★★★ (Tuyệt vời)</option>
                                    <option value="4">★★★★☆ (Tốt)</option>
                                    <option value="3">★★★☆☆ (Bình thường)</option>
                                    <option value="2">★★☆☆☆ (Kém)</option>
                                    <option value="1">★☆☆☆☆ (Tệ)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Nhận xét chi tiết</label>
                                <textarea name="noiDung" rows="3" required placeholder="Chia sẻ cảm nhận của bạn về sản phẩm này..."></textarea>
                            </div>
                            <button type="submit" class="btn-submit">Gửi đánh giá</button>
                        </form>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="background:#F8F9FA; padding:20px; text-align:center; border-radius:8px; margin-bottom:30px;">
                        <p style="color:#6B7C93; margin-bottom:10px;">Vui lòng đăng nhập với tư cách khách hàng để gửi đánh giá.</p>
                        <a href="${pageContext.request.contextPath}/login" style="color:#FF6B35; font-weight:600; text-decoration:none;">Đăng nhập ngay →</a>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="review-list">
                <c:forEach var="r" items="${reviews}">
                    <div class="review-item">
                        <div class="reviewer-name">
                            ${r.customerName} <span class="review-date">vào ngày <fmt:formatDate value="${r.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>
                        <div class="review-stars">
                            <c:forEach begin="1" end="5" var="i">${i <= r.soSao ? '★' : '☆'}</c:forEach>
                        </div>
                        <div class="review-content">${r.noiDung}</div>
                    </div>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <p style="color:#8B9BB4; text-align:center; padding:20px;">Chưa có đánh giá nào. Hãy là người đầu tiên nhận xét!</p>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
