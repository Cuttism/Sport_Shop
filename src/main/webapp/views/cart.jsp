<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Giỏ hàng của bạn tại SportShop. Xem và quản lý sản phẩm trước khi thanh toán.">
  <title>SportShop - Giỏ Hàng</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    .cart-layout {
      display: grid;
      grid-template-columns: 1fr 360px;
      gap: var(--space-xl);
      align-items: start;
    }

    /* Cart item rows */
    .cart-items-list {
      display: flex;
      flex-direction: column;
      gap: var(--space-md);
    }

    .cart-item-card {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: var(--space-lg);
      display: flex;
      align-items: center;
      gap: var(--space-lg);
      transition: var(--transition);
    }

    .cart-item-card:hover {
      border-color: var(--border-light);
    }

    .cart-item-img {
      width: 80px;
      height: 80px;
      border-radius: var(--radius-md);
      object-fit: cover;
      flex-shrink: 0;
      overflow: hidden;
    }

    .cart-item-img-placeholder {
      width: 80px;
      height: 80px;
      border-radius: var(--radius-md);
      background: linear-gradient(135deg, var(--bg-surface), var(--bg-raised));
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      border: 1px solid var(--border);
    }

    .cart-item-img-placeholder i {
      font-size: 28px;
      color: rgba(255,107,53,0.35);
    }

    .cart-item-info {
      flex: 1;
    }

    .cart-item-name {
      font-size: 15px;
      font-weight: 600;
      color: var(--text-secondary);
      margin-bottom: 4px;
    }

    .cart-item-price {
      font-size: 13px;
      color: var(--text-faint);
    }

    .cart-item-qty {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
    }

    .qty-btn {
      width: 32px;
      height: 32px;
      border-radius: var(--radius-sm);
      background: rgba(255,255,255,0.06);
      border: 1px solid var(--border-light);
      color: var(--text-secondary);
      font-size: 16px;
      font-weight: 700;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: var(--transition-fast);
    }

    .qty-btn:hover {
      background: rgba(255,107,53,0.1);
      border-color: rgba(255,107,53,0.3);
      color: var(--primary);
    }

    .qty-input {
      width: 52px;
      height: 32px;
      text-align: center;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-sm);
      color: var(--text-primary);
      font-size: 14px;
      font-weight: 700;
      outline: none;
    }

    .qty-update-btn {
      font-size: 11px;
      padding: 6px 10px;
    }

    .cart-item-subtotal {
      font-family: var(--font-display);
      font-size: 20px;
      letter-spacing: 0.5px;
      color: var(--primary);
      min-width: 120px;
      text-align: right;
    }

    .cart-item-remove {
      color: var(--text-faint);
      font-size: 16px;
      padding: 8px;
      border-radius: var(--radius-sm);
      transition: var(--transition-fast);
      cursor: pointer;
      border: none;
      background: none;
    }

    .cart-item-remove:hover {
      color: var(--danger);
      background: rgba(255,71,87,0.1);
    }

    /* Summary Card */
    .cart-summary-card {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: var(--space-lg);
      position: sticky;
      top: calc(var(--navbar-height) + var(--space-lg));
    }

    .cart-summary-title {
      font-family: var(--font-display);
      font-size: 20px;
      letter-spacing: 1px;
      color: var(--text-primary);
      margin-bottom: var(--space-lg);
      padding-bottom: var(--space-md);
      border-bottom: 1px solid var(--border);
    }

    .summary-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 8px 0;
      font-size: 14px;
      color: var(--text-muted);
    }

    .summary-row.total {
      padding-top: var(--space-md);
      margin-top: var(--space-sm);
      border-top: 1px dashed var(--border-light);
      font-size: 16px;
      font-weight: 700;
      color: var(--text-secondary);
    }

    .summary-total-amount {
      font-family: var(--font-display);
      font-size: 26px;
      letter-spacing: 0.5px;
      color: var(--primary);
    }

    /* Empty state */
    .cart-empty {
      text-align: center;
      padding: 80px 20px;
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      grid-column: 1 / -1;
    }

    .cart-empty i {
      font-size: 56px;
      color: var(--text-faint);
      margin-bottom: var(--space-lg);
      display: block;
    }

    .cart-empty h3 {
      font-family: var(--font-display);
      font-size: 28px;
      letter-spacing: 1px;
      color: var(--text-secondary);
      margin-bottom: var(--space-sm);
    }

    .cart-empty p {
      font-size: 14px;
      color: var(--text-faint);
      margin-bottom: var(--space-xl);
    }

    @media (max-width: 900px) {
      .cart-layout { grid-template-columns: 1fr; }
      .cart-summary-card { position: static; }
    }
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
      <a href="${pageContext.request.contextPath}/home">Sản Phẩm</a>
      <a href="${pageContext.request.contextPath}/cart" class="active">Giỏ Hàng</a>
      <c:if test="${not empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/profile">Tài Khoản</a>
        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
          <a href="${pageContext.request.contextPath}/admin/analytics" style="color:var(--accent);">Quản Trị</a>
        </c:if>
        <c:if test="${sessionScope.currentUser.role == 'STAFF'}">
          <a href="${pageContext.request.contextPath}/staff/orders" style="color:var(--success);">Đơn Hàng</a>
        </c:if>
      </c:if>
    </div>
    <form action="${pageContext.request.contextPath}/search" method="GET" class="nav-search">
      <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>
    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart active" style="color:var(--primary);">
        <i class="fa-solid fa-bag-shopping"></i> Giỏ hàng
        <c:if test="${not empty sessionScope.cart}">
          <span class="nav-cart-badge">${sessionScope.cart.size()}</span>
        </c:if>
      </a>
      <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
          <a href="${pageContext.request.contextPath}/logout" class="nav-logout">
            <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="btn-login">Đăng Nhập</a>
        </c:otherwise>
      </c:choose>
    </div>
  </nav>

  <div class="page-main">
    <div class="container" style="padding-top:var(--space-2xl); padding-bottom:var(--space-3xl);">

      <!-- Steps bar -->
      <div class="steps-bar" style="margin-bottom:var(--space-2xl);">
        <div class="step-item active">
          <div class="step-num">1</div> Giỏ Hàng
        </div>
        <div class="step-item">
          <div class="step-num">2</div> Thanh Toán
        </div>
        <div class="step-item">
          <div class="step-num">3</div> Hoàn Thành
        </div>
      </div>

      <!-- Page title -->
      <div class="section-header" style="margin-bottom:var(--space-xl);">
        <div class="section-header-left">
          <div class="section-eyebrow">Mua Sắm</div>
          <div class="section-title">Giỏ <span>Hàng</span> Của Bạn</div>
        </div>
        <c:if test="${not empty sessionScope.cart}">
          <span class="badge badge-neutral">${sessionScope.cart.size()} sản phẩm</span>
        </c:if>
      </div>

      <c:choose>
        <c:when test="${empty sessionScope.cart or sessionScope.cart.size() == 0}">
          <div class="cart-empty">
            <i class="fa-solid fa-bag-shopping"></i>
            <h3>Giỏ Hàng Trống</h3>
            <p>Bạn chưa có sản phẩm nào trong giỏ hàng.</p>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg btn-shimmer">
              <i class="fa-solid fa-arrow-left"></i> Tiếp Tục Mua Sắm
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="cart-layout">
            <!-- LEFT: Items -->
            <div class="cart-items-list">
              <c:forEach var="item" items="${sessionScope.cart}">
                <div class="cart-item-card">
                  <!-- Image placeholder -->
                  <div class="cart-item-img-placeholder">
                    <i class="fa-solid fa-box-open"></i>
                  </div>
                  <div class="cart-item-info">
                    <div class="cart-item-name">${item.product.tenSanPham}</div>
                    <div class="cart-item-price">
                      <fmt:formatNumber value="${item.product.gia}" type="number" groupingUsed="true"/> đ / sản phẩm
                    </div>
                  </div>
                  <!-- Quantity form -->
                  <form action="${pageContext.request.contextPath}/cart" method="POST" class="cart-item-qty">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${item.product.id}">
                    <input type="number" name="quantity" class="qty-input"
                           value="${item.quantity}" min="1" id="qty-${item.product.id}">
                    <button type="submit" class="btn btn-secondary btn-sm qty-update-btn">Cập Nhật</button>
                  </form>
                  <!-- Subtotal -->
                  <div class="cart-item-subtotal">
                    <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true"/> đ
                  </div>
                  <!-- Remove -->
                  <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.product.id}"
                     class="cart-item-remove" title="Xóa">
                    <i class="fa-solid fa-trash-can"></i>
                  </a>
                </div>
              </c:forEach>

              <div style="display:flex; justify-content:flex-start; margin-top:var(--space-sm);">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-secondary btn-md">
                  <i class="fa-solid fa-arrow-left"></i> Tiếp Tục Mua Sắm
                </a>
              </div>
            </div>

            <!-- RIGHT: Summary -->
            <div class="cart-summary-card">
              <div class="cart-summary-title">Tóm Tắt Đơn Hàng</div>
              <div class="summary-row">
                <span>Tạm tính</span>
                <span><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> đ</span>
              </div>
              <div class="summary-row">
                <span>Phí vận chuyển</span>
                <span style="color:var(--success);">Miễn phí</span>
              </div>
              <div class="summary-row total">
                <span>Tổng Cộng</span>
                <div class="summary-total-amount">
                  <fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> đ
                </div>
              </div>
              <div style="margin-top:var(--space-lg);">
                <a href="${pageContext.request.contextPath}/checkout"
                   class="btn btn-primary btn-full btn-lg btn-shimmer">
                  <i class="fa-solid fa-credit-card"></i> Tiến Hành Thanh Toán
                </a>
              </div>
              <div style="margin-top:var(--space-md); text-align:center;">
                <div style="display:flex; align-items:center; justify-content:center; gap:8px; font-size:12px; color:var(--text-faint);">
                  <i class="fa-solid fa-shield-halved" style="color:var(--success);"></i>
                  Thanh toán an toàn và bảo mật
                </div>
              </div>
            </div>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer-grid">
      <div class="footer-brand">
        <div class="footer-logo">SportShop</div>
        <p>Cửa hàng thể thao trực tuyến hàng đầu. Cung cấp sản phẩm thể thao chính hãng chất lượng cao.</p>
        <div class="footer-social">
          <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#"><i class="fa-brands fa-instagram"></i></a>
          <a href="#"><i class="fa-solid fa-comment-dots"></i></a>
        </div>
      </div>
      <div class="footer-col">
        <h4>Điều Hướng</h4>
        <ul>
          <li><a href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
          <li><a href="${pageContext.request.contextPath}/home">Sản Phẩm</a></li>
          <li><a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a></li>
          <li><a href="${pageContext.request.contextPath}/profile">Tài Khoản</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Hỗ Trợ</h4>
        <ul>
          <li><a href="#">Chính Sách Đổi Trả</a></li>
          <li><a href="#">Hướng Dẫn Mua Hàng</a></li>
          <li><a href="#">Bảo Hành Sản Phẩm</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Liên Hệ</h4>
        <div class="footer-contact-item"><i class="fa-solid fa-phone"></i><span>1800 123 456</span></div>
        <div class="footer-contact-item"><i class="fa-solid fa-envelope"></i><span>hotro@sportshop.vn</span></div>
        <div class="footer-contact-item"><i class="fa-solid fa-location-dot"></i><span>123 Đường Thể Thao, TP. HCM</span></div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2026 <strong style="color:var(--primary)">SportShop</strong>. Bảo lưu mọi quyền.</p>
      <div class="footer-bottom-links">
        <a href="#">Điều Khoản</a>
        <a href="#">Bảo Mật</a>
      </div>
    </div>
  </footer>

</div>
</body>
</html>
