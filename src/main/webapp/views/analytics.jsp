<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thống Kê & Báo Cáo | SportShop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
  <!-- TÍCH HỢP CHART.JS QUA CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <style>
    body { background: var(--bg-deep); }

    /* Layout lưới cho biểu đồ */
    .charts-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: var(--space-xl);
      margin-bottom: var(--space-xl);
    }

    .chart-card {
      background: var(--bg-navy);
      border: 1px solid var(--border);
      border-radius: var(--radius-xl);
      padding: var(--space-lg);
      box-shadow: var(--shadow-md);
    }

    .chart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-md);
      padding-bottom: var(--space-sm);
      border-bottom: 1px solid var(--border);
    }

    .chart-title {
      font-family: var(--font-display);
      font-size: 16px;
      color: var(--text-primary);
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .chart-container {
      position: relative;
      width: 100%;
      height: 280px;
    }

    @media (max-width: 1100px) {
      .charts-grid { grid-template-columns: 1fr; }
    }
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
      <div class="sidebar-section-label">QUẢN TRỊ</div>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="sidebar-link active">
        <i class="fa-solid fa-chart-line"></i> Thống Kê & Báo Cáo
      </a>
      <a href="${pageContext.request.contextPath}/admin/products" class="sidebar-link">
        <i class="fa-solid fa-box-open"></i> Quản Lý Sản Phẩm
      </a>

      <div class="sidebar-section-label" style="margin-top:var(--space-md);">CỬA HÀNG</div>
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
      <div>
        <span style="font-size: 13px; color: var(--text-muted);">Tổng quan hệ thống</span>
        <h1 style="margin: 0;">BẢNG THỐNG KÊ <span style="color:var(--primary);">DOANH THU</span></h1>
      </div>
      <span class="badge badge-warning"><i class="fa-solid fa-shield-halved"></i> ADMIN</span>
    </div>

    <div class="admin-content">

      <!-- STAT CARDS HÀNG TRÊN -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <div class="stat-card" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-chart-line"></i></div>
          <div class="stat-card-value">30,350,000 đ</div>
          <div class="stat-card-label">Tổng Doanh Thu</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--info); --stat-bg:rgba(0,184,217,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-clipboard-list"></i></div>
          <div class="stat-card-value">12</div>
          <div class="stat-card-label">Tổng Đơn Hàng</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-users"></i></div>
          <div class="stat-card-value">7</div>
          <div class="stat-card-label">Tổng Khách Hàng</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
          <div class="stat-card-value">11</div>
          <div class="stat-card-label">Tổng Sản Phẩm</div>
        </div>
      </div>

      <!-- GRID BIỂU ĐỒ (ROW 1) -->
      <div class="charts-grid">
        <!-- Biểu đồ đường Doanh thu -->
        <div class="chart-card">
          <div class="chart-header">
            <div class="chart-title"><i class="fa-solid fa-arrow-trend-up" style="color:var(--primary);"></i> Tăng Trưởng Doanh Thu (2026)</div>
            <span class="badge badge-neutral">Theo Tháng</span>
          </div>
          <div class="chart-container">
            <canvas id="revenueChart"></canvas>
          </div>
        </div>

        <!-- Biểu đồ tròn Danh mục -->
        <div class="chart-card">
          <div class="chart-header">
            <div class="chart-title"><i class="fa-solid fa-chart-pie" style="color:var(--accent);"></i> Tỷ Lệ Theo Danh Mục</div>
          </div>
          <div class="chart-container">
            <canvas id="categoryChart"></canvas>
          </div>
        </div>
      </div>

      <!-- GRID BIỂU ĐỒ (ROW 2: TOP BÁN CHẠY & BẢNG ĐƠN HÀNG) -->
      <div class="charts-grid">
        <!-- Biểu đồ cột Top sản phẩm -->
        <div class="chart-card">
          <div class="chart-header">
            <div class="chart-title"><i class="fa-solid fa-fire" style="color:var(--danger);"></i> Top 5 Sản Phẩm Bán Chạy</div>
          </div>
          <div class="chart-container">
            <canvas id="topProductsChart"></canvas>
          </div>
        </div>

        <!-- Tóm tắt đơn hàng gần đây -->
        <div class="chart-card">
          <div class="chart-header">
            <div class="chart-title"><i class="fa-solid fa-clock-rotate-left" style="color:var(--success);"></i> Đơn Hàng Vừa Xuất</div>
          </div>
          <div style="font-size: 13px;">
            <div style="display:flex; justify-content:space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
              <span>#DH12 - Lê Thị Hằng</span>
              <strong style="color:var(--success);">7,700,000 đ</strong>
            </div>
            <div style="display:flex; justify-content:space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
              <span>#DH11 - Võ Minh Tuấn</span>
              <strong style="color:var(--success);">850,000 đ</strong>
            </div>
            <div style="display:flex; justify-content:space-between; padding: 10px 0; border-bottom: 1px solid var(--border);">
              <span>#DH10 - Nguyễn Thị Bình</span>
              <strong style="color:var(--success);">4,550,000 đ</strong>
            </div>
            <div style="display:flex; justify-content:space-between; padding: 10px 0;">
              <span>#DH09 - Bùi Quốc Huy</span>
              <strong style="color:var(--warning);">1,500,000 đ</strong>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<!-- JAVASCRIPT VẼ BIỂU ĐỒ -->
<script>
  // Cấu hình màu sắc đồng bộ với Dark Theme
  const textColor = '#8a99ad';
  const gridColor = 'rgba(255, 255, 255, 0.05)';

  // 1. BIỂU ĐỒ DOANH THU THỜI GIAN (LINE CHART)
  const ctxRevenue = document.getElementById('revenueChart').getContext('2d');
  new Chart(ctxRevenue, {
    type: 'line',
    data: {
      labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7'],
      datasets: [{
        label: 'Doanh Thu (VNĐ)',
        data: [4200000, 6800000, 5100000, 8900000, 11200000, 15400000, 30350000],
        borderColor: '#ff6b35',
        backgroundColor: 'rgba(255, 107, 53, 0.15)',
        fill: true,
        tension: 0.4,
        borderWidth: 3,
        pointBackgroundColor: '#ff6b35'
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: {
        x: { ticks: { color: textColor }, grid: { color: gridColor } },
        y: { ticks: { color: textColor }, grid: { color: gridColor } }
      }
    }
  });

  // 2. BIỂU ĐỒ TỶ LỆ DANH MỤC (DOUGHNUT CHART)
  const ctxCategory = document.getElementById('categoryChart').getContext('2d');
  new Chart(ctxCategory, {
    type: 'doughnut',
    data: {
      labels: ['Giày Thể Thao', 'Quần Áo', 'Dụng Cụ', 'Phụ Kiện'],
      datasets: [{
        data: [45, 25, 20, 10],
        backgroundColor: ['#ff6b35', '#00d67f', '#ffb830', '#00b8d9'],
        borderWidth: 0
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { position: 'bottom', labels: { color: textColor, font: { size: 12 } } }
      }
    }
  });

  // 3. BIỂU ĐỒ TOP SẢN PHẨM BÁN CHẠY (BAR CHART)
  const ctxTopProducts = document.getElementById('topProductsChart').getContext('2d');
  new Chart(ctxTopProducts, {
    type: 'bar',
    data: {
      labels: ['Giày Runner Pro', 'Áo Dù Sport', 'Vợt Badminton', 'Bóng Đá Size 5', 'Quần Tập Gym'],
      datasets: [{
        label: 'Số lượng đã bán',
        data: [38, 29, 24, 18, 15],
        backgroundColor: '#00d67f',
        borderRadius: 6
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: {
        x: { ticks: { color: textColor }, grid: { display: false } },
        y: { ticks: { color: textColor }, grid: { color: gridColor } }
      }
    }
  });
</script>
</body>
</html>