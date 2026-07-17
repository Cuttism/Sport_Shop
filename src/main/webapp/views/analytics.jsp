<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thống kê doanh thu - Admin | SportShop</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
/* ============================================= */
/* RESET & BASE                                  */
/* ============================================= */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Inter', 'Segoe UI', sans-serif;
	background-color: #F0F2F5;
	color: #1B2838;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* ============================================= */
/* NAVBAR                                        */
/* ============================================= */
.navbar {
	background: linear-gradient(135deg, #1B2838, #0F1923);
	color: white;
	padding: 0 40px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 64px;
	position: sticky;
	top: 0;
	z-index: 100;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.nav-logo {
	display: flex;
	align-items: center;
	gap: 10px;
	text-decoration: none;
}

.nav-logo-icon { font-size: 28px; }

.nav-logo-text {
	font-size: 22px;
	font-weight: 800;
	background: linear-gradient(135deg, #FF6B35, #FF8C42);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	background-clip: text;
}

.nav-links {
	display: flex;
	align-items: center;
	gap: 8px;
}

.nav-links a {
	color: #8B9BB4;
	text-decoration: none;
	font-size: 14px;
	font-weight: 500;
	padding: 8px 16px;
	border-radius: 8px;
	transition: all 0.3s ease;
}

.nav-links a:hover {
	color: #fff;
	background: rgba(255, 107, 53, 0.1);
}

.nav-links a.active {
	color: #FF6B35;
	background: rgba(255, 107, 53, 0.1);
}

.nav-links a.logout {
	color: #FF4757;
	border: 1px solid rgba(255, 71, 87, 0.3);
}

.nav-links a.logout:hover {
	background: rgba(255, 71, 87, 0.1);
}

/* ============================================= */
/* PAGE HEADER                                   */
/* ============================================= */
.page-header {
	background: linear-gradient(135deg, #1B2838 0%, #2A3F55 100%);
	padding: 32px 40px;
	position: relative;
	overflow: hidden;
}

.page-header::before {
	content: '';
	position: absolute;
	top: -50%;
	right: -20%;
	width: 60%;
	height: 200%;
	background: repeating-linear-gradient(
		45deg,
		transparent,
		transparent 30px,
		rgba(255, 107, 53, 0.04) 30px,
		rgba(255, 107, 53, 0.04) 60px
	);
}

.header-inner {
	max-width: 1200px;
	margin: 0 auto;
	display: flex;
	justify-content: space-between;
	align-items: center;
	position: relative;
	z-index: 2;
}

.header-inner h1 {
	font-size: 24px;
	font-weight: 800;
	color: #fff;
	display: flex;
	align-items: center;
	gap: 10px;
}

.admin-badge {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 8px 16px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 700;
	background: rgba(255, 107, 53, 0.15);
	color: #FF6B35;
	border: 1px solid rgba(255, 107, 53, 0.3);
}

/* ============================================= */
/* MAIN CONTENT                                  */
/* ============================================= */
.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 32px 40px;
	width: 100%;
	flex: 1;
}

/* ============================================= */
/* STAT CARDS GRID                               */
/* ============================================= */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 32px;
}

.stat-card {
	background: #fff;
	border-radius: 14px;
	padding: 24px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	border: 1px solid #E8ECF0;
	transition: all 0.3s ease;
	position: relative;
	overflow: hidden;
}

.stat-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 12px 32px rgba(0, 0, 0, 0.1);
}

/* Colored top stripe per card */
.stat-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	height: 3px;
}

