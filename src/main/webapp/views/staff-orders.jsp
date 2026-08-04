<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Đơn Hàng | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body { background: var(--bg-deep); }

    /* Clickable Stat Cards */
    .stat-card-clickable {
      cursor: pointer;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      text-decoration: none;
      display: block;
    }
    .stat-card-clickable:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-md);
    }

    /* Filter Bar */
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

    /* Status Badges */
    .order-status { padding: 4px 12px; border-radius: var(--radius-full); font-size: 11px; font-weight: 700; white-space: nowrap; }
    .status-pending  { background: rgba(255,184,48,0.12); color: var(--warning); border: 1px solid rgba(255,184,48,0.25); }
    .status-shipping { background: rgba(78,205,196,0.12); color: var(--info);    border: 1px solid rgba(78,205,196,0.25); }
    .status-done     { background: rgba(0,214,127,0.12);  color: var(--success); border: 1px solid rgba(0,214,127,0.25); }
    .status-cancel   { background: rgba(255,71,87,0.12);  color: var(--danger);  border: 1px solid rgba(255,71,87,0.25); }

    /* Modal Standard Style */
    .modal {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.75);
      align-items: center;
      justify-content: center;
      z-index: 2000;
      backdrop-filter: blur(4px);
    }
    .modal.open { display: flex; }
    .modal-box {
      background: var(--bg-navy);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-xl);
      padding: var(--space-xl);
      width: 480px;
      max-width: 95vw;
      box-shadow: var(--shadow-lg);
      animation: modalIn 0.25s ease-out;
    }
    @keyframes modalIn {
      from { opacity: 0; transform: scale(0.95) translateY(-16px); }
      to   { opacity: 1; transform: scale(1) translateY(0); }
    }
    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-xl);
      padding-bottom: var(--space-md);
      border-bottom: 1px solid var(--border);
    }
    .modal-title { font-family: var(--font-display); font-size: 20px; letter-spacing: 1px; color: var(--text-primary); }
    .modal-close {
      width: 32px; height: 32px; border-radius: var(--radius-md);
      background: rgba(255,255,255,0.06); border: 1px solid var(--border);
      color: var(--text-muted); font-size: 18px; cursor: pointer;
      display: flex; align-items: center; justify-content: center;
      transition: var(--transition-fast); line-height: 1;
    }
    .modal-close:hover { background: rgba(255,71,87,0.15); color: var(--danger); }

    .status-select {
      width: 100%;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      padding: 12px 16px;
      font-size: 14px;
      outline: none;
      margin-bottom: var(--space-lg);
    }
    .status-select:focus { border-color: var(--primary); }
    .status-select option { background: var(--bg-navy); }

    /* Order Details Table inside Modal */
    .detail-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .detail-table th, .detail-table td { padding: 10px 0; border-bottom: 1px solid var(--border); font-size: 13px; text-align: left; }
    .detail-table th { color: var(--text-muted); font-weight: 600; }
  </style>
