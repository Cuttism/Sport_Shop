<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Hồ sơ cá nhân | SportShop</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Inter', sans-serif; background-color: #F0F2F5; color: #1B2838; min-height: 100vh; display: flex; flex-direction: column; }
.navbar { background: linear-gradient(135deg, #1B2838, #0F1923); color: white; padding: 0 40px; display: flex; justify-content: space-between; align-items: center; height: 64px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); }
.nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
.nav-logo-text { font-size: 22px; font-weight: 800; background: linear-gradient(135deg, #FF6B35, #FF8C42); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
.nav-links a { color: #8B9BB4; text-decoration: none; font-size: 14px; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: 0.3s; }
.nav-links a:hover { color: #fff; background: rgba(255, 107, 53, 0.1); }
.container { max-width: 1000px; margin: 40px auto; width: 100%; padding: 0 20px; flex: 1; }
.profile-grid { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; }
.box { background: #fff; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
.box h3 { font-size: 18px; margin-bottom: 20px; color: #1B2838; border-bottom: 1px solid #E8ECF0; padding-bottom: 10px; }
.form-group { margin-bottom: 15px; }
.form-group label { display: block; font-size: 13px; font-weight: 600; color: #4A5E75; margin-bottom: 8px; }
.form-group input { width: 100%; padding: 12px; border: 1px solid #E8ECF0; border-radius: 8px; outline: none; font-family: 'Inter'; font-size: 14px; }
.form-group input:focus { border-color: #FF6B35; }
.btn-submit { background: linear-gradient(135deg, #FF6B35, #E85A2A); color: white; border: none; padding: 12px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.3s; width: 100%; margin-top: 10px; }
.btn-submit:hover { transform: translateY(-2px); box-shadow: 0 4px 15px rgba(255,107,53,0.3); }
.msg { padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; font-weight: 500; }
.msg.success { background: rgba(0,214,127,0.1); color: #00A360; }
.msg.error { background: rgba(255,71,87,0.1); color: #E02334; }
.order-list table { width: 100%; border-collapse: collapse; }
.order-list th { background: #F8F9FA; padding: 12px; text-align: left; font-size: 13px; color: #4A5E75; border-bottom: 2px solid #E8ECF0; }
.order-list td { padding: 12px; border-bottom: 1px solid #F0F2F5; font-size: 14px; }
.status { padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 600; }
.status.pending { background: #FFF3CD; color: #856404; }
.status.done { background: #D4EDDA; color: #155724; }
.status.cancel { background: #F8D7DA; color: #721C24; }
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
            <a href="${pageContext.request.contextPath}/login" style="color: #FF4757;">🚪 Đăng xuất</a>
        </div>
    </div>
    <div class="container">
        <h2 style="margin-bottom: 20px;">Hồ sơ cá nhân</h2>
        <c:if test="${not empty sessionScope.msg}"><div class="msg success">${sessionScope.msg}</div><c:remove var="msg" scope="session"/></c:if>
        <c:if test="${not empty sessionScope.error}"><div class="msg error">${sessionScope.error}</div><c:remove var="error" scope="session"/></c:if>
        <div class="profile-grid">
            <div class="box">
                <h3>Cập nhật thông tin</h3>
                <form action="${pageContext.request.contextPath}/profile" method="POST">
                    <div class="form-group"><label>Mã tài khoản (Không đổi)</label><input type="text" value="${customerInfo.id}" disabled style="background:#F8F9FA;"></div>
                    <div class="form-group"><label>Họ và tên</label><input type="text" name="hoTen" value="${customerInfo.hoTen}" required></div>
                    <div class="form-group"><label>Số điện thoại</label><input type="text" name="dienThoai" value="${customerInfo.dienThoai}" required></div>
                    <div class="form-group"><label>Địa chỉ giao hàng</label><input type="text" name="diaChi" value="${customerInfo.diaChi}" required></div>
                    <button type="submit" class="btn-submit">Lưu thay đổi</button>
                </form>
            </div>
            <div class="box">
                <h3>Lịch sử đơn hàng của bạn</h3>
                <div class="order-list">
                    <table>
                        <tr><th>Mã Đơn</th><th>Tổng tiền</th><th>Trạng thái</th></tr>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><strong>${o.maDonHang}</strong></td>
                                <td style="color:#FF6B35; font-weight:600;"><fmt:formatNumber value="${o.tongTienHoaDon}" type="number"/> đ</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.trangThai eq 'Đã thanh toán'}"><span class="status done">${o.trangThai}</span></c:when>
                                        <c:when test="${o.trangThai eq 'Đã hủy'}"><span class="status cancel">${o.trangThai}</span></c:when>
                                        <c:otherwise><span class="status pending">${o.trangThai}</span></c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty orders}"><tr><td colspan="3" style="text-align:center; padding:20px; color:#8B9BB4;">Bạn chưa có đơn hàng nào.</td></tr></c:if>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
