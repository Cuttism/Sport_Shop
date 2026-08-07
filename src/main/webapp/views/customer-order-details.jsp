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
<div class="page-wrapper">

  <!-- NAVBAR -->
  <nav class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">
      <div>
        <div class="nav-logo-wordmark">SportShop</div>
        <div class="nav-logo-sub">Cửa hàng thể thao</div>
      </div>
    </a>
    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
      <a href="${pageContext.request.contextPath}/products">Sản Phẩm</a>
      <a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a>
      <a href="${pageContext.request.contextPath}/profile" class="active">Tài Khoản</a>
      <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/analytics" style="color:var(--accent);">Quản Trị</a>
      </c:if>
      <c:if test="${sessionScope.currentUser.role == 'STAFF'}">
        <a href="${pageContext.request.contextPath}/staff/orders" style="color:var(--success);">Đơn Hàng</a>
      </c:if>
    </div>
    <form action="${pageContext.request.contextPath}/search" method="GET" class="nav-search">
      <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>
    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
        <i class="fa-solid fa-bag-shopping"></i> Giỏ hàng
        <c:if test="${not empty sessionScope.cart}">
          <span class="nav-cart-badge">${sessionScope.cart.size()}</span>
        </c:if>
      </a>
      <a href="${pageContext.request.contextPath}/logout" class="nav-logout">
        <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
      </a>
    </div>
  </nav>

  <!-- MAIN CONTENT -->
  <div class="page-main">
    <div class="container" style="padding-top:var(--space-2xl); padding-bottom:var(--space-3xl);">

      <div style="display:flex; align-items:center; gap:var(--space-md); margin-bottom:var(--space-xl);">
        <a href="${pageContext.request.contextPath}/profile"
           class="btn btn-secondary btn-sm">
          <i class="fa-solid fa-arrow-left"></i>
        </a>
        <h1 style="font-family: var(--font-display); font-size: 32px; letter-spacing: 1px; color: var(--text-primary);">Chi Tiết Đơn Hàng</h1>
      </div>

      <!-- Order ID header card -->
      <div class="order-header-card">
        <div class="order-id-block">
          <div class="order-id-icon"><i class="fa-solid fa-receipt"></i></div>
          <div>
            <div class="order-id-text">Đơn #${orderId}</div>
            <div class="order-id-sub">Danh sách sản phẩm bạn đã đặt mua</div>
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
                <td style="color:var(--text-secondary); font-weight:600;">
                  <a href="${pageContext.request.contextPath}/product?id=${item.productId}" style="color:var(--text-primary); text-decoration:none;">${item.tenSanPham}</a>
                </td>
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
        <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary btn-md">
          <i class="fa-solid fa-arrow-left"></i> Quay Lại Hồ Sơ
        </a>
      </div>
    </div>
  </div>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer-grid">
      <div class="footer-brand">
        <div class="footer-logo">SportShop</div>
        <p>Cửa hàng thể thao trực tuyến hàng đầu.</p>
        <div class="footer-social">
          <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#"><i class="fa-brands fa-instagram"></i></a>
        </div>
      </div>
      <div class="footer-col">
        <h4>Điều Hướng</h4>
        <ul>
          <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
          <li><a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Hỗ Trợ</h4>
        <ul>
          <li><a href="#">Đổi Trả Hàng</a></li>
          <li><a href="#">Bảo Hành</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Liên Hệ</h4>
        <div class="footer-contact-item"><i class="fa-solid fa-phone"></i><span>1800 123 456</span></div>
        <div class="footer-contact-item"><i class="fa-solid fa-envelope"></i><span>hotro@sportshop.vn</span></div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2026 <strong style="color:var(--primary)">SportShop</strong>. Bảo lưu mọi quyền.</p>
    </div>
  </footer>
</div>
</body>
</html>