</head>
<body>
<div class="admin-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="wordmark">SportShop</div>
      <span class="role-badge ${sessionScope.currentUser.role == 'ADMIN' ? 'admin' : 'staff'}">
        ${sessionScope.currentUser.role == 'ADMIN' ? 'Quản Trị Viên' : 'Nhân Viên'}
      </span>
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
      <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sidebar-link">
          <i class="fa-solid fa-chart-line"></i> Thống Kê & Báo Cáo
        </a>
      </c:if>
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
      <span class="badge ${sessionScope.currentUser.role == 'ADMIN' ? 'badge-warning' : 'badge-success'}">
        <i class="fa-solid ${sessionScope.currentUser.role == 'ADMIN' ? 'fa-shield-halved' : 'fa-user-gear'}"></i> 
        ${sessionScope.currentUser.role == 'ADMIN' ? 'ADMIN' : 'NHÂN VIÊN'}
      </span>
    </div>

    <div class="admin-content">
      <!-- STAT CARDS (CLICK ĐỂ LỌC TRỰC TIẾP) -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <div class="stat-card stat-card-clickable" onclick="filterByCard('Tất cả')" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clipboard-list"></i></div>
          <div class="stat-card-value">${orders.size()}</div>
          <div class="stat-card-label">Tổng Đơn Hàng</div>
        </div>

        <div class="stat-card stat-card-clickable" onclick="filterByCard('Chờ xử lý')" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
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

        <div class="stat-card stat-card-clickable" onclick="filterByCard('Đang giao')" style="--stat-color:var(--info); --stat-bg:rgba(78,205,196,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-truck-fast"></i></div>
          <div class="stat-card-value">
            <c:set var="shipping" value="0"/>
            <c:forEach var="o" items="${orders}">
              <c:if test="${o.trangThai eq 'Đang giao'}"><c:set var="shipping" value="${shipping + 1}"/></c:if>
            </c:forEach>
            ${shipping}
          </div>
          <div class="stat-card-label">Đang Giao</div>
        </div>

        <div class="stat-card stat-card-clickable" onclick="filterByCard('Hoàn tất')" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-circle-check"></i></div>
          <div class="stat-card-value">
            <c:set var="done" value="0"/>
            <c:forEach var="o" items="${orders}">
              <c:if test="${o.trangThai eq 'Đã thanh toán' or o.trangThai eq 'Hoàn tất'}"><c:set var="done" value="${done + 1}"/></c:if>
            </c:forEach>
            ${done}
          </div>
          <div class="stat-card-label">Hoàn Tất</div>
        </div>
      </div>

      <!-- TABLE & FILTER BAR -->
      <div class="data-table-wrap">
        <div class="filter-bar">
          <span style="font-size:13px; font-weight:600; color:var(--text-muted); margin-right:4px; white-space:nowrap;">Lọc nhanh:</span>
          <button class="filter-btn active" id="btn-all" onclick="filterOrders('Tất cả', this)">Tất Cả</button>
          <button class="filter-btn" id="btn-pending" onclick="filterOrders('Chờ xử lý', this)">Chờ Xử Lý</button>
          <button class="filter-btn" id="btn-shipping" onclick="filterOrders('Đang giao', this)">Đang Giao</button>
          <button class="filter-btn" id="btn-done" onclick="filterOrders('Hoàn tất', this)">Hoàn Tất</button>
          <button class="filter-btn" id="btn-cancel" onclick="filterOrders('Đã hủy', this)">Đã Hủy</button>
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
              <tr data-status="${(o.trangThai eq 'Đã thanh toán' or o.trangThai eq 'Hoàn tất') ? 'Hoàn tất' : o.trangThai}">
                <td><strong style="color:var(--primary); font-family:monospace;">#${o.id}</strong></td>
                <td style="color:var(--text-secondary); font-weight:500;">${o.tenKhachHang}</td>
                <td style="color:var(--primary); font-weight:700; font-family:var(--font-display); font-size:16px;">
                  <fmt:formatNumber value="${o.tongTien}" type="number" groupingUsed="true"/> đ
                </td>
                <td>
                  <c:choose>
                    <c:when test="${o.trangThai eq 'Chờ xử lý'}"><span class="order-status status-pending">Chờ Xử Lý</span></c:when>
                    <c:when test="${o.trangThai eq 'Đang giao'}"><span class="order-status status-shipping">Đang Giao</span></c:when>
                    <c:when test="${o.trangThai eq 'Đã thanh toán' or o.trangThai eq 'Hoàn tất'}"><span class="order-status status-done">Hoàn Tất</span></c:when>
                    <c:when test="${o.trangThai eq 'Đã hủy'}"><span class="order-status status-cancel">Đã Hủy</span></c:when>
                    <c:otherwise><span class="order-status status-pending">${o.trangThai}</span></c:otherwise>
                  </c:choose>
                </td>
                <td>
                  <div style="display:flex; gap:var(--space-sm);">
                    <button class="btn btn-sm" style="background:rgba(78,205,196,0.1);color:var(--info);border:1px solid rgba(78,205,196,0.3);"
                            onclick="openDetailModal('${o.id}', '${o.tenKhachHang}', '<fmt:formatNumber value="${o.tongTien}" type="number" groupingUsed="true"/> đ')">
                      <i class="fa-solid fa-eye"></i> Chi Tiết
                    </button>

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
                  Chưa có đơn hàng nào trong hệ thống!
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>

<!-- MODAL CẬP NHẬT TRẠNG THÁI -->
<div class="modal" id="statusModal">
  <div class="modal-box">
    <div class="modal-header">
      <div class="modal-title">Cập Nhật Đơn Hàng <span id="modalOrderDisplay" style="color:var(--primary);"></span></div>
      <button class="modal-close" onclick="closeStatusModal()">&times;</button>
    </div>
    <form action="${pageContext.request.contextPath}/staff/orders" method="POST">
      <input type="hidden" name="action" value="updateStatus">
      <input type="hidden" name="orderId" id="modalOrderId">
      
      <div class="form-group" style="margin-bottom:var(--space-lg);">
        <label class="form-label" style="margin-bottom:8px; display:block;">Trạng Thái Mới</label>
        <select name="status" id="modalStatusSelect" class="status-select">
          <option value="Chờ xử lý">Chờ Xử Lý</option>
          <option value="Đang giao">Đang Giao</option>
          <option value="Hoàn tất">Hoàn Tất (Đã Thanh Toán)</option>
          <option value="Đã hủy">Đã Hủy</option>
        </select>
      </div>

      <div style="display:flex; gap:var(--space-md);">
        <button type="submit" class="btn btn-primary btn-full btn-md">
          <i class="fa-solid fa-floppy-disk"></i> Lưu Thay Đổi
        </button>
        <button type="button" class="btn btn-secondary btn-md" onclick="closeStatusModal()">Hủy</button>
      </div>
    </form>
  </div>
