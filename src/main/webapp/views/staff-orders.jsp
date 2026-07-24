<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý đơn hàng - Nhân viên | SportShop</title>
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
.nav-logo-icon { font-size: 28px; }
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
.staff-badge {
    display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px;
    border-radius: 30px; font-size: 13px; font-weight: 700;
    background: rgba(255, 184, 48, 0.15); color: #FFB830; border: 1px solid rgba(255, 184, 48, 0.3);
}

/* MAIN CONTENT */
.container {
    max-width: 1200px; margin: 0 auto; padding: 32px 40px; width: 100%; flex: 1;
}

.toolbar {
    display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;
}
.toolbar h3 { font-size: 18px; color: #1B2838; font-weight: 700; }
.filter-tabs { display: flex; gap: 12px; }
.filter-tabs button {
    border: 1px solid #E8ECF0; background: #fff; color: #6B7C93;
    padding: 8px 16px; border-radius: 8px; font-size: 13px; cursor: pointer;
    font-weight: 600; transition: 0.3s;
}
.filter-tabs button:hover { border-color: #FF6B35; color: #FF6B35; }
.filter-tabs button.active { background: #FF6B35; color: #fff; border-color: #FF6B35; }

/* TABLE */
.table-container {
    background: #fff; border-radius: 14px; overflow: hidden;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03); border: 1px solid #E8ECF0;
}
table { width: 100%; border-collapse: collapse; }
thead { background: #F8F9FA; border-bottom: 1px solid #E8ECF0; }
th {
    color: #4A5E75; font-weight: 700; text-transform: uppercase;
    font-size: 12px; padding: 16px; text-align: left; letter-spacing: 0.5px;
}
td { padding: 16px; font-size: 14px; border-bottom: 1px solid #F0F2F5; vertical-align: middle; }
tbody tr:hover { background: rgba(255, 107, 53, 0.02); }

.status { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 700; display: inline-block; }
.status.pending { background: rgba(255, 184, 48, 0.15); color: #D48F00; }
.status.shipping { background: rgba(59, 130, 246, 0.15); color: #2563EB; }
.status.done { background: rgba(0, 214, 127, 0.15); color: #00A360; }
.status.cancel { background: rgba(255, 71, 87, 0.15); color: #E02334; }

.btn-action {
    border: none; background: rgba(27, 40, 56, 0.05); color: #1B2838;
    padding: 8px 16px; border-radius: 8px; font-size: 13px; font-weight: 600;
    cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-block;
}
.btn-action:hover { background: #1B2838; color: #fff; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }

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

/* MODAL */
.modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999; justify-content: center; align-items: center; }
.modal { background: #fff; padding: 24px 32px; border-radius: 12px; width: 400px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
.modal h3 { margin-bottom: 16px; color: #1B2838; }
.modal select { width: 100%; padding: 10px; margin-bottom: 20px; border: 1px solid #E8ECF0; border-radius: 8px; outline: none; font-family: 'Inter'; font-size: 14px;}
.modal-actions { display: flex; justify-content: flex-end; gap: 10px; }
.btn-cancel { padding: 8px 16px; border: 1px solid #E8ECF0; background: #fff; border-radius: 8px; cursor: pointer; font-weight: 600;}
.btn-save { padding: 8px 16px; background: #00D67F; color: #fff; border: none; border-radius: 8px; cursor: pointer; font-weight: 600;}
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
        <h1>Quản lý Đơn hàng</h1>
        <span class="staff-badge">Quyền: NHÂN VIÊN</span>
    </div>
</div>

<div class="container">
    <div class="toolbar">
        <h3>Danh sách đơn hàng gần đây</h3>
        <div class="filter-tabs">
            <button class="active" onclick="filterOrders('Tất cả', this)">Tất cả</button>
            <button onclick="filterOrders('Chờ xử lý', this)">Chờ xử lý</button>
            <button onclick="filterOrders('Đang giao', this)">Đang giao</button>
            <button onclick="filterOrders('Hoàn tất', this)">Hoàn tất</button>
        </div>
    </div>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody id="orderTableBody">
                <c:forEach var="o" items="${orders}">
                    <tr data-status="${o.trangThai eq 'Đã thanh toán' ? 'Hoàn tất' : o.trangThai}">
                        <td style="font-weight: 700;">#${o.id}</td>
                        <td>${o.tenKhachHang}</td>
                        <td style="font-weight: 700; color: #1B2838;"><fmt:formatNumber value="${o.tongTien}" type="number"/> đ</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.trangThai eq 'Chờ xử lý'}"><span class="status pending">${o.trangThai}</span></c:when>
                                <c:when test="${o.trangThai eq 'Đang giao'}"><span class="status shipping">${o.trangThai}</span></c:when>
                                <c:when test="${o.trangThai eq 'Đã thanh toán'}"><span class="status done">Hoàn tất</span></c:when>
                                <c:when test="${o.trangThai eq 'Đã hủy'}"><span class="status cancel">${o.trangThai}</span></c:when>
                                <c:otherwise><span class="status pending">${o.trangThai}</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a class="btn-action" href="${pageContext.request.contextPath}/staff/orders?action=details&orderId=${o.id}" style="margin-right: 5px;">Chi tiết</a>
                            <button class="btn-action" onclick="openModal('${o.id}', '${o.trangThai}')">Cập nhật</button>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr><td colspan="5" style="text-align: center; padding: 20px;">Không có đơn hàng nào</td></tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <a class="back-link" href="${pageContext.request.contextPath}/home">← Quay về trang chủ</a>
</div>

<div class="footer">
    <p>© 2026 <span class="brand">SportShop</span> — Hệ thống quản lý cửa hàng thể thao</p>
</div>

<!-- MODAL UPDATE STATUS -->
<div class="modal-overlay" id="statusModal">
    <div class="modal">
        <h3>Cập nhật trạng thái đơn hàng</h3>
        <form action="${pageContext.request.contextPath}/staff/orders" method="POST">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="orderId" id="modalOrderId">
            <select name="status" id="modalStatusSelect">
                <option value="Chờ xử lý">Chờ xử lý</option>
                <option value="Đang giao">Đang giao</option>
                <option value="Đã thanh toán">Hoàn tất (Đã thanh toán)</option>
                <option value="Đã hủy">Đã hủy</option>
            </select>
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeModal()">Hủy</button>
                <button type="submit" class="btn-save">Lưu cập nhật</button>
            </div>
        </form>
    </div>
</div>

<script>
function filterOrders(status, btn) {
    // Update active button
    var buttons = document.querySelectorAll('.filter-tabs button');
    buttons.forEach(function(b) { b.classList.remove('active'); });
    btn.classList.add('active');
    
    // Filter rows
    var rows = document.querySelectorAll('#orderTableBody tr[data-status]');
    rows.forEach(function(row) {
        if (status === 'Tất cả' || row.getAttribute('data-status') === status) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
}

function openModal(orderId, currentStatus) {
    document.getElementById('modalOrderId').value = orderId;
    document.getElementById('modalStatusSelect').value = currentStatus;
    document.getElementById('statusModal').style.display = 'flex';
}

function closeModal() {
    document.getElementById('statusModal').style.display = 'none';
}
</script>

</body>
</html>
