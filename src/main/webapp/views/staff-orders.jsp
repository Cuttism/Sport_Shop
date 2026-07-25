<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Đơn Hàng | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    .filter-bar {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
      padding: var(--space-md) var(--space-lg);
      border-bottom: 1px solid var(--border);
      overflow-x: auto;
      scrollbar-width: none;
    }
    .filter-bar::-webkit-scrollbar { display: none; }

    .filter-btn {
      padding: 7px 16px;
      border-radius: var(--radius-full);
      border: 1px solid var(--border-light);
      background: rgba(255,255,255,0.04);
      color: var(--text-muted);
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      transition: var(--transition-fast);
      white-space: nowrap;
    }

    .filter-btn:hover { border-color: rgba(255,107,53,0.3); color: var(--primary); }
    .filter-btn.active { background: rgba(255,107,53,0.1); color: var(--primary); border-color: rgba(255,107,53,0.35); }

    /* Status badges */
    .order-status { padding: 4px 12px; border-radius: var(--radius-full); font-size: 11px; font-weight: 700; white-space: nowrap; }
    .status-pending  { background: rgba(255,184,48,0.12); color: var(--warning); border: 1px solid rgba(255,184,48,0.25); }
    .status-shipping { background: rgba(78,205,196,0.12); color: var(--info);    border: 1px solid rgba(78,205,196,0.25); }
    .status-done     { background: rgba(0,214,127,0.12);  color: var(--success); border: 1px solid rgba(0,214,127,0.25); }
    .status-cancel   { background: rgba(255,71,87,0.12);  color: var(--danger);  border: 1px solid rgba(255,71,87,0.25); }

    /* Status Modal */
    .status-modal {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.7);
      align-items: center;
      justify-content: center;
      z-index: 2000;
      backdrop-filter: blur(4px);
    }
    .status-modal.open { display: flex; }
    .status-modal-box {
      background: var(--bg-navy);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-xl);
      padding: var(--space-xl);
      width: 400px;
      max-width: 90vw;
      animation: modalIn 0.25s ease-out;
    }
    @keyframes modalIn {
      from { opacity: 0; transform: scale(0.95) translateY(-16px); }
      to   { opacity: 1; transform: scale(1) translateY(0); }
    }
    .status-modal-title { font-family: var(--font-display); font-size: 20px; letter-spacing: 1px; color: var(--text-primary); margin-bottom: var(--space-xl); padding-bottom: var(--space-md); border-bottom: 1px solid var(--border); }

    .status-select {
      width: 100%;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      padding: 13px 16px;
      font-size: 14px;
      font-family: var(--font-body);
      outline: none;
      margin-bottom: var(--space-lg);
    }
    .status-select:focus { border-color: var(--primary); }
    .status-select option { background: var(--bg-navy); }
  </style>
</head>
<body>
<div class="admin-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="wordmark">SportShop</div>
      <span class="role-badge staff">Nhân Viên</span>
    </div>

    <div class="sidebar-user">
      <div class="sidebar-user-avatar">${sessionScope.currentUser.hoTen.substring(0,1)}</div>
      <div>
        <div class="sidebar-user-name">${sessionScope.currentUser.hoTen}</div>
        <div class="sidebar-user-id">${sessionScope.currentUser.id}</div>
      </div>
    </div>

    <nav class="sidebar-nav">
      <div class="sidebar-section-label">Quản Lý</div>
      <a href="${pageContext.request.contextPath}/staff/orders" class="sidebar-link active">
        <i class="fa-solid fa-clipboard-list"></i> Quản Lý Đơn Hàng
      </a>

      <div class="sidebar-section-label" style="margin-top:var(--space-md);">Cửa Hàng</div>
      <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
        <i class="fa-solid fa-house"></i> Về Trang Chủ
      </a>
      <a href="${pageContext.request.contextPath}/profile" class="sidebar-link">
        <i class="fa-solid fa-user"></i> Hồ Sơ Cá Nhân
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="${pageContext.request.contextPath}/login">
        <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
      </a>
    </div>
  </aside>

  <!-- MAIN CONTENT -->
  <div class="admin-main">
    <div class="admin-topbar">
      <h1>Quản Lý Đơn Hàng</h1>
      <span class="badge badge-success"><i class="fa-solid fa-shield-halved"></i> NHÂN VIÊN</span>
    </div>

    <div class="admin-content">
      <!-- Stat cards -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <div class="stat-card" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clipboard-list"></i></div>
          <div class="stat-card-value">${orders.size()}</div>
          <div class="stat-card-label">Tổng Đơn Hàng</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clock"></i></div>
          <div class="stat-card-value">
            <c:set var="pending" value="0"/>
            <c:forEach var="o" items="${orders}">
              <c:if test="${o.trangThai eq 'Chờ xử lý'}"><c:set var="pending" value="${pending + 1}"/></c:if>
            </c:forEach>
            ${pending}
          </div>
          <div class="stat-card-label">Chờ Xử Lý</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--info); --stat-bg:rgba(78,205,196,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-truck"></i></div>
          <div class="stat-card-value">
            <c:set var="shipping" value="0"/>
            <c:forEach var="o" items="${orders}">
              <c:if test="${o.trangThai eq 'Đang giao'}"><c:set var="shipping" value="${shipping + 1}"/></c:if>
            </c:forEach>
            ${shipping}
          </div>
          <div class="stat-card-label">Đang Giao</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-circle-check"></i></div>
          <div class="stat-card-value">
            <c:set var="done" value="0"/>
            <c:forEach var="o" items="${orders}">
              <c:if test="${o.trangThai eq 'Đã thanh toán'}"><c:set var="done" value="${done + 1}"/></c:if>
            </c:forEach>
            ${done}
          </div>
          <div class="stat-card-label">Hoàn Tất</div>
        </div>
      </div>

      <!-- Table -->
      <div class="data-table-wrap">
        <div class="filter-bar">
          <span style="font-size:13px; font-weight:600; color:var(--text-muted); margin-right:4px; white-space:nowrap;">Lọc:</span>
          <button class="filter-btn active" onclick="filterOrders('Tất cả', this)">Tất Cả</button>
          <button class="filter-btn" onclick="filterOrders('Chờ xử lý', this)">Chờ Xử Lý</button>
          <button class="filter-btn" onclick="filterOrders('Đang giao', this)">Đang Giao</button>
          <button class="filter-btn" onclick="filterOrders('Hoàn tất', this)">Hoàn Tất</button>
          <button class="filter-btn" onclick="filterOrders('Đã hủy', this)">Đã Hủy</button>
        </div>
        <table class="data-table">
          <thead>
            <tr>
              <th>Mã Đơn</th>
              <th>Khách Hàng</th>
              <th>Tổng Tiền</th>
              <th>Trạng Thái</th>
              <th>Thao Tác</th>
            </tr>
          </thead>
          <tbody id="orderTableBody">
            <c:forEach var="o" items="${orders}">
              <tr data-status="${o.trangThai eq 'Đã thanh toán' ? 'Hoàn tất' : o.trangThai}">
                <td><strong style="color:var(--primary); font-family:monospace;">#${o.id}</strong></td>
                <td style="color:var(--text-secondary); font-weight:500;">${o.tenKhachHang}</td>
                <td style="color:var(--primary); font-weight:700; font-family:var(--font-display); font-size:16px;">
                  <fmt:formatNumber value="${o.tongTien}" type="number" groupingUsed="true"/> đ
                </td>
                <td>
                  <c:choose>
                    <c:when test="${o.trangThai eq 'Chờ xử lý'}"><span class="order-status status-pending">${o.trangThai}</span></c:when>
                    <c:when test="${o.trangThai eq 'Đang giao'}"><span class="order-status status-shipping">${o.trangThai}</span></c:when>
                    <c:when test="${o.trangThai eq 'Đã thanh toán'}"><span class="order-status status-done">Hoàn Tất</span></c:when>
                    <c:when test="${o.trangThai eq 'Đã hủy'}"><span class="order-status status-cancel">${o.trangThai}</span></c:when>
                    <c:otherwise><span class="order-status status-pending">${o.trangThai}</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div style="display:flex; gap:var(--space-sm);">
                    <a href="${pageContext.request.contextPath}/staff/orders?action=details&orderId=${o.id}"
                       class="btn btn-sm" style="background:rgba(78,205,196,0.1);color:var(--info);border:1px solid rgba(78,205,196,0.3);">
                      <i class="fa-solid fa-eye"></i> Chi Tiết
                    </a>
                    <button class="btn btn-sm" style="background:rgba(255,184,48,0.1);color:var(--accent);border:1px solid rgba(255,184,48,0.3);"
                            onclick="openStatusModal('${o.id}', '${o.trangThai}')">
                      <i class="fa-solid fa-pen-to-square"></i> Cập Nhật
                    </button>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty orders}">
              <tr>
                <td colspan="5" style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
                  Chưa có đơn hàng nào.
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- STATUS UPDATE MODAL -->
<div class="status-modal" id="statusModal">
  <div class="status-modal-box">
    <div class="status-modal-title">Cập Nhật Trạng Thái Đơn Hàng</div>
    <form action="${pageContext.request.contextPath}/staff/orders" method="POST">
      <input type="hidden" name="action" value="updateStatus">
      <input type="hidden" name="orderId" id="modalOrderId">
      <div class="form-group">
        <label class="form-label">Mã Đơn Hàng: <strong id="modalOrderDisplay" style="color:var(--primary);"></strong></label>
      </div>
      <div class="form-group" style="margin-bottom:var(--space-lg);">
        <label class="form-label">Trạng Thái Mới</label>
        <select name="status" id="modalStatusSelect" class="status-select">
          <option value="Chờ xử lý">Chờ Xử Lý</option>
          <option value="Đang giao">Đang Giao</option>
          <option value="Đã thanh toán">Hoàn Tất (Đã Thanh Toán)</option>
          <option value="Đã hủy">Đã Hủy</option>
        </select>
      </div>
      <div style="display:flex; gap:var(--space-md);">
        <button type="submit" class="btn btn-primary btn-full btn-md">
          <i class="fa-solid fa-floppy-disk"></i> Lưu Cập Nhật
        </button>
        <button type="button" class="btn btn-secondary btn-md" onclick="closeStatusModal()">Hủy</button>
      </div>
    </form>
  </div>
</div>

<script>
  function filterOrders(status, btn) {
    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    document.querySelectorAll('#orderTableBody tr[data-status]').forEach(row => {
      row.style.display = (status === 'Tất cả' || row.dataset.status === status) ? '' : 'none';
    });
  }

  function openStatusModal(orderId, currentStatus) {
    document.getElementById('modalOrderId').value = orderId;
    document.getElementById('modalOrderDisplay').innerText = '#' + orderId;
    document.getElementById('modalStatusSelect').value = currentStatus;
    document.getElementById('statusModal').classList.add('open');
  }

  function closeStatusModal() {
    document.getElementById('statusModal').classList.remove('open');
  }

  document.getElementById('statusModal').addEventListener('click', function(e) {
    if (e.target === this) closeStatusModal();
  });
</script>
</body>
</html>
