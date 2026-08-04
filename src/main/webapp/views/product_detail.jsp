<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="${product.tenSanPham} - Mua ngay tại SportShop với giá tốt nhất, hàng chính hãng có bảo hành.">
  <title>${product.tenSanPham} | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    /* BREADCRUMB */
    .breadcrumb {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: var(--text-faint);
      margin-bottom: var(--space-xl);
    }
    .breadcrumb a { color: var(--text-faint); transition: var(--transition-fast); }
    .breadcrumb a:hover { color: var(--primary); }
    .breadcrumb i { font-size: 10px; }

    /* PRODUCT HERO */
    .product-hero {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: var(--space-2xl);
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-xl);
      overflow: hidden;
      margin-bottom: var(--space-2xl);
    }

    .product-image-area {
      position: relative;
      min-height: 420px;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, var(--bg-base) 0%, var(--bg-surface) 100%);
      overflow: hidden;
    }

    .product-image-area::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(circle at center, rgba(255,107,53,0.08) 0%, transparent 70%);
    }

    .product-main-img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      position: absolute;
      inset: 0;
    }

    .product-img-icon {
      position: relative;
      z-index: 1;
      font-size: 96px;
      color: rgba(255,107,53,0.2);
    }

    .product-badge-new {
      position: absolute;
      top: var(--space-lg);
      left: var(--space-lg);
      background: var(--primary);
      color: #fff;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 1px;
      padding: 5px 12px;
      border-radius: var(--radius-full);
      text-transform: uppercase;
    }

    .product-info-area {
      padding: var(--space-2xl);
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .product-category-tag {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--primary);
      margin-bottom: var(--space-sm);
    }

    .product-title {
      font-family: var(--font-display);
      font-size: 34px;
      letter-spacing: 1px;
      line-height: 1.15;
      color: var(--text-primary);
      margin-bottom: var(--space-md);
    }

    .product-rating-row {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
      margin-bottom: var(--space-lg);
    }

    .stars { color: var(--accent); font-size: 16px; letter-spacing: 2px; }
    .review-count { font-size: 13px; color: var(--text-faint); }

    .product-price-row {
      display: flex;
      align-items: baseline;
      gap: var(--space-sm);
      margin-bottom: var(--space-lg);
    }

    .product-main-price {
      font-family: var(--font-display);
      font-size: 40px;
      letter-spacing: 1px;
      color: var(--primary);
      line-height: 1;
    }

    .product-price-unit { font-size: 16px; color: var(--text-muted); }

    .product-stock-row {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
      margin-bottom: var(--space-xl);
      font-size: 14px;
      color: var(--text-muted);
    }

    .product-stock-row i { font-size: 13px; }

    /* Qty selector */
    .qty-selector {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
      margin-bottom: var(--space-xl);
    }

    .qty-label { font-size: 13px; font-weight: 600; color: var(--text-muted); margin-right: var(--space-sm); }

    .qty-btn-lg {
      width: 40px;
      height: 40px;
      border-radius: var(--radius-md);
      background: rgba(255,255,255,0.06);
      border: 1px solid var(--border-light);
      color: var(--text-primary);
      font-size: 20px;
      font-weight: 700;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: var(--transition-fast);
      user-select: none;
    }

    .qty-btn-lg:hover { background: rgba(255,107,53,0.1); border-color: rgba(255,107,53,0.3); color: var(--primary); }

    .qty-display {
      width: 56px;
      height: 40px;
      text-align: center;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      font-size: 16px;
      font-weight: 700;
    }

    .product-cta-buttons {
      display: flex;
      gap: var(--space-md);
    }

    .product-guarantees {
      margin-top: var(--space-xl);
      display: flex;
      gap: var(--space-lg);
      flex-wrap: wrap;
    }

    .guarantee-item {
      display: flex;
      align-items: center;
      gap: 6px;
      font-size: 12px;
      color: var(--text-faint);
    }

    .guarantee-item i { color: var(--success); font-size: 12px; }

    /* REVIEWS SECTION */
    .reviews-section {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-xl);
      padding: var(--space-2xl);
    }

    .reviews-section-title {
      font-family: var(--font-display);
      font-size: 26px;
      letter-spacing: 1px;
      color: var(--text-primary);
      margin-bottom: var(--space-xl);
      padding-bottom: var(--space-md);
      border-bottom: 1px solid var(--border);
    }

    .review-form-box {
      background: rgba(255,255,255,0.03);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: var(--space-xl);
      margin-bottom: var(--space-xl);
    }

    .review-form-box h4 { font-size: 15px; font-weight: 700; color: var(--text-secondary); margin-bottom: var(--space-md); }

    .star-select {
      width: 100%;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      padding: 12px 16px;
      font-size: 14px;
      font-family: var(--font-body);
      outline: none;
    }

    .star-select:focus { border-color: var(--primary); }
    .star-select option { background: var(--bg-navy); }

    .review-textarea {
      width: 100%;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      padding: 12px 16px;
      font-size: 14px;
      font-family: var(--font-body);
      outline: none;
      resize: vertical;
      min-height: 100px;
    }

    .review-textarea:focus { border-color: var(--primary); }
    .review-textarea::placeholder { color: var(--text-faint); }

    .review-list { display: flex; flex-direction: column; gap: var(--space-lg); }

    .review-item {
      padding-bottom: var(--space-lg);
      border-bottom: 1px solid var(--border);
    }

    .review-item:last-child { border-bottom: none; padding-bottom: 0; }

    .reviewer-header {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
      margin-bottom: var(--space-sm);
    }

    .reviewer-avatar {
      width: 36px;
      height: 36px;
      border-radius: var(--radius-full);
      background: linear-gradient(135deg, var(--primary), var(--accent));
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 14px;
      font-weight: 700;
      color: #fff;
      flex-shrink: 0;
    }

    .reviewer-name { font-weight: 700; font-size: 14px; color: var(--text-secondary); }
    .reviewer-date { font-size: 12px; color: var(--text-faint); margin-left: auto; }
    .review-stars-display { color: var(--accent); font-size: 14px; letter-spacing: 2px; margin-bottom: 6px; }
    .review-text { font-size: 14px; color: var(--text-muted); line-height: 1.6; }

    .login-prompt-box {
      padding: var(--space-xl);
      text-align: center;
      background: rgba(255,255,255,0.03);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      margin-bottom: var(--space-xl);
    }

    .login-prompt-box p { font-size: 14px; color: var(--text-faint); margin-bottom: var(--space-md); }

    @media (max-width: 900px) {
      .product-hero { grid-template-columns: 1fr; }
      .product-image-area { min-height: 300px; }
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
      <a href="${pageContext.request.contextPath}/home" class="active">Sản Phẩm</a>
      <a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a>
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
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
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
    <div class="container" style="padding-top:var(--space-xl); padding-bottom:var(--space-3xl);">

      <!-- Breadcrumb -->
      <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Trang Chủ</a>
        <i class="fa-solid fa-chevron-right"></i>
        <a href="${pageContext.request.contextPath}/home">Sản Phẩm</a>
        <i class="fa-solid fa-chevron-right"></i>
        <span style="color:var(--text-secondary);">${product.tenSanPham}</span>
      </div>

      <!-- Messages -->
      <c:if test="${not empty sessionScope.msgReview}">
        <div class="alert alert-success" style="margin-bottom:var(--space-lg);">
          <i class="fa-solid fa-circle-check"></i> ${sessionScope.msgReview}
        </div>
        <c:remove var="msgReview" scope="session"/>
      </c:if>
      <c:if test="${not empty sessionScope.errorReview}">
        <div class="alert alert-error" style="margin-bottom:var(--space-lg);">
          <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.errorReview}
        </div>
        <c:remove var="errorReview" scope="session"/>
      </c:if>

      <!-- Product Hero Card -->
      <div class="product-hero">
        <!-- Image -->
        <div class="product-image-area">
          <span class="product-badge-new">Mới</span>
          <c:choose>
            <c:when test="${product.id == 'SP01' or product.id == 'SP07'}">
              <img src="${pageContext.request.contextPath}/images/product-shoes.png"
                   alt="${product.tenSanPham}" class="product-main-img"
                   onerror="this.style.display='none'">
            </c:when>
            <c:when test="${product.id == 'SP02' or product.id == 'SP05' or product.id == 'SP08'}">
              <img src="${pageContext.request.contextPath}/images/product-apparel.png"
                   alt="${product.tenSanPham}" class="product-main-img"
                   onerror="this.style.display='none'">
            </c:when>
            <c:when test="${product.id == 'SP03' or product.id == 'SP04'}">
              <img src="${pageContext.request.contextPath}/images/product-equipment.png"
                   alt="${product.tenSanPham}" class="product-main-img"
                   onerror="this.style.display='none'">
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/images/product-accessories.png"
                   alt="${product.tenSanPham}" class="product-main-img"
                   onerror="this.style.display='none'">
            </c:otherwise>
          </c:choose>
          <i class="fa-solid fa-box-open product-img-icon"></i>
        </div>

        <!-- Info -->
        <div class="product-info-area">
          <div class="product-category-tag">Sản Phẩm Thể Thao</div>
          <h1 class="product-title">${product.tenSanPham}</h1>

          <div class="product-rating-row">
            <span class="stars">
              <c:forEach begin="1" end="5" var="i">${i <= avgRating ? '&#9733;' : '&#9734;'}</c:forEach>
            </span>
            <span class="review-count">(${reviews.size()} đánh giá)</span>
          </div>

          <div class="product-price-row">
            <div class="product-main-price">
              <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true"/>
            </div>
            <span class="product-price-unit">đ</span>
          </div>

          <div class="product-stock-row">
            <c:choose>
              <c:when test="${product.soLuongTon <= 20}">
                <i class="fa-solid fa-triangle-exclamation" style="color:var(--warning);"></i>
                <span style="color:var(--warning);">Sắp hết hàng — Còn ${product.soLuongTon} sản phẩm</span>
              </c:when>
              <c:otherwise>
                <i class="fa-solid fa-circle-check" style="color:var(--success);"></i>
                <span style="color:var(--success);">Còn hàng — ${product.soLuongTon} sản phẩm trong kho</span>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Qty selector -->
          <div class="qty-selector">
            <span class="qty-label">Số lượng:</span>
            <button type="button" class="qty-btn-lg" onclick="changeQty(-1)">
              <i class="fa-solid fa-minus" style="font-size:12px;"></i>
            </button>
            <input type="number" id="qtyInput" class="qty-display" value="1" min="1" max="${product.soLuongTon}" readonly>
            <button type="button" class="qty-btn-lg" onclick="changeQty(1)">
              <i class="fa-solid fa-plus" style="font-size:12px;"></i>
            </button>
          </div>

          <!-- CTA Buttons -->
          <div class="product-cta-buttons">
            <a href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}"
               onclick="addToCart(event, '${product.id}', '${pageContext.request.contextPath}')"
               class="btn btn-primary btn-lg btn-shimmer" style="flex:1;">
              <i class="fa-solid fa-cart-plus"></i> Thêm Vào Giỏ Hàng
            </a>
            <a href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}"
               class="btn btn-ghost btn-lg" style="flex:1;">
              <i class="fa-solid fa-bolt"></i> Mua Ngay
            </a>
          </div>

          <div class="product-guarantees">
            <div class="guarantee-item">
              <i class="fa-solid fa-circle-check"></i> Hàng chính hãng 100%
            </div>
            <div class="guarantee-item">
              <i class="fa-solid fa-rotate-left"></i> Đổi trả trong 30 ngày
            </div>
            <div class="guarantee-item">
              <i class="fa-solid fa-truck-fast"></i> Giao hàng nhanh toàn quốc
            </div>
          </div>
        </div>
      </div>

      <!-- Reviews Section -->
      <div class="reviews-section">
        <div class="reviews-section-title">
          <i class="fa-solid fa-star" style="color:var(--accent); font-size:22px; vertical-align:middle; margin-right:8px;"></i>
          Đánh Giá & Nhận Xét
        </div>

        <!-- Review Form -->
        <c:choose>
          <c:when test="${not empty sessionScope.currentUser and sessionScope.currentUser.role == 'CUSTOMER'}">
            <div class="review-form-box">
              <h4>Chia sẻ đánh giá của bạn</h4>
              <form action="${pageContext.request.contextPath}/product/review" method="POST">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="form-group" style="margin-bottom:var(--space-md);">
                  <label class="form-label">Số Sao Đánh Giá</label>
                  <select name="soSao" class="star-select" required>
                    <option value="5">5 Sao - Tuyệt vời</option>
                    <option value="4">4 Sao - Tốt</option>
                    <option value="3">3 Sao - Bình thường</option>
                    <option value="2">2 Sao - Kém</option>
                    <option value="1">1 Sao - Rất tệ</option>
                  </select>
                </div>
                <div class="form-group" style="margin-bottom:var(--space-md);">
                  <label class="form-label">Nhận Xét Chi Tiết</label>
                  <textarea name="noiDung" class="review-textarea" required
                            placeholder="Chia sẻ cảm nhận của bạn về sản phẩm này..."></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-md">
                  <i class="fa-solid fa-paper-plane"></i> Gửi Đánh Giá
                </button>
              </form>
            </div>
          </c:when>
          <c:otherwise>
            <div class="login-prompt-box">
              <p>Vui lòng đăng nhập với tư cách khách hàng để gửi đánh giá.</p>
              <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-md">
                <i class="fa-solid fa-right-to-bracket"></i> Đăng Nhập Ngay
              </a>
            </div>
          </c:otherwise>
        </c:choose>

        <!-- Review List -->
        <div class="review-list">
          <c:forEach var="r" items="${reviews}">
            <div class="review-item">
              <div class="reviewer-header">
                <div class="reviewer-avatar">${r.customerName.substring(0,1)}</div>
                <div>
                  <div class="reviewer-name">${r.customerName}</div>
                  <div class="review-stars-display">
                    <c:forEach begin="1" end="5" var="i">${i <= r.soSao ? '&#9733;' : '&#9734;'}</c:forEach>
                  </div>
                </div>
                <div class="reviewer-date">
                  <fmt:formatDate value="${r.ngayDanhGia}" pattern="dd/MM/yyyy HH:mm"/>
                </div>
              </div>
              <div class="review-text">${r.noiDung}</div>
            </div>
          </c:forEach>
          <c:if test="${empty reviews}">
            <div style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
              <i class="fa-regular fa-comment-dots" style="font-size:36px; display:block; margin-bottom:var(--space-md);"></i>
              Chưa có đánh giá nào. Hãy là người đầu tiên nhận xét!
            </div>
          </c:if>
        </div>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer-grid">
      <div class="footer-brand">
        <div class="footer-logo">SportShop</div>
        <p>Cửa hàng thể thao trực tuyến hàng đầu. Cung cấp sản phẩm chính hãng chất lượng cao.</p>
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
          <li><a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a></li>
          <li><a href="${pageContext.request.contextPath}/profile">Tài Khoản</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Hỗ Trợ</h4>
        <ul>
          <li><a href="#">Đổi Trả Hàng</a></li>
          <li><a href="#">Bảo Hành</a></li>
          <li><a href="#">Câu Hỏi Thường Gặp</a></li>
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

<script>
  function changeQty(delta) {
    const input = document.getElementById('qtyInput');
    const max = parseInt(input.max) || 99;
    let val = parseInt(input.value) + delta;
    if (val < 1) val = 1;
    if (val > max) val = max;
    input.value = val;
  }

  async function addToCart(event, productId, contextPath) {
    event.preventDefault();
    try {
      // Note: This currently adds 1 item regardless of qtyInput because CartServlet add action doesn't support quantity parameter
      const response = await fetch(contextPath + '/cart?action=add&id=' + productId, {
        method: 'GET',
        headers: { 'X-Requested-With': 'XMLHttpRequest' }
      });
      if (response.ok) {
        const data = await response.json();
        if (data.success) {
          // Update cart badge if it exists
          let badge = document.querySelector('.nav-cart-badge');
          if (badge) {
            badge.innerText = data.cartSize;
          } else {
            const cartLink = document.querySelector('.nav-cart');
            if (cartLink) {
              cartLink.innerHTML += ' <span class="nav-cart-badge">' + data.cartSize + '</span>';
            }
          }
          alert('Đã thêm sản phẩm vào giỏ hàng!');
        }
      }
    } catch (error) {
      console.error('Error adding to cart:', error);
    }
  }
</script>
</body>
</html>
