<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Quản lý đơn hàng - Nhân viên | SportShop</title>
<style>
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f8f9fa;
	color: #333;
}

.navbar {
	background-color: #1e1e24;
	color: white;
	padding: 15px 30px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.navbar a {
	color: #bbb;
	text-decoration: none;
	margin-left: 20px;
	font-size: 15px;
	transition: 0.3s;
}

.navbar a:hover {
	color: #4effef;
}

.logo {
	font-weight: bold;
	font-size: 22px;
	color: #4effef;
	text-decoration: none;
}

.container {
	max-width: 1200px;
	margin: 30px auto;
	padding: 0 20px;
}

.page-title {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.page-title h2 {
	color: #1e1e24;
	font-size: 22px;
}

.badge {
	background-color: #ffc107;
	color: #1e1e24;
	padding: 5px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: bold;
	letter-spacing: 0.5px;
}

.toolbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16px;
}

.toolbar h3 {
	font-size: 15px;
	color: #555;
	font-weight: 600;
}

.filter-tabs {
	display: flex;
	gap: 8px;
}

.filter-tabs button {
	border: none;
	background: #eef0f2;
	color: #333;
	padding: 7px 16px;
	border-radius: 20px;
	font-size: 13px;
	cursor: pointer;
	font-weight: 600;
	transition: 0.2s;
}

.filter-tabs button:hover {
	background: #dfe3e6;
}

.filter-tabs button.active {
	background: #1e1e24;
	color: #4effef;
}

table {
	width: 100%;
	border-collapse: collapse;
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
}

thead {
	background: #1e1e24;
}

th {
	color: #4effef;
	font-weight: 600;
	text-transform: uppercase;
	font-size: 12px;
	padding: 14px 16px;
	text-align: left;
}

td {
	padding: 14px 16px;
	font-size: 14px;
	border-bottom: 1px solid #eef1f5;
}

tbody tr:hover {
	background: #f8fafc;
}

.status {
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
}

.status.pending {
	background: #fff3cd;
	color: #b45309;
}

.status.shipping {
	background: #d6f7ff;
	color: #0369a1;
}

.status.done {
	background: #d6f5df;
	color: #15803d;
}

.status.cancel {
	background: #ffe1e1;
	color: #b91c1c;
}

.btn-action {
	border: none;
	background: #1e1e24;
	color: #4effef;
	padding: 7px 14px;
	border-radius: 20px;
	font-size: 12px;
	font-weight: 600;
	cursor: pointer;
	transition: 0.2s;
}

.btn-action:hover {
	background: #28a745;
	color: #fff;
}

.back-link {
	display: inline-block;
	margin-top: 24px;
	color: #1e1e24;
	font-weight: 600;
	text-decoration: none;
	font-size: 14px;
}

.back-link:hover {
	color: #4effef;
}
</style>
</head>
<body>

	<div class="navbar">
		<a href="${pageContext.request.contextPath}/home" class="logo">👟
			SportShop</a>
		<div>
			<a href="${pageContext.request.contextPath}/staff/orders">Đơn
				hàng</a> <a href="#">Sản phẩm</a> <a
				href="${pageContext.request.contextPath}/login"
				style="color: #ff4d4d;">Đăng xuất</a>
		</div>
	</div>

	<div class="container">

		<div class="page-title">
			<h2>🧾 Quản lý đơn hàng</h2>
			<span class="badge">Quyền: STAFF (NVBH)</span>
		</div>

		<div class="toolbar">
			<h3>Danh sách đơn hàng gần đây</h3>
			<div class="filter-tabs">
				<button class="active">Tất cả</button>
				<button>Chờ xử lý</button>
				<button>Đang giao</button>
				<button>Hoàn tất</button>
			</div>
		</div>

		<table>
			<thead>
				<tr>
					<th>Mã đơn</th>
					<th>Khách hàng</th>
					<th>Ngày đặt</th>
					<th>Tổng tiền</th>
					<th>Trạng thái</th>
					<th>Thao tác</th>
				</tr>
			</thead>
			<tbody>
				<!--
					Dữ liệu mẫu tĩnh. Khi có DAO thật, dùng:
					<c:forEach var="o" items="${orders}"> ... </c:forEach>
				-->
				<tr>
					<td>#DH1001</td>
					<td>Phạm Minh Hoàng</td>
					<td>02/07/2026</td>
					<td>1.250.000 đ</td>
					<td><span class="status pending">Chờ xử lý</span></td>
					<td><button class="btn-action">Xử lý</button></td>
				</tr>
				<tr>
					<td>#DH1002</td>
					<td>Trần Thị Lan</td>
					<td>02/07/2026</td>
					<td>560.000 đ</td>
					<td><span class="status shipping">Đang giao</span></td>
					<td><button class="btn-action">Cập nhật</button></td>
				</tr>
				<tr>
					<td>#DH1003</td>
					<td>Nguyễn Văn An</td>
					<td>01/07/2026</td>
					<td>2.100.000 đ</td>
					<td><span class="status done">Hoàn tất</span></td>
					<td><button class="btn-action">Xem</button></td>
				</tr>
				<tr>
					<td>#DH1004</td>
					<td>Lê Thị Hằng</td>
					<td>30/06/2026</td>
					<td>340.000 đ</td>
					<td><span class="status cancel">Đã hủy</span></td>
					<td><button class="btn-action">Xem</button></td>
				</tr>
			</tbody>
		</table>

		<a class="back-link" href="${pageContext.request.contextPath}/home">&larr;
			Quay về trang chủ</a>
	</div>

</body>
</html>
