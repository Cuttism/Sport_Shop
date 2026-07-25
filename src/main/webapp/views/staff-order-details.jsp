<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi Tiết Đơn Hàng #${orderId} | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    .order-header-card {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: var(--space-xl);
      margin-bottom: var(--space-xl);
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: var(--space-lg);
    }

    .order-id-block {
      display: flex;
      align-items: center;
      gap: var(--space-md);
    }

    .order-id-icon {
      width: 52px;
      height: 52px;
      border-radius: var(--radius-lg);
      background: rgba(255,107,53,0.1);
      border: 1px solid rgba(255,107,53,0.25);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 22px;
      color: var(--primary);
    }

    .order-id-text { font-family: var(--font-display); font-size: 28px; letter-spacing: 1px; color: var(--text-primary); }
    .order-id-sub { font-size: 13px; color: var(--text-faint); margin-top: 2px; }

    .summary-totals {
      display: flex;
      gap: var(--space-2xl);
    }

    .total-block { text-align: right; }
    .total-label { font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-faint); margin-bottom: 4px; }
    .total-amount { font-family: var(--font-display); font-size: 28px; letter-spacing: 1px; color: var(--primary); }
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
      <div style="display:flex; align-items:center; gap:var(--space-md);">
        <a href="${pageContext.request.contextPath}/staff/orders"
           class="btn btn-secondary btn-sm">
          <i class="fa-solid fa-arrow-left"></i>
        </a>
        <h1>Chi Tiết Đơn Hàng</h1>
      </div>
      <span class="badge badge-success"><i class="fa-solid fa-shield-halved"></i> NHÂN VIÊN</span>
    </div>

    <div class="admin-content">

      <!-- Order ID header card -->
      <div class="order-header-card">
        <div class="order-id-block">
          <div class="order-id-icon"><i class="fa-solid fa-receipt"></i></div>
          <div>
            <div class="order-id-text">Đơn #${orderId}</div>
            <div class="order-id-sub">Danh sách sản phẩm đã đặt</div>
          </div>
        </div>
        <div class="summary-totals">
          <div class="total-block">
            <div class="total-label">Số Mặt Hàng</div>
            <div class="total-amount" style="font-size:22px; color:var(--text-secondary);">${details.size()}</div>
          </div>
          <div class="total-block">
            <div class="total-label">Tổng Cộng</div>
            <div class="total-amount">
              <c:set var="totalSum" value="0"/>
              <c:forEach var="item" items="${details}">
                <c:set var="totalSum" value="${totalSum + item.thanhTien}"/>
              </c:forEach>
              <fmt:formatNumber value="${totalSum}" type="number" groupingUsed="true"/> đ
            </div>
          </div>
        </div>
      </div>

      <!-- Items table -->
      <div class="data-table-wrap">
        <div style="padding:var(--space-md) var(--space-lg); border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between;">
          <div style="font-size:15px; font-weight:600; color:var(--text-secondary);">
            <i class="fa-solid fa-boxes-stacked" style="color:var(--primary); margin-right:8px;"></i>
            Sản Phẩm Đã Đặt
          </div>
          <span class="badge badge-neutral">${details.size()} mặt hàng</span>
        </div>
        <table class="data-table">
          <thead>
            <tr>
              <th>#</th>
              <th>Tên Sản Phẩm</th>
              <th>Số Lượng</th>
              <th>Đơn Giá</th>
              <th>Thành Tiền</th>
            </tr>
          </thead>
          <tbody>
            <c:set var="idx" value="1"/>
            <c:forEach var="item" items="${details}">
              <tr>
                <td style="color:var(--text-faint); font-weight:600;">${idx}</td>
                <td style="color:var(--text-secondary); font-weight:600;">${item.tenSanPham}</td>
                <td>
                  <span class="badge badge-neutral">${item.soLuong} SP</span>
                </td>
                <td style="color:var(--text-muted);">
                  <fmt:formatNumber value="${item.dongGia}" type="number" groupingUsed="true"/> đ
                </td>
                <td style="color:var(--primary); font-weight:700; font-family:var(--font-display); font-size:16px;">
                  <fmt:formatNumber value="${item.thanhTien}" type="number" groupingUsed="true"/> đ
                </td>
              </tr>
              <c:set var="idx" value="${idx + 1}"/>
            </c:forEach>
            <c:if test="${empty details}">
              <tr>
                <td colspan="5" style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
                  Không có dữ liệu chi tiết cho đơn hàng này.
                </td>
              </tr>
            </c:if>
          </tbody>
          <c:if test="${not empty details}">
            <tfoot>
              <tr style="border-top: 2px dashed var(--border-light);">
                <td colspan="4" style="text-align:right; padding:var(--space-md) var(--space-lg); font-size:16px; font-weight:700; color:var(--text-secondary);">Tổng Cộng</td>
                <td style="padding:var(--space-md) var(--space-lg);">
                  <span style="font-family:var(--font-display); font-size:22px; letter-spacing:0.5px; color:var(--primary);">
                    <fmt:formatNumber value="${totalSum}" type="number" groupingUsed="true"/> đ
                  </span>
                </td>
              </tr>
            </tfoot>
          </c:if>
        </table>
      </div>

      <div style="margin-top:var(--space-xl);">
        <a href="${pageContext.request.contextPath}/staff/orders" class="btn btn-secondary btn-md">
          <i class="fa-solid fa-arrow-left"></i> Quay Lại Danh Sách Đơn Hàng
        </a>
      </div>
    </div>
  </div>
</div>
</body>
</html>