.stat-card.revenue::before { background: linear-gradient(90deg, #00D67F, #00B86B); }
.stat-card.orders::before { background: linear-gradient(90deg, #FF6B35, #FF8C42); }
.stat-card.customers::before { background: linear-gradient(90deg, #3B82F6, #60A5FA); }
.stat-card.products::before { background: linear-gradient(90deg, #A855F7, #C084FC); }
.stat-card.bills::before { background: linear-gradient(90deg, #FFB830, #FFCF5C); }
.stat-card.pending::before { background: linear-gradient(90deg, #FF4757, #FF6B81); }

.stat-header {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 16px;
}

.stat-icon {
	width: 48px;
	height: 48px;
	border-radius: 12px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 22px;
}

.stat-card.revenue .stat-icon { background: rgba(0, 214, 127, 0.12); }
.stat-card.orders .stat-icon { background: rgba(255, 107, 53, 0.12); }
.stat-card.customers .stat-icon { background: rgba(59, 130, 246, 0.12); }
.stat-card.products .stat-icon { background: rgba(168, 85, 247, 0.12); }
.stat-card.bills .stat-icon { background: rgba(255, 184, 48, 0.12); }
.stat-card.pending .stat-icon { background: rgba(255, 71, 87, 0.12); }

.stat-label {
	font-size: 12px;
	color: #8B9BB4;
	text-transform: uppercase;
	letter-spacing: 0.5px;
	font-weight: 600;
}

.stat-value {
	font-size: 28px;
	font-weight: 800;
	color: #1B2838;
	margin-top: 4px;
	line-height: 1.2;
}

.stat-card.revenue .stat-value { color: #00D67F; }

/* ============================================= */
/* INFO PANELS                                   */
/* ============================================= */
.panels-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	margin-bottom: 32px;
}

.panel {
	background: #fff;
	border-radius: 14px;
	padding: 28px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
	border: 1px solid #E8ECF0;
}

.panel-header {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 16px;
}

.panel-header h3 {
	font-size: 16px;
	font-weight: 700;
	color: #1B2838;
}

.panel-header .icon {
	font-size: 20px;
}

.panel p {
	font-size: 14px;
	color: #6B7C93;
	line-height: 1.7;
}

.panel code {
	background: rgba(255, 107, 53, 0.1);
	padding: 2px 8px;
	border-radius: 6px;
	color: #FF6B35;
	font-weight: 600;
	font-size: 13px;
}

/* Quick actions */
.quick-actions {
	display: flex;
	flex-direction: column;
	gap: 12px;
}

.action-item {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 12px 16px;
	background: #F8F9FA;
	border-radius: 10px;
	text-decoration: none;
	color: #1B2838;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
	border: 1px solid transparent;
}

.action-item:hover {
	background: rgba(255, 107, 53, 0.06);
	border-color: rgba(255, 107, 53, 0.2);
	transform: translateX(4px);
}

.action-item .action-icon {
	font-size: 20px;
}

.action-item .arrow {
	margin-left: auto;
	color: #8B9BB4;
	font-size: 16px;
}

/* ============================================= */
/* BACK LINK                                     */
/* ============================================= */
.back-link {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	color: #8B9BB4;
	text-decoration: none;
	font-size: 14px;
	font-weight: 600;
	padding: 10px 20px;
	border-radius: 10px;
	transition: all 0.3s ease;
	border: 1px solid #E8ECF0;
}

.back-link:hover {
	color: #FF6B35;
	border-color: rgba(255, 107, 53, 0.3);
	background: rgba(255, 107, 53, 0.05);
}

/* ============================================= */
/* FOOTER                                        */
/* ============================================= */
.footer {
	background: linear-gradient(135deg, #1B2838, #0F1923);
	padding: 24px 40px;
	text-align: center;
	margin-top: auto;
}

.footer p {
	color: #4A5E75;
	font-size: 13px;
}

.footer .brand {
	color: #FF6B35;
	font-weight: 700;
}

/* ============================================= */
/* RESPONSIVE                                    */
/* ============================================= */
@media (max-width: 768px) {
	.navbar { padding: 0 20px; }
	.page-header { padding: 24px 20px; }
	.container { padding: 24px 20px; }
	.stats-grid { grid-template-columns: 1fr 1fr; }
	.panels-grid { grid-template-columns: 1fr; }
	.header-inner { flex-direction: column; gap: 12px; align-items: flex-start; }
}
</style>
</head>
<body>

<!-- ===== NAVBAR ===== -->
<div class="navbar">
	<a href="${pageContext.request.contextPath}/home" class="nav-logo">
		<span class="nav-logo-icon">🏀</span>
		<span class="nav-logo-text">SportShop</span>
	</a>
	<div class="nav-links">
		<a href="${pageContext.request.contextPath}/admin/analytics" class="active">📊 Thống kê</a>
		<a href="#">📦 Sản phẩm</a>
		<a href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a>
		<a href="${pageContext.request.contextPath}/login" class="logout">🚪 Đăng xuất</a>
	</div>
</div>

<!-- ===== PAGE HEADER ===== -->
<div class="page-header">
	<div class="header-inner">
		<h1>📊 Bảng thống kê doanh thu</h1>
		<span class="admin-badge">🛡️ Quyền: ADMIN</span>
	</div>
</div>

<!-- ===== MAIN CONTENT ===== -->
<div class="container">

	<!-- STAT CARDS -->
	<div class="stats-grid">
		<div class="stat-card revenue">
			<div class="stat-header">
				<div>
					<div class="stat-label">Tổng doanh thu</div>
					<div class="stat-value">
						<fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true" /> đ
					</div>
				</div>
				<div class="stat-icon">💰</div>
			</div>
		</div>

		<div class="stat-card orders">
			<div class="stat-header">
				<div>
					<div class="stat-label">Tổng đơn hàng</div>
					<div class="stat-value">${totalOrders}</div>
				</div>
				<div class="stat-icon">📦</div>
			</div>
		</div>

		<div class="stat-card customers">
			<div class="stat-header">
				<div>
					<div class="stat-label">Tổng khách hàng</div>
					<div class="stat-value">${totalCustomers}</div>
				</div>
				<div class="stat-icon">👥</div>
			</div>
		</div>

		<div class="stat-card products">
			<div class="stat-header">
				<div>
					<div class="stat-label">Tổng sản phẩm</div>
					<div class="stat-value">${totalProducts}</div>
				</div>
				<div class="stat-icon">🏷️</div>
			</div>
		</div>

		<div class="stat-card bills">
			<div class="stat-header">
				<div>
					<div class="stat-label">Hóa đơn đã xuất</div>
					<div class="stat-value">${totalBills}</div>
				</div>
				<div class="stat-icon">🧾</div>
			</div>
		</div>

		<div class="stat-card pending">
			<div class="stat-header">
				<div>
					<div class="stat-label">Đơn chờ xử lý</div>
					<div class="stat-value">${pendingOrders}</div>
				</div>
				<div class="stat-icon">⏳</div>
			</div>
		</div>
	</div>

	<!-- INFO PANELS -->
	<div class="panels-grid">
		<div class="panel">
			<div class="panel-header">
				<span class="icon">ℹ️</span>
				<h3>Thông tin hệ thống</h3>
			</div>
			<p>
				Dữ liệu thống kê được lấy trực tiếp từ cơ sở dữ liệu <code>sport_DB</code>.
				Tổng doanh thu được tính từ bảng <code>HOA_DON</code> (hóa đơn đã xuất).
				Số đơn hàng được đếm từ bảng <code>DON_HANG</code> bao gồm tất cả trạng thái.
			</p>
		</div>

		<div class="panel">
			<div class="panel-header">
				<span class="icon">⚡</span>
				<h3>Thao tác nhanh</h3>
			</div>
			<div class="quick-actions">
				<a href="${pageContext.request.contextPath}/home" class="action-item">
					<span class="action-icon">🏠</span>
					Về trang chủ
					<span class="arrow">→</span>
				</a>
				<a href="#" class="action-item">
					<span class="action-icon">📦</span>
					Quản lý sản phẩm
					<span class="arrow">→</span>
				</a>
				<a href="${pageContext.request.contextPath}/staff/orders" class="action-item">
					<span class="action-icon">🧾</span>
					Xem đơn hàng
					<span class="arrow">→</span>
				</a>
			</div>
		</div>
	</div>

	<a class="back-link" href="${pageContext.request.contextPath}/home">← Quay về trang chủ</a>

</div>

<!-- ===== FOOTER ===== -->
<div class="footer">
	<p>© 2026 <span class="brand">SportShop</span> — Hệ thống quản lý cửa hàng thể thao</p>
</div>

</body>
</html>