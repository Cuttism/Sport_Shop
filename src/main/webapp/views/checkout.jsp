<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Thanh toán đơn hàng tại SportShop - An toàn và bảo mật.">
        <title>SportShop - Thanh Toán</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
          body {
            background: var(--bg-deep);
          }

          .checkout-grid {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: var(--space-xl);
            align-items: start;
          }

          .checkout-box {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: var(--space-xl);
          }

          .checkout-box-title {
            font-family: var(--font-display);
            font-size: 20px;
            letter-spacing: 1px;
            color: var(--text-primary);
            margin-bottom: var(--space-xl);
            padding-bottom: var(--space-md);
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 10px;
          }

          .checkout-box-title i {
            color: var(--primary);
            font-size: 17px;
          }

          .form-fields-stack {
            display: flex;
            flex-direction: column;
            gap: var(--space-lg);
          }

          /* Payment method cards */
          .payment-options {
            display: flex;
            flex-direction: column;
            gap: var(--space-sm);
          }

          .payment-option {
            display: flex;
            align-items: center;
            gap: var(--space-md);
            padding: 14px 16px;
            border-radius: var(--radius-md);
            border: 2px solid var(--border);
            cursor: pointer;
            transition: var(--transition-fast);
          }

          .payment-option:hover {
            border-color: rgba(255, 107, 53, 0.35);
          }

          .payment-option input[type="radio"] {
            accent-color: var(--primary);
            width: 16px;
            height: 16px;
          }

          .payment-option label {
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-secondary);
            flex: 1;
          }

          .payment-option i {
            font-size: 20px;
            color: var(--text-faint);
          }

          /* Order summary sidebar */
          .order-summary-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: var(--space-xl);
            position: sticky;
            top: calc(var(--navbar-height) + var(--space-lg));
          }

          .order-item-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid var(--border);
            font-size: 13px;
          }

          .order-item-row:last-of-type {
            border-bottom: none;
          }

          .order-item-name {
            color: var(--text-secondary);
            font-weight: 500;
            flex: 1;
          }

          .order-item-qty {
            color: var(--text-faint);
            font-size: 12px;
            margin: 0 var(--space-sm);
          }

          .order-item-price {
            color: var(--primary);
            font-weight: 700;
            white-space: nowrap;
          }

          .order-total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: var(--space-md);
            padding-top: var(--space-md);
            border-top: 2px dashed var(--border-light);
          }

          .order-total-label {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-secondary);
          }

          .order-total-value {
            font-family: var(--font-display);
            font-size: 28px;
            letter-spacing: 0.5px;
            color: var(--primary);
          }

          /* Success / Error states */
          .state-box {
            grid-column: 1 / -1;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: var(--space-3xl);
            text-align: center;
          }

          .state-box-icon {
            font-size: 56px;
            margin-bottom: var(--space-lg);
            display: block;
          }

          .state-box h2 {
            font-family: var(--font-display);
            font-size: 32px;
            letter-spacing: 1.5px;
            margin-bottom: var(--space-sm);
          }

          .state-box p {
            font-size: 15px;
            color: var(--text-muted);
            margin-bottom: var(--space-xl);
          }

          @media (max-width: 900px) {
            .checkout-grid {
              grid-template-columns: 1fr;
            }

            .order-summary-card {
              position: static;
            }
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
              <a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a>
              <c:if test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/profile">Tài Khoản</a>
              </c:if>
            </div>
            <div class="nav-actions">
              <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
                <i class="fa-solid fa-bag-shopping"></i> Giỏ hàng
              </a>
              <c:if test="${not empty sessionScope.currentUser}">
                <a href="${pageContext.request.contextPath}/logout" class="nav-logout">
                  <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
                </a>
              </c:if>
            </div>
          </nav>

          <div class="page-main">
            <div class="container" style="padding-top:var(--space-2xl); padding-bottom:var(--space-3xl);">

              <!-- Steps bar -->
              <div class="steps-bar">
                <div class="step-item done">
                  <div class="step-num"><i class="fa-solid fa-check" style="font-size:10px;"></i></div> Giỏ Hàng
                </div>
                <div class="step-item active">
                  <div class="step-num">2</div> Thanh Toán
                </div>
                <div class="step-item">
                  <div class="step-num">3</div> Hoàn Thành
                </div>
              </div>

              <!-- Page title -->
              <div class="section-header">
                <div class="section-header-left">
                  <div class="section-eyebrow">Bước Cuối</div>
                  <div class="section-title">Xác Nhận <span>Đặt Hàng</span></div>
                </div>
              </div>

              <c:choose>
                <c:when test="${not empty successMessage}">
                  <div class="state-box">
                    <i class="fa-solid fa-circle-check state-box-icon" style="color:var(--success);"></i>
                    <h2 style="color:var(--success);">Đặt Hàng Thành Công!</h2>
                    <p>${successMessage}</p>
                    <div style="display:flex; gap:var(--space-md); justify-content:center;">
                      <a href="${pageContext.request.contextPath}/profile" class="btn btn-secondary btn-lg">
                        <i class="fa-solid fa-list"></i> Xem Đơn Hàng
                      </a>
                      <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg btn-shimmer">
                        <i class="fa-solid fa-house"></i> Về Trang Chủ
                      </a>
                    </div>
                  </div>
                </c:when>

                <c:when test="${not empty errorMessage}">
                  <div class="state-box">
                    <i class="fa-solid fa-circle-exclamation state-box-icon" style="color:var(--danger);"></i>
                    <h2 style="color:var(--danger);">Có Lỗi Xảy Ra</h2>
                    <p>${errorMessage}</p>
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary btn-lg">
                      <i class="fa-solid fa-arrow-left"></i> Quay Lại Giỏ Hàng
                    </a>
                  </div>
                </c:when>

                <c:otherwise>
                  <form action="${pageContext.request.contextPath}/checkout" method="POST" class="checkout-grid">

                    <div class="checkout-box">
                      <div class="checkout-box-title">
                        <i class="fa-solid fa-user-check"></i> Thông Tin Đặt Hàng
                      </div>
                      <div class="form-fields-stack">
                        <div class="form-group">
                          <label class="form-label">Người Nhận Hàng</label>
                          <input type="text" class="form-control" value="${sessionScope.currentUser.hoTen}" disabled
                            style="opacity:0.6; cursor:not-allowed;">
                        </div>

                        <div class="form-group">
                          <label class="form-label">Ghi Chú Đơn Hàng (Tùy chọn)</label>
                          <input type="text" name="ghiChu" class="form-control"
                            placeholder="VD: Giao giờ hành chính, gọi trước khi giao...">
                        </div>

                        <div class="form-group">
                          <label class="form-label" style="margin-bottom:var(--space-md);">Phương Thức Thanh
                            Toán</label>
                          <div class="payment-options">
                            <div class="payment-option">
                              <input type="radio" name="paymentMethod" id="pm-cod" value="Tiền mặt (COD)" checked>
                              <i class="fa-solid fa-money-bill-wave"></i>
                              <label for="pm-cod">Thanh toán khi nhận hàng (COD)</label>
                            </div>
                            <div class="payment-option">
                              <input type="radio" name="paymentMethod" id="pm-card" value="Thẻ Visa/Mastercard">
                              <i class="fa-solid fa-credit-card"></i>
                              <label for="pm-card">Thẻ Visa / Mastercard</label>
                            </div>
                            <div class="payment-option">
                              <input type="radio" name="paymentMethod" id="pm-momo" value="Ví MoMo">
                              <i class="fa-solid fa-wallet"></i>
                              <label for="pm-momo">Ví MoMo</label>
                            </div>
                            <div class="payment-option">
                              <input type="radio" name="paymentMethod" id="pm-transfer" value="Chuyển khoản">
                              <i class="fa-solid fa-building-columns"></i>
                              <label for="pm-transfer">Chuyển khoản ngân hàng</label>
                            </div>
                          </div>
                        </div>

                        <div
                          style="margin-top:var(--space-sm); padding:14px 16px; background:rgba(0,214,127,0.06); border:1px solid rgba(0,214,127,0.2); border-radius:var(--radius-md); display:flex; align-items:center; gap:10px; font-size:13px; color:var(--success);">
                          <i class="fa-solid fa-shield-halved"></i>
                          Thông tin đặt hàng được mã hóa và bảo mật an toàn.
                        </div>
                      </div>
                    </div>

                    <div class="order-summary-card">
                      <div class="checkout-box-title">
                        <i class="fa-solid fa-receipt"></i> Đơn Hàng Của Bạn
                      </div>

                      <div style="margin-bottom:var(--space-md);">
                        <c:forEach var="item" items="${sessionScope.cart}">
                          <div class="order-item-row">
                            <span class="order-item-name">${item.product.tenSanPham}</span>
                            <span class="order-item-qty">x${item.quantity}</span>
                            <span class="order-item-price">
                              <fmt:formatNumber value="${item.subtotal}" type="number" groupingUsed="true" /> đ
                            </span>
                          </div>
                        </c:forEach>
                      </div>

                      <div class="order-total-row">
                        <span class="order-total-label">Tổng Cộng</span>
                        <div class="order-total-value">
                          <fmt:formatNumber value="${total}" type="number" groupingUsed="true" /> đ
                        </div>
                      </div>

                      <button type="submit" class="btn btn-primary btn-full btn-xl btn-shimmer"
                        style="margin-top:var(--space-xl);">
                        <i class="fa-solid fa-check-circle"></i> Xác Nhận Đặt Hàng
                      </button>

                      <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary btn-full btn-md"
                        style="margin-top:var(--space-sm);">
                        <i class="fa-solid fa-arrow-left"></i> Quay Lại Giỏ Hàng
                      </a>
                    </div>

                  </form>
                </c:otherwise>
              </c:choose>
            </div>
          </div>

          <!-- FOOTER -->
          <footer
            style="background:var(--bg-base); border-top:1px solid var(--border); padding:24px 40px; text-align:center;">
            <p style="color:var(--text-faint); font-size:13px;">
              &copy; 2026 <strong style="color:var(--primary)">SportShop</strong> &mdash; Mọi giao dịch được bảo mật và
              mã hóa.
            </p>
          </footer>
        </div>
      </body>

      </html>