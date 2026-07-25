<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thống Kê Doanh Thu | SportShop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    .analytics-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: var(--space-xl);
    }

    .analytics-panel {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      overflow: hidden;
    }

    .panel-head {
      padding: var(--space-md) var(--space-lg);
      border-bottom: 1px solid var(--border);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .panel-head i { color: var(--primary); font-size: 15px; }

    .panel-head h3 {
      font-size: 15px;
      font-weight: 700;
      color: var(--text-secondary);
    }

    .panel-body { padding: var(--space-lg); }

    .info-row {
      display: flex;
      align-items: flex-start;
      gap: var(--space-sm);
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.6;
      margin-bottom: var(--space-sm);
    }

    .info-row i { color: var(--primary); margin-top: 3px; font-size: 12px; flex-shrink: 0; }

    code {
      background: rgba(255,107,53,0.1);
      color: var(--primary-light);
      padding: 1px 6px;
      border-radius: 4px;
      font-size: 12px;
      font-family: 'Consolas', monospace;
    }

    .quick-link {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 13px 16px;
      border-radius: var(--radius-md);
      border: 1px solid var(--border);
      background: rgba(255,255,255,0.03);
      color: var(--text-secondary);
      font-size: 14px;
      font-weight: 500;
      transition: var(--transition-fast);
      margin-bottom: var(--space-sm);
    }

    .quick-link:hover {
      border-color: rgba(255,107,53,0.35);
      background: rgba(255,107,53,0.06);
      color: var(--primary);
    }

    .quick-link i { font-size: 14px; }
    .quick-link-arrow { color: var(--text-faint); font-size: 12px; }
    .quick-link:hover .quick-link-arrow { color: var(--primary); }
  </style>
</head>
<body>
<div class="admin-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="wordmark">SportShop</div>
      <span class="role-badge admin">Quản Trị Viên</span>
    </div>

    <div class="sidebar-user">
      <div class="sidebar-user-avatar">${sessionScope.currentUser.hoTen.substring(0,1)}</div>
      <div>
        <div class="sidebar-user-name">${sessionScope.currentUser.hoTen}</div>
        <div class="sidebar-user-id">${sessionScope.currentUser.id}</div>
      </div>
    </div>

    <nav class="sidebar-nav">
      <div class="sidebar-section-label">Quản Trị</div>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="sidebar-link active">
        <i class="fa-solid fa-chart-line"></i> Thống Kê & Báo Cáo
      </a>
      <a href="${pageContext.request.contextPath}/admin/products" class="sidebar-link">
        <i class="fa-solid fa-box-open"></i> Quản Lý Sản Phẩm
      </a>

      <div class="sidebar-section-label" style="margin-top:var(--space-md);">Cửa Hàng</div>
      <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
        <i class="fa-solid fa-house"></i> Về Trang Chủ
      </a>
      <a href="${pageContext.request.contextPath}/staff/orders" class="sidebar-link">
        <i class="fa-solid fa-clipboard-list"></i> Xem Đơn Hàng
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
      <h1>Thống Kê & Báo Cáo</h1>
      <span class="badge badge-warning"><i class="fa-solid fa-shield-halved"></i> ADMIN</span>
    </div>

    <div class="admin-content">

      <!-- Welcome -->
      <div style="margin-bottom:var(--space-xl);">
        <div style="font-size:13px; color:var(--text-faint); margin-bottom:4px;">Tổng quan hệ thống</div>
        <div style="font-family:var(--font-display); font-size:28px; letter-spacing:1px; color:var(--text-primary);">
          Bảng Thống Kê <span style="color:var(--primary);">Doanh Thu</span>
        </div>
      </div>

      <!-- Stat Cards -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <div class="stat-card" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-chart-line"></i></div>
          <div class="stat-card-value">
            <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>
          </div>
          <div class="stat-card-label">Tổng Doanh Thu (đ)</div>
        </div>

        <div class="stat-card" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clipboard-list"></i></div>
          <div class="stat-card-value">${totalOrders}</div>
          <div class="stat-card-label">Tổng Đơn Hàng</div>
        </div>

        <div class="stat-card" style="--stat-color:var(--info); --stat-bg:rgba(78,205,196,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-users"></i></div>
          <div class="stat-card-value">${totalCustomers}</div>
          <div class="stat-card-label">Tổng Khách Hàng</div>
        </div>

        <div class="stat-card" style="--stat-color:var(--accent); --stat-bg:rgba(255,184,48,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
          <div class="stat-card-value">${totalProducts}</div>
          <div class="stat-card-label">Tổng Sản Phẩm</div>
        </div>

        <div class="stat-card" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-file-invoice-dollar"></i></div>
          <div class="stat-card-value">${totalBills}</div>
          <div class="stat-card-label">Hóa Đơn Đã Xuất</div>
        </div>

        <div class="stat-card" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clock"></i></div>
          <div class="stat-card-value">${pendingOrders}</div>
          <div class="stat-card-label">Đơn Chờ Xử Lý</div>
        </div>
      </div>

      <!-- Info Panels -->
      <div class="analytics-grid">
        <div class="analytics-panel">
          <div class="panel-head">
            <i class="fa-solid fa-circle-info"></i>
            <h3>Thông Tin Hệ Thống</h3>
          </div>
          <div class="panel-body">
            <div class="info-row">
              <i class="fa-solid fa-database"></i>
              <span>Dữ liệu thống kê được lấy trực tiếp từ cơ sở dữ liệu <code>sport_DB</code>.</span>
            </div>
            <div class="info-row">
              <i class="fa-solid fa-file-invoice-dollar"></i>
              <span>Tổng doanh thu được tính từ bảng <code>HOA_DON</code> — chỉ tính hóa đơn đã xuất.</span>
            </div>
            <div class="info-row">
              <i class="fa-solid fa-clipboard-list"></i>
              <span>Tổng đơn hàng đếm từ bảng <code>DON_HANG</code>, bao gồm tất cả trạng thái.</span>
            </div>
            <div class="info-row">
              <i class="fa-solid fa-users"></i>
              <span>Số khách hàng đếm từ bảng <code>KHACH_HANG</code> trong hệ thống.</span>
            </div>
            <div class="info-row">
              <i class="fa-solid fa-clock-rotate-left"></i>
              <span>Dữ liệu được cập nhật theo thời gian thực mỗi khi tải trang.</span>
            </div>
          </div>
        </div>

        <div class="analytics-panel">
          <div class="panel-head">
            <i class="fa-solid fa-bolt"></i>
            <h3>Thao Tác Nhanh</h3>
          </div>
          <div class="panel-body">
            <a href="${pageContext.request.contextPath}/admin/products" class="quick-link">
              <div style="display:flex; align-items:center; gap:10px;">
                <i class="fa-solid fa-box-open" style="color:var(--primary);"></i>
                Quản Lý Sản Phẩm
              </div>
              <i class="fa-solid fa-chevron-right quick-link-arrow"></i>
            </a>
            <a href="${pageContext.request.contextPath}/staff/orders" class="quick-link">
              <div style="display:flex; align-items:center; gap:10px;">
                <i class="fa-solid fa-clipboard-list" style="color:var(--success);"></i>
                Xem & Quản Lý Đơn Hàng
              </div>
              <i class="fa-solid fa-chevron-right quick-link-arrow"></i>
            </a>
            <a href="${pageContext.request.contextPath}/home" class="quick-link">
              <div style="display:flex; align-items:center; gap:10px;">
                <i class="fa-solid fa-house" style="color:var(--text-muted);"></i>
                Về Trang Chủ
              </div>
              <i class="fa-solid fa-chevron-right quick-link-arrow"></i>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="quick-link">
              <div style="display:flex; align-items:center; gap:10px;">
                <i class="fa-solid fa-user" style="color:var(--text-muted);"></i>
                Hồ Sơ Cá Nhân
              </div>
              <i class="fa-solid fa-chevron-right quick-link-arrow"></i>
            </a>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>
</body>
</html>