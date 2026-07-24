<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chi tiết Đơn hàng | SportShop</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
/* RESET & BASE */
* { box-sizing: border-box; margin: 0; padding: 0; }
body {
    font-family: 'Inter', sans-serif;
    background-color: #F0F2F5;
    color: #1B2838;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* NAVBAR */
.navbar {
    background: linear-gradient(135deg, #1B2838, #0F1923);
    color: white; padding: 0 40px; display: flex;
    justify-content: space-between; align-items: center;
    height: 64px; position: sticky; top: 0; z-index: 100;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}
.nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
.nav-logo-text {
    font-size: 22px; font-weight: 800;
    background: linear-gradient(135deg, #FF6B35, #FF8C42);
    -webkit-background-clip: text; -webkit-text-fill-color: transparent;
}
.nav-links { display: flex; align-items: center; gap: 8px; }
.nav-links a {
    color: #8B9BB4; text-decoration: none; font-size: 14px;
    font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: all 0.3s ease;
}
.nav-links a:hover { color: #fff; background: rgba(255, 107, 53, 0.1); }
.nav-links a.active { color: #FF6B35; background: rgba(255, 107, 53, 0.1); }
.nav-links a.logout { color: #FF4757; border: 1px solid rgba(255, 71, 87, 0.3); }

/* PAGE HEADER */
.page-header {
    background: linear-gradient(135deg, #1B2838 0%, #2A3F55 100%);
    padding: 32px 40px; position: relative; overflow: hidden;
}
.page-header::before {
    content: ''; position: absolute; top: -50%; right: -20%;
    width: 60%; height: 200%;
    background: repeating-linear-gradient(45deg, transparent, transparent 30px, rgba(255, 107, 53, 0.04) 30px, rgba(255, 107, 53, 0.04) 60px);
}
.header-inner {
    max-width: 1200px; margin: 0 auto; display: flex;
    justify-content: space-between; align-items: center; position: relative; z-index: 2;
}
.header-inner h1 { font-size: 24px; font-weight: 800; color: #fff; display: flex; align-items: center; gap: 10px; }

/* MAIN CONTENT */
.container {
    max-width: 1000px; margin: 40px auto; padding: 32px 40px; width: 100%; flex: 1;
    background: #fff; border-radius: 14px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); border: 1px solid #E8ECF0;
}

.table-container { margin-top: 24px; border-radius: 8px; overflow: hidden; border: 1px solid #E8ECF0;}
table { width: 100%; border-collapse: collapse; }
thead { background: #F8F9FA; border-bottom: 1px solid #E8ECF0; }
th { color: #4A5E75; font-weight: 700; text-transform: uppercase; font-size: 12px; padding: 16px; text-align: left; }
td { padding: 16px; font-size: 14px; border-bottom: 1px solid #F0F2F5; vertical-align: middle; }
tbody tr:hover { background: rgba(255, 107, 53, 0.02); }

.back-link {
    display: inline-flex; align-items: center; gap: 6px; color: #8B9BB4;
    text-decoration: none; font-size: 14px; font-weight: 600; padding: 10px 20px;
    border-radius: 10px; transition: all 0.3s ease; border: 1px solid #E8ECF0; margin-top: 24px;
}
.back-link:hover { color: #FF6B35; border-color: rgba(255, 107, 53, 0.3); background: rgba(255, 107, 53, 0.05); }

/* FOOTER */
.footer {
    background: linear-gradient(135deg, #1B2838, #0F1923);
    padding: 24px 40px; text-align: center; margin-top: auto;
}
.footer p { color: #4A5E75; font-size: 13px; }
.footer .brand { color: #FF6B35; font-weight: 700; }
</style>
</head>
<body>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">
        <span class="nav-logo-text">SportShop</span>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
        <a href="${pageContext.request.contextPath}/staff/orders" class="active">Đơn hàng</a>
        <a href="${pageContext.request.contextPath}/login" class="logout">Đăng xuất</a>
    </div>
</div>

<div class="page-header">
    <div class="header-inner">
        <h1>Chi tiết Đơn hàng: #${orderId}</h1>
    </div>
</div>

<div class="container">
    <h3>Sản phẩm khách hàng đã mua</h3>
    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="totalSum" value="0"/>
                <c:forEach var="item" items="${details}">
                    <tr>
                        <td style="font-weight: 600; color: #1B2838;">${item.tenSanPham}</td>
                        <td>${item.soLuong}</td>
                        <td><fmt:formatNumber value="${item.dongGia}" type="number"/> đ</td>
                        <td style="font-weight: 700; color: #FF6B35;"><fmt:formatNumber value="${item.thanhTien}" type="number"/> đ</td>
                    </tr>
                    <c:set var="totalSum" value="${totalSum + item.thanhTien}"/>
                </c:forEach>
                <c:if test="${empty details}">
                    <tr><td colspan="4" style="text-align: center; padding: 20px;">Không có dữ liệu chi tiết</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <div style="text-align: right; margin-top: 20px; font-size: 18px;">
        Tổng cộng: <strong style="color: #FF6B35; font-size: 22px;"><fmt:formatNumber value="${totalSum}" type="number"/> đ</strong>
    </div>

    <a class="back-link" href="${pageContext.request.contextPath}/staff/orders">← Quay lại danh sách đơn hàng</a>
</div>

<div class="footer">
    <p>© 2026 <span class="brand">SportShop</span> — Hệ thống quản lý cửa hàng thể thao</p>
</div>

</body>
</html>
