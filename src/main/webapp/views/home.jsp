<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="SportShop - Cửa hàng thể thao trực tuyến hàng đầu. Mua sắm giày, quần áo và dụng cụ thể thao chính hãng với giá tốt nhất.">
  <title>SportShop - Trang Chủ | Cửa Hàng Thể Thao</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    /* ── PAGE-SPECIFIC STYLES ── */

    /* HERO */
    .hero {
      position: relative;
      min-height: 580px;
      display: flex;
      align-items: center;
      overflow: hidden;
      background: var(--bg-base);
    }

    .hero-bg {
      position: absolute;
      inset: 0;
      background-image: url('${pageContext.request.contextPath}/images/hero-banner.png');
      background-size: cover;
      background-position: center;
      opacity: 0.5;
    }

    .hero-overlay {
      position: absolute;
      inset: 0;
      background: linear-gradient(90deg,
        rgba(10, 17, 25, 0.97) 0%,
        rgba(10, 17, 25, 0.75) 55%,
        rgba(10, 17, 25, 0.2) 100%
      );
    }

    .hero-content {
      position: relative;
      z-index: 2;
      max-width: var(--container-max);
      margin: 0 auto;
      padding: var(--space-4xl) 40px;
      width: 100%;
    }

    .hero-eyebrow {
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 4px;
      text-transform: uppercase;
      color: var(--primary);
      margin-bottom: var(--space-md);
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .hero-eyebrow::before {
      content: '';
      display: inline-block;
      width: 32px;
      height: 2px;
      background: var(--primary);
    }

    .hero-title {
      font-family: var(--font-display);
      font-size: clamp(52px, 7vw, 90px);
      letter-spacing: 3px;
      line-height: 1;
      color: var(--text-primary);
      margin-bottom: var(--space-lg);
    }

    .hero-title .highlight {
      color: var(--primary);
      display: block;
    }

    .hero-subtitle {
      font-size: 17px;
      color: var(--text-muted);
      max-width: 480px;
      line-height: 1.7;
      margin-bottom: var(--space-2xl);
    }

    .hero-actions {
      display: flex;
      gap: var(--space-md);
      flex-wrap: wrap;
      margin-bottom: var(--space-2xl);
    }

    .hero-stats {
      display: flex;
      gap: var(--space-2xl);
    }

    .hero-stat {
      display: flex;
      flex-direction: column;
      gap: 2px;
    }

    .hero-stat-value {
      font-family: var(--font-display);
      font-size: 28px;
      letter-spacing: 1px;
      color: var(--text-primary);
    }

    .hero-stat-label {
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: var(--text-faint);
    }

    .hero-stat-divider {
      width: 1px;
      height: 36px;
      background: var(--border-light);
      align-self: center;
    }

    /* USER WELCOME BAR (logged in) */
    .welcome-bar {
      background: var(--bg-navy);
      border-bottom: 1px solid var(--border);
      padding: 12px 0;
    }

    .welcome-bar .container {
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .welcome-bar-left {
      display: flex;
      align-items: center;
      gap: var(--space-md);
    }

    .welcome-bar-avatar {
      width: 36px;
      height: 36px;
      border-radius: var(--radius-full);
      background: linear-gradient(135deg, var(--primary), var(--accent));
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 14px;
      flex-shrink: 0;
    }

    .welcome-bar-text p {
      font-size: 14px;
      font-weight: 600;
      color: var(--text-secondary);
    }

    .welcome-bar-text span {
      font-size: 12px;
      color: var(--text-faint);
    }

    .welcome-bar-right {
      display: flex;
      align-items: center;
      gap: var(--space-sm);
    }

    /* CATEGORY STRIP */
    .category-strip {
      background: var(--bg-navy);
      border-bottom: 1px solid var(--border);
      padding: 0;
    }

    .category-strip-inner {
      max-width: var(--container-max);
      margin: 0 auto;
      padding: 0 40px;
      display: flex;
      align-items: stretch;
      overflow-x: auto;
      gap: 0;
      scrollbar-width: none;
    }

    .category-strip-inner::-webkit-scrollbar { display: none; }

    .category-pill {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 16px 22px;
      font-size: 13px;
      font-weight: 600;
      color: var(--text-muted);
      cursor: pointer;
      white-space: nowrap;
      border-bottom: 2px solid transparent;
      transition: var(--transition-fast);
    }

    .category-pill i {
      font-size: 14px;
    }

    .category-pill:hover,
    .category-pill.active {
      color: var(--primary);
      border-bottom-color: var(--primary);
      background: rgba(255, 107, 53, 0.05);
    }

    /* PROMO BANNER */
    .promo-banner {
      background: linear-gradient(135deg, var(--bg-navy) 0%, #1a2f45 50%, var(--bg-navy) 100%);
      border-top: 1px solid var(--border);
      border-bottom: 1px solid var(--border);
      padding: var(--space-xl) 0;
      overflow: hidden;
      position: relative;
    }

    .promo-banner::before {
      content: '';
      position: absolute;
      inset: 0;
      background: repeating-linear-gradient(
        45deg,
        transparent,
        transparent 60px,
        rgba(255, 107, 53, 0.02) 60px,
        rgba(255, 107, 53, 0.02) 120px
      );
    }

    .promo-banner-inner {
      max-width: var(--container-max);
      margin: 0 auto;
      padding: 0 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: var(--space-xl);
      position: relative;
    }

    .promo-tag {
      font-family: var(--font-display);
      font-size: 13px;
      letter-spacing: 3px;
      background: var(--primary);
      color: #fff;
      padding: 6px 16px;
      border-radius: var(--radius-sm);
      margin-bottom: var(--space-sm);
      display: inline-block;
    }

    .promo-title {
      font-family: var(--font-display);
      font-size: clamp(28px, 4vw, 48px);
      letter-spacing: 2px;
      color: var(--text-primary);
      line-height: 1;
    }

    .promo-title span { color: var(--primary); }

    .promo-desc {
      font-size: 14px;
      color: var(--text-muted);
      margin-top: var(--space-sm);
    }

    .promo-discount {
      text-align: center;
      flex-shrink: 0;
    }

    .promo-discount-value {
      font-family: var(--font-display);
      font-size: 72px;
      letter-spacing: -2px;
      color: var(--primary);
      line-height: 1;
    }

    .promo-discount-label {
      font-size: 13px;
      font-weight: 600;
      color: var(--text-muted);
      letter-spacing: 1px;
    }

    /* PRODUCT SECTION */
    .products-section {
      background: var(--bg-deep);
      padding: var(--space-3xl) 0;
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: var(--space-lg);
    }

    /* Product placeholder image backgrounds */
    .product-img-shoes      { background: linear-gradient(135deg, #0F1923 0%, #1a2535 100%); }
    .product-img-jersey     { background: linear-gradient(135deg, #0F1923 0%, #1a2030 100%); }
    .product-img-equipment  { background: linear-gradient(135deg, #0F1923 0%, #151e30 100%); }
    .product-img-basketball { background: linear-gradient(135deg, #0F1923 0%, #1e1a28 100%); }
    .product-img-shorts     { background: linear-gradient(135deg, #0F1923 0%, #141e28 100%); }
    .product-img-gloves     { background: linear-gradient(135deg, #0F1923 0%, #1a1a28 100%); }
    .product-img-accessories{ background: linear-gradient(135deg, #0F1923 0%, #141e24 100%); }

    /* FEATURES SECTION */
    .features-section {
      background: var(--bg-navy);
      border-top: 1px solid var(--border);
      border-bottom: 1px solid var(--border);
      padding: var(--space-2xl) 0;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: var(--space-lg);
    }

    .feature-item {
      display: flex;
      align-items: center;
      gap: var(--space-md);
      padding: var(--space-lg);
      border-radius: var(--radius-lg);
      background: rgba(255,255,255,0.03);
      border: 1px solid var(--border);
      transition: var(--transition);
    }

    .feature-item:hover {
      border-color: rgba(255, 107, 53, 0.25);
      background: rgba(255, 107, 53, 0.04);
    }

    .feature-icon {
      width: 48px;
      height: 48px;
      border-radius: var(--radius-md);
      background: rgba(255, 107, 53, 0.1);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      color: var(--primary);
      flex-shrink: 0;
    }

    .feature-text h4 {
      font-size: 14px;
      font-weight: 700;
      color: var(--text-secondary);
      margin-bottom: 3px;
    }

    .feature-text p {
      font-size: 12px;
      color: var(--text-faint);
      line-height: 1.5;
    }

    /* EMPTY STATE */
    .empty-products {
      text-align: center;
      padding: 80px 20px;
      color: var(--text-muted);
    }

    .empty-products i {
      font-size: 48px;
      margin-bottom: var(--space-lg);
      color: var(--text-faint);
      display: block;
    }

    .empty-products h3 {
      font-family: var(--font-display);
      font-size: 28px;
      letter-spacing: 1px;
      color: var(--text-secondary);
      margin-bottom: var(--space-sm);
    }

    .empty-products p {
      font-size: 14px;
      color: var(--text-faint);
    }

    /* SEARCH RESULTS HEADER */
    .search-result-bar {
      background: var(--bg-surface);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: 16px 20px;
      margin-bottom: var(--space-lg);
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .search-result-bar p {
      font-size: 14px;
      color: var(--text-muted);
    }

    .search-result-bar strong {
      color: var(--primary);
    }
  </style>
</head>
<body>
<div class="page-wrapper">

  <!-- ===== NAVBAR ===== -->
  <nav class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">
      <div>
        <div class="nav-logo-wordmark">SportShop</div>
        <div class="nav-logo-sub">Cửa hàng thể thao</div>
      </div>
    </a>

    <div class="nav-links">
      <a href="${pageContext.request.contextPath}/home" class="active">Trang Chủ</a>
      <a href="${pageContext.request.contextPath}/products">Sản Phẩm</a>
      <a href="${pageContext.request.contextPath}/cart">Giỏ Hàng</a>
      <c:if test="${not empty sessionScope.currentUser}">
        <a href="${pageContext.request.contextPath}/profile">Tài Khoản</a>
        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
          <a href="${pageContext.request.contextPath}/admin/analytics" style="color: var(--accent);">Quản Trị</a>
        </c:if>
        <c:if test="${sessionScope.currentUser.role == 'STAFF'}">
          <a href="${pageContext.request.contextPath}/staff/orders" style="color: var(--success);">Đơn Hàng</a>
        </c:if>
      </c:if>
    </div>

    <form action="${pageContext.request.contextPath}/search" method="GET" class="nav-search">
      <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm...">
      <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
    </form>

    <div class="nav-actions">
      <a href="${pageContext.request.contextPath}/cart" class="nav-cart">
        <i class="fa-solid fa-bag-shopping"></i>
        Giỏ hàng
        <c:if test="${not empty sessionScope.cart}">
          <span class="nav-cart-badge">${sessionScope.cart.size()}</span>
        </c:if>
      </a>
      <c:choose>
        <c:when test="${not empty sessionScope.currentUser}">
          <a href="${pageContext.request.contextPath}/login" class="nav-logout">
            <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
          </a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login" class="btn-login">Đăng Nhập</a>
        </c:otherwise>
      </c:choose>
    </div>
  </nav>

  <!-- ===== WELCOME BAR (logged in users) ===== -->
  <c:if test="${not empty sessionScope.currentUser}">
    <div class="welcome-bar">
      <div class="container">
        <div class="welcome-bar-left">
          <div class="welcome-bar-avatar">${sessionScope.currentUser.hoTen.substring(0,1)}</div>
          <div class="welcome-bar-text">
            <p>Xin chào, ${sessionScope.currentUser.hoTen}!</p>
            <span>Mã tài khoản: ${sessionScope.currentUser.id}</span>
          </div>
          <c:choose>
            <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
              <span class="badge badge-warning">QUẢN TRỊ VIÊN</span>
            </c:when>
            <c:when test="${sessionScope.currentUser.role == 'STAFF'}">
              <span class="badge badge-success">NHÂN VIÊN</span>
            </c:when>
            <c:otherwise>
              <span class="badge badge-info">KHÁCH HÀNG</span>
            </c:otherwise>
          </c:choose>
        </div>
        <div class="welcome-bar-right">
          <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/analytics" class="btn btn-sm" style="background:rgba(255,184,48,0.1);color:var(--accent);border:1px solid rgba(255,184,48,0.3);">
              <i class="fa-solid fa-chart-line"></i> Thống Kê
            </a>
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-sm" style="background:rgba(255,184,48,0.1);color:var(--accent);border:1px solid rgba(255,184,48,0.3);">
              <i class="fa-solid fa-box"></i> Quản Lý Sản Phẩm
            </a>
          </c:if>
          <c:if test="${sessionScope.currentUser.role == 'STAFF'}">
            <a href="${pageContext.request.contextPath}/staff/orders" class="btn btn-sm" style="background:rgba(0,214,127,0.1);color:var(--success);border:1px solid rgba(0,214,127,0.3);">
              <i class="fa-solid fa-clipboard-list"></i> Quản Lý Đơn Hàng
            </a>
          </c:if>
        </div>
      </div>
    </div>
  </c:if>

  <div class="page-main">

    <!-- ===== HERO SECTION ===== -->
    <c:if test="${empty sessionScope.currentUser}">
      <section class="hero">
        <div class="hero-bg"></div>
        <div class="hero-overlay"></div>
        <div class="hero-content">
          <div class="hero-eyebrow">Bộ sưu tập mới 2026</div>
          <h1 class="hero-title">
            PHONG CÁCH<br>
            <span class="highlight">THI ĐẤU</span>
            ĐỈNH CAO
          </h1>
          <p class="hero-subtitle">
            Trang bị cho bản thân với những sản phẩm thể thao chính hãng chất lượng cao. Từ giày chạy đến dụng cụ thi đấu — tất cả tại SportShop.
          </p>
          <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg btn-shimmer">
              <i class="fa-solid fa-bolt"></i> Mua Sắm Ngay
            </a>
            <a href="#products" class="btn btn-secondary btn-lg">
              <i class="fa-solid fa-arrow-down"></i> Khám Phá Sản Phẩm
            </a>
          </div>
          <div class="hero-stats">
            <div class="hero-stat">
              <div class="hero-stat-value">10+</div>
              <div class="hero-stat-label">Sản Phẩm</div>
            </div>
            <div class="hero-stat-divider"></div>
            <div class="hero-stat">
              <div class="hero-stat-value">7+</div>
              <div class="hero-stat-label">Khách Hàng</div>
            </div>
            <div class="hero-stat-divider"></div>
            <div class="hero-stat">
              <div class="hero-stat-value">24/7</div>
              <div class="hero-stat-label">Hỗ Trợ</div>
            </div>
          </div>
        </div>
      </section>
    </c:if>

    <!-- ===== CATEGORY STRIP ===== -->
    <div class="category-strip">
      <div class="category-strip-inner">
        <div class="category-pill active" data-category="all" onclick="filterCategory(this, 'all')">
          <i class="fa-solid fa-th-large"></i> Tất Cả Sản Phẩm
        </div>
        <div class="category-pill" data-category="shoes" onclick="filterCategory(this, 'shoes')">
          <i class="fa-solid fa-shoe-prints"></i> Giày Thể Thao
        </div>
        <div class="category-pill" data-category="apparel" onclick="filterCategory(this, 'apparel')">
          <i class="fa-solid fa-shirt"></i> Quần Áo
        </div>
        <div class="category-pill" data-category="equipment" onclick="filterCategory(this, 'equipment')">
          <i class="fa-solid fa-table-tennis-paddle-ball"></i> Dụng Cụ
        </div>
        <div class="category-pill" data-category="gym" onclick="filterCategory(this, 'gym')">
          <i class="fa-solid fa-dumbbell"></i> Gym & Fitness
        </div>
        <div class="category-pill" data-category="accessories" onclick="filterCategory(this, 'accessories')">
          <i class="fa-solid fa-kit-medical"></i> Phụ Kiện
        </div>
      </div>
    </div>

    <!-- ===== PROMO BANNER ===== -->
    <c:if test="${empty keyword}">
      <section class="promo-banner">
        <div class="promo-banner-inner">
          <div>
            <div class="promo-tag">KHUYẾN MÃI ĐẶC BIỆT</div>
            <div class="promo-title">BỘ SƯU TẬP <span>HÈ 2026</span></div>
            <div class="promo-desc">Miễn phí vận chuyển cho đơn hàng trên 500.000đ</div>
          </div>
          <div class="promo-discount">
            <div class="promo-discount-value">-20%</div>
            <div class="promo-discount-label">TOÀN BỘ SẢN PHẨM</div>
          </div>
          <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-lg btn-shimmer">
            <i class="fa-solid fa-tag"></i> Xem Ưu Đãi
          </a>
        </div>
      </section>
    </c:if>

    <!-- ===== PRODUCT SECTION ===== -->
    <section class="products-section" id="products">
      <div class="container">

        <!-- Search result heading -->
        <c:if test="${not empty keyword}">
          <div class="search-result-bar">
            <p>Kết quả tìm kiếm cho: <strong>"${keyword}"</strong></p>
            <c:if test="${not empty products}">
              <span class="badge badge-neutral">${products.size()} sản phẩm</span>
            </c:if>
          </div>
        </c:if>

        <!-- Section heading -->
        <div class="section-header">
          <div class="section-header-left">
            <div class="section-eyebrow">Danh Mục Nổi Bật</div>
            <div class="section-title">
              <c:choose>
                <c:when test="${not empty keyword}">Kết Quả Tìm Kiếm</c:when>
                <c:otherwise>Sản Phẩm <span>Bán Chạy</span></c:otherwise>
              </c:choose>
            </div>
          </div>
          <c:if test="${not empty products}">
            <span class="badge badge-neutral">${products.size()} sản phẩm</span>
          </c:if>
        </div>

        <!-- Product Grid -->
        <c:choose>
          <c:when test="${not empty products}">
            <div class="product-grid" id="productGrid">
              <c:forEach var="product" items="${products}" varStatus="status">
                <%
                  String pid = (String)((entity.SanPham)pageContext.getAttribute("product")).getId();
                  String cat = "accessories";
                  if (pid.equals("SP01") || pid.equals("SP07")) cat = "shoes";
                  else if (pid.equals("SP02") || pid.equals("SP05") || pid.equals("SP08")) cat = "apparel";
                  else if (pid.equals("SP03") || pid.equals("SP04")) cat = "equipment";
                  else if (pid.equals("SP06")) cat = "gym";
                  pageContext.setAttribute("productCat", cat);
                %>
                <div class="product-card" data-category="${productCat}">
                  <!-- Product Image Placeholder (category-based by index) -->
                  <div class="product-card-img-placeholder
                    <c:choose>
                      <c:when test="${product.id == 'SP01' or product.id == 'SP07'}">product-img-shoes</c:when>
                      <c:when test="${product.id == 'SP02' or product.id == 'SP05' or product.id == 'SP08'}">product-img-jersey</c:when>
                      <c:when test="${product.id == 'SP03'}">product-img-equipment</c:when>
                      <c:when test="${product.id == 'SP04'}">product-img-equipment</c:when>
                      <c:otherwise>product-img-accessories</c:otherwise>
                    </c:choose>
                  ">
                    <c:choose>
                      <c:when test="${product.id == 'SP01' or product.id == 'SP07'}">
                        <img src="${pageContext.request.contextPath}/images/product-shoes.png"
                             alt="${product.tenSanPham}"
                             class="product-card-image"
                             onerror="this.style.display='none'">
                      </c:when>
                      <c:when test="${product.id == 'SP02' or product.id == 'SP05' or product.id == 'SP08'}">
                        <img src="${pageContext.request.contextPath}/images/product-apparel.png"
                             alt="${product.tenSanPham}"
                             class="product-card-image"
                             onerror="this.style.display='none'">
                      </c:when>
                      <c:when test="${product.id == 'SP03' or product.id == 'SP04'}">
                        <img src="${pageContext.request.contextPath}/images/product-equipment.png"
                             alt="${product.tenSanPham}"
                             class="product-card-image"
                             onerror="this.style.display='none'">
                      </c:when>
                      <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/product-accessories.png"
                             alt="${product.tenSanPham}"
                             class="product-card-image"
                             onerror="this.style.display='none'">
                      </c:otherwise>
                    </c:choose>
                  </div>

                  <div class="product-card-body">
                    <div class="product-card-name">
                      <a href="${pageContext.request.contextPath}/product?id=${product.id}">${product.tenSanPham}</a>
                    </div>
                    <div class="product-card-meta">
                      <div class="product-price">
                        <fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" /> <small>đ</small>
                      </div>
                      <c:choose>
                        <c:when test="${product.soLuongTon <= 20}">
                          <span class="product-stock-badge stock-low">Còn ${product.soLuongTon}</span>
                        </c:when>
                        <c:otherwise>
                          <span class="product-stock-badge stock-ok">Còn hàng</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>

                  <div class="product-card-actions">
                    <a href="${pageContext.request.contextPath}/product?id=${product.id}"
                       class="btn btn-secondary btn-sm" style="font-size:12px;">
                      <i class="fa-solid fa-eye"></i> Chi Tiết
                    </a>
                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}"
                       class="btn btn-primary btn-sm" style="font-size:12px;">
                      <i class="fa-solid fa-cart-plus"></i> Thêm Vào Giỏ
                    </a>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="empty-products">
              <i class="fa-solid fa-magnifying-glass"></i>
              <h3>Không Tìm Thấy Sản Phẩm</h3>
              <p>Thử tìm kiếm với từ khóa khác hoặc quay lại trang chủ.</p>
              <br>
              <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-md" style="margin-top:8px;">
                Xem Tất Cả Sản Phẩm
              </a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </section>

    <!-- ===== FEATURES SECTION ===== -->
    <section class="features-section">
      <div class="container">
        <div class="features-grid">
          <div class="feature-item">
            <div class="feature-icon"><i class="fa-solid fa-truck-fast"></i></div>
            <div class="feature-text">
              <h4>Giao Hàng Nhanh</h4>
              <p>Vận chuyển toàn quốc trong 24–48 giờ</p>
            </div>
          </div>
          <div class="feature-item">
            <div class="feature-icon"><i class="fa-solid fa-rotate-left"></i></div>
            <div class="feature-text">
              <h4>Đổi Trả Dễ Dàng</h4>
              <p>Hoàn trả trong vòng 30 ngày không điều kiện</p>
            </div>
          </div>
          <div class="feature-item">
            <div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div>
            <div class="feature-text">
              <h4>Hàng Chính Hãng</h4>
              <p>Cam kết 100% sản phẩm chính hãng có bảo hành</p>
            </div>
          </div>
          <div class="feature-item">
            <div class="feature-icon"><i class="fa-solid fa-headset"></i></div>
            <div class="feature-text">
              <h4>Hỗ Trợ 24/7</h4>
              <p>Đội ngũ tư vấn sẵn sàng hỗ trợ mọi lúc</p>
            </div>
          </div>
        </div>
      </div>
    </section>

  </div><!-- end .page-main -->

  <!-- ===== FOOTER ===== -->
  <footer class="footer">
    <div class="footer-grid">
      <div class="footer-brand">
        <div class="footer-logo">SportShop</div>
        <p>Cửa hàng thể thao trực tuyến hàng đầu. Cung cấp dụng cụ, quần áo và phụ kiện thể thao chính hãng chất lượng cao.</p>
        <div class="footer-social">
          <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
          <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
          <a href="#" aria-label="Zalo"><i class="fa-solid fa-comment-dots"></i></a>
          <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
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
          <li><a href="#">Câu Hỏi Thường Gặp</a></li>
        </ul>
      </div>
      <div class="footer-col">
        <h4>Liên Hệ</h4>
        <div class="footer-contact-item">
          <i class="fa-solid fa-phone"></i>
          <span>1800 123 456</span>
        </div>
        <div class="footer-contact-item">
          <i class="fa-solid fa-envelope"></i>
          <span>hotro@sportshop.vn</span>
        </div>
        <div class="footer-contact-item">
          <i class="fa-solid fa-location-dot"></i>
          <span>123 Đường Thể Thao, TP. HCM</span>
        </div>
        <div class="footer-contact-item">
          <i class="fa-solid fa-clock"></i>
          <span>Mở cửa 8:00 – 22:00 hàng ngày</span>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <p>&copy; 2026 <strong style="color:var(--primary)">SportShop</strong>. Bảo lưu mọi quyền.</p>
      <div class="footer-bottom-links">
        <a href="#">Điều Khoản Sử Dụng</a>
        <a href="#">Chính Sách Bảo Mật</a>
        <a href="#">Cookie</a>
      </div>
    </div>
  </footer>

</div><!-- end .page-wrapper -->

<!-- ===== CHATBOT WIDGET ===== -->
<div class="chatbot-widget" id="chatbotWidget">
  <div class="chatbot-header" onclick="toggleChat()">
    <div class="chatbot-header-icon"><i class="fa-solid fa-comments"></i></div>
    <span>Hỗ Trợ Trực Tuyến</span>
    <span class="chatbot-toggle" id="chatToggleIcon"><i class="fa-solid fa-chevron-up"></i></span>
  </div>
  <div class="chatbot-body" id="chatbotBody">
    <div class="chat-messages" id="chatMessages">
      <div class="message bot">Xin chào! Tôi có thể giúp gì cho bạn hôm nay?</div>
    </div>
    <div class="chat-input-area">
      <input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="handleChatKeyPress(event)">
      <button onclick="sendMessage()">Gửi</button>
    </div>
  </div>
</div>

<script>
  /* ===== CATEGORY FILTER ===== */
  function filterCategory(pill, category) {
    // Update active pill
    document.querySelectorAll('.category-pill').forEach(p => p.classList.remove('active'));
    pill.classList.add('active');

    const cards = document.querySelectorAll('#productGrid .product-card');
    let visibleCount = 0;

    cards.forEach((card, i) => {
      const cardCat = card.getAttribute('data-category').trim();
      const match = category === 'all' || cardCat === category;

      if (match) {
        card.style.display = '';
        // Stagger fade-in
        card.style.opacity = '0';
        card.style.transform = 'translateY(12px) scale(0.97)';
        card.style.transition = 'none';
        setTimeout(() => {
          card.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
          card.style.opacity = '1';
          card.style.transform = 'translateY(0) scale(1)';
        }, 30 + visibleCount * 50);
        visibleCount++;
      } else {
        card.style.opacity = '0';
        card.style.transform = 'scale(0.95)';
        card.style.transition = 'opacity 0.2s ease, transform 0.2s ease';
        setTimeout(() => { card.style.display = 'none'; }, 200);
      }
    });

    // Update product count badge
    const badge = document.querySelector('.section-header .badge-neutral');
    if (badge) badge.textContent = visibleCount + ' sản phẩm';

    // Update section title
    const titles = {
      all: 'Sản Phẩm <span>Bán Chạy</span>',
      shoes: 'Giày <span>Thể Thao</span>',
      apparel: 'Quần Áo <span>Thể Thao</span>',
      equipment: 'Dụng Cụ <span>Thi Đấu</span>',
      gym: 'Gym <span>&amp; Fitness</span>',
      accessories: 'Phụ Kiện <span>Thể Thao</span>'
    };
    const titleEl = document.querySelector('.section-title');
    if (titleEl && titles[category]) titleEl.innerHTML = titles[category];

    // Show/hide empty state
    const emptyCheck = document.getElementById('filterEmptyState');
    if (emptyCheck) emptyCheck.style.display = visibleCount === 0 ? 'block' : 'none';
  }

  function toggleChat() {
    const widget = document.getElementById('chatbotWidget');
    const icon = document.getElementById('chatToggleIcon');
    widget.classList.toggle('open');
    icon.innerHTML = widget.classList.contains('open')
      ? '<i class="fa-solid fa-chevron-down"></i>'
      : '<i class="fa-solid fa-chevron-up"></i>';
  }

  function handleChatKeyPress(e) {
    if (e.key === 'Enter') sendMessage();
  }

  async function sendMessage() {
    const input = document.getElementById('chatInput');
    const msg = input.value.trim();
    if (!msg) return;
    appendMessage(msg, 'user');
    input.value = '';
    try {
      const response = await fetch('${pageContext.request.contextPath}/chatbot', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'message=' + encodeURIComponent(msg)
      });
      const data = await response.json();
      appendMessage(data.reply, 'bot');
    } catch (error) {
      appendMessage('Lỗi kết nối. Vui lòng thử lại sau.', 'bot');
    }
  }

  function appendMessage(text, sender) {
    const chatMessages = document.getElementById('chatMessages');
    const msgDiv = document.createElement('div');
    msgDiv.className = 'message ' + sender;
    msgDiv.innerText = text;
    chatMessages.appendChild(msgDiv);
    chatMessages.scrollTop = chatMessages.scrollHeight;
  }
</script>

</body>
</html>