</div>

<!-- MODAL CHI TIẾT ĐƠN HÀNG -->
<div class="modal" id="detailModal">
  <div class="modal-box" style="width: 540px;">
    <div class="modal-header">
      <div class="modal-title">Chi Tiết Đơn Hàng <span id="detailOrderId" style="color:var(--primary);"></span></div>
      <button class="modal-close" onclick="closeDetailModal()">&times;</button>
    </div>

    <div style="font-size: 13px; color: var(--text-muted); margin-bottom: 16px;">
      <p style="margin-bottom: 6px;"><strong style="color:var(--text-primary);">Khách hàng:</strong> <span id="detailCustomer">---</span></p>
      <p style="margin-bottom: 6px;"><strong style="color:var(--text-primary);">Số điện thoại:</strong> 0905 123 456</p>
      <p style="margin-bottom: 6px;"><strong style="color:var(--text-primary);">Địa chỉ giao:</strong> Thành phố Huế, Thừa Thiên Huế</p>
      <p><strong style="color:var(--text-primary);">Hình thức:</strong> Thanh toán khi nhận hàng (COD)</p>
    </div>

    <table class="detail-table" style="margin-bottom: 16px;">
      <thead>
        <tr>
          <th>Sản Phẩm</th>
          <th style="text-align: center;">SL</th>
          <th style="text-align: right;">Đơn Giá</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td style="color: var(--text-primary);">Giày Thể Thao Pro Runner 2026</td>
          <td style="text-align: center;">1</td>
          <td style="text-align: right; color: var(--primary); font-weight: 600;">1,500,000 đ</td>
        </tr>
        <tr>
          <td style="color: var(--text-primary);">Áo Tập Gym Co Giãn 4 Chiều</td>
          <td style="text-align: center;">2</td>
          <td style="text-align: right; color: var(--primary); font-weight: 600;">650,000 đ</td>
        </tr>
      </tbody>
    </table>

    <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 12px; border-top: 2px dashed var(--border);">
      <span style="font-weight: 700; color: var(--text-primary);">TỔNG CỘNG:</span>
      <span style="font-family: var(--font-display); font-size: 20px; color: var(--primary); font-weight: 700;" id="detailTotal">0 đ</span>
    </div>
  </div>
</div>

<script>
  // Filter Table function
  function filterOrders(status, btn) {
    document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
    if(btn) btn.classList.add('active');
    
    document.querySelectorAll('#orderTableBody tr[data-status]').forEach(row => {
      row.style.display = (status === 'Tất cả' || row.dataset.status === status) ? '' : 'none';
    });
  }

  // Click Stat Cards to Filter
  function filterByCard(status) {
    let btnId = 'btn-all';
    if(status === 'Chờ xử lý') btnId = 'btn-pending';
    else if(status === 'Đang giao') btnId = 'btn-shipping';
    else if(status === 'Hoàn tất') btnId = 'btn-done';
    
    const targetBtn = document.getElementById(btnId);
    filterOrders(status, targetBtn);
  }

  // Status Modal Controls
  function openStatusModal(orderId, currentStatus) {
    document.getElementById('modalOrderId').value = orderId;
    document.getElementById('modalOrderDisplay').innerText = '#' + orderId;
    
    let val = currentStatus;
    if(currentStatus === 'Đã thanh toán') val = 'Hoàn tất';
    document.getElementById('modalStatusSelect').value = val;
    
    document.getElementById('statusModal').classList.add('open');
  }

  function closeStatusModal() {
    document.getElementById('statusModal').classList.remove('open');
  }

  // Detail Modal Controls
  function openDetailModal(orderId, customerName, total) {
    document.getElementById('detailOrderId').innerText = '#' + orderId;
    document.getElementById('detailCustomer').innerText = customerName;
    if(total) document.getElementById('detailTotal').innerText = total;
    document.getElementById('detailModal').classList.add('open');
  }

  function closeDetailModal() {
    document.getElementById('detailModal').classList.remove('open');
  }

  // Close Modals on Outer Click
  window.addEventListener('click', function(e) {
    const statusModal = document.getElementById('statusModal');
    const detailModal = document.getElementById('detailModal');
    if (e.target === statusModal) closeStatusModal();
    if (e.target === detailModal) closeDetailModal();
  });
</script>
</body>
</html>