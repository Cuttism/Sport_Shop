<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Quản lý hồ sơ và lịch sử đơn hàng tại SportShop.">
  <title>Hồ Sơ Cá Nhân | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    .profile-layout {
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: var(--space-xl);
      align-items: start;
    }

    /* Left: Profile Card */
    .profile-identity-card {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-xl);
      overflow: hidden;
    }

    .profile-card-banner {
      height: 80px;
      background: linear-gradient(135deg, var(--primary), var(--accent));
      position: relative;
    }

    .profile-card-avatar-wrap {
      padding: 0 var(--space-lg);
      margin-top: -32px;
      margin-bottom: var(--space-md);
    }

    .profile-card-avatar {
      width: 64px;
      height: 64px;
      border-radius: var(--radius-full);
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      display: flex;
      align-items: center;
      justify-content: center;
      font-family: var(--font-display);
      font-size: 28px;
      color: #fff;
      border: 3px solid var(--bg-card);
      box-shadow: var(--shadow-md);
    }

    .profile-card-body { padding: 0 var(--space-lg) var(--space-lg); }
    .profile-card-name { font-size: 18px; font-weight: 700; color: var(--text-primary); margin-bottom: 4px; }
    .profile-card-id { font-size: 13px; color: var(--text-faint); margin-bottom: var(--space-sm); }

    .profile-card-info { margin-top: var(--space-lg); display: flex; flex-direction: column; gap: var(--space-sm); }
    .profile-info-row { display: flex; align-items: flex-start; gap: 10px; font-size: 13px; color: var(--text-muted); }
    .profile-info-row i { color: var(--primary); font-size: 13px; width: 16px; margin-top: 1px; flex-shrink: 0; }

    /* Right: Form & Orders */
    .profile-main { display: flex; flex-direction: column; gap: var(--space-xl); }

    .profile-section {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: var(--space-xl);
    }

    .profile-section-title {
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

    .profile-section-title i { color: var(--primary); font-size: 17px; }

    .profile-form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: var(--space-md); }
    .profile-form-full { grid-column: 1 / -1; }

    .form-control-disabled {
      width: 100%;
      padding: 12px 16px;
      background: rgba(255,255,255,0.03);
      border: 1px solid var(--border);
      border-radius: var(--radius-md);
      color: var(--text-faint);
      font-size: 14px;
      cursor: not-allowed;
    }

    select.form-control {
      background: rgba(255,255,255,0.05);
      cursor: pointer;
    }

    select.form-control option { background: var(--bg-navy); }

    /* Order history table */
    .order-status { padding: 4px 12px; border-radius: var(--radius-full); font-size: 11px; font-weight: 700; }
    .status-paid   { background: rgba(0,214,127,0.12); color: var(--success); border: 1px solid rgba(0,214,127,0.25); }
    .status-cancel { background: rgba(255,71,87,0.12);  color: var(--danger);  border: 1px solid rgba(255,71,87,0.25); }
    .status-other  { background: rgba(255,184,48,0.12); color: var(--warning); border: 1px solid rgba(255,184,48,0.25); }

    @media (max-width: 900px) {
      .profile-layout { grid-template-columns: 1fr; }
      .profile-form-grid { grid-template-columns: 1fr; }
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

  <div class="page-main">
    <div class="container" style="padding-top:var(--space-2xl); padding-bottom:var(--space-3xl);">

      <!-- Page title -->
      <div class="section-header" style="margin-bottom:var(--space-xl);">
        <div class="section-header-left">
          <div class="section-eyebrow">Tài Khoản Của Bạn</div>
          <div class="section-title">Hồ Sơ <span>Cá Nhân</span></div>
        </div>
      </div>

      <!-- Messages -->
      <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-success" style="margin-bottom:var(--space-lg);">
          <i class="fa-solid fa-circle-check"></i> ${sessionScope.msg}
        </div>
        <c:remove var="msg" scope="session"/>
      </c:if>
      <c:if test="${not empty sessionScope.error}">
        <div class="alert alert-error" style="margin-bottom:var(--space-lg);">
          <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.error}
        </div>
        <c:remove var="error" scope="session"/>
      </c:if>

      <div class="profile-layout">

        <!-- LEFT: Identity card -->
        <div class="profile-identity-card">
          <div class="profile-card-banner"></div>
          <div class="profile-card-avatar-wrap">
            <div class="profile-card-avatar">${customerInfo.hoTen.substring(0,1)}</div>
          </div>
          <div class="profile-card-body">
            <div class="profile-card-name">${customerInfo.hoTen}</div>
            <div class="profile-card-id">ID: ${customerInfo.id}</div>
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

            <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
              <div class="profile-card-info">
                <c:if test="${not empty customerInfo.dienThoai}">
                  <div class="profile-info-row">
                    <i class="fa-solid fa-phone"></i>
                    <span>${customerInfo.dienThoai}</span>
                  </div>
                </c:if>
                <c:if test="${not empty customerInfo.email}">
                  <div class="profile-info-row">
                    <i class="fa-solid fa-envelope"></i>
                    <span>${customerInfo.email}</span>
                  </div>
                </c:if>
                <c:if test="${not empty customerInfo.diaChi}">
                  <div class="profile-info-row">
                    <i class="fa-solid fa-location-dot"></i>
                    <span>${customerInfo.diaChi}</span>
                  </div>
                </c:if>
                <c:if test="${not empty customerInfo.gioiTinh}">
                  <div class="profile-info-row">
                    <i class="fa-solid fa-user"></i>
                    <span>${customerInfo.gioiTinh}</span>
                  </div>
                </c:if>
              </div>
            </c:if>
          </div>
        </div>

        <!-- RIGHT: Form + Orders -->
        <div class="profile-main">
          <!-- Update Form -->
          <div class="profile-section">
            <div class="profile-section-title">
              <i class="fa-solid fa-pen-to-square"></i> Cập Nhật Thông Tin
            </div>
            <form action="${pageContext.request.contextPath}/profile" method="POST">
              <div class="profile-form-grid">
                <div class="form-group">
                  <label class="form-label">Mã Tài Khoản</label>
                  <input type="text" class="form-control-disabled" value="${customerInfo.id}" readonly>
                </div>
                <div class="form-group">
                  <label class="form-label">Họ và Tên</label>
                  <div class="input-group">
                    <input type="text" name="hoTen" class="form-control"
                           value="${customerInfo.hoTen}" required>
                    <i class="fa-solid fa-user input-group-icon"></i>
                  </div>
                </div>

                <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
                  <div class="form-group">
                    <label class="form-label">Số Điện Thoại</label>
                    <div class="input-group">
                      <input type="text" name="dienThoai" class="form-control"
                             value="${customerInfo.dienThoai}" required>
                      <i class="fa-solid fa-phone input-group-icon"></i>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label">Email</label>
                    <div class="input-group">
                      <input type="email" name="email" class="form-control"
                             value="${customerInfo.email}">
                      <i class="fa-solid fa-envelope input-group-icon"></i>
                    </div>
                  </div>
                  <div class="form-group profile-form-full">
                    <label class="form-label">Địa Chỉ Giao Hàng</label>
                    <div class="input-group">
                      <input type="text" name="diaChi" class="form-control"
                             value="${customerInfo.diaChi}" required>
                      <i class="fa-solid fa-location-dot input-group-icon"></i>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="form-label">Ngày Sinh</label>
                    <input type="date" name="ngaySinh" class="form-control"
                           value="${customerInfo.ngaySinh}"
                           style="background:rgba(255,255,255,0.05); border:1px solid var(--border-light); border-radius:var(--radius-md); color:var(--text-primary); padding:12px 16px; width:100%; outline:none;">
                  </div>
                  <div class="form-group">
                    <label class="form-label">Giới Tính</label>
                    <select name="gioiTinh" class="form-control">
                      <option value="Nam"  ${customerInfo.gioiTinh == 'Nam'  ? 'selected' : ''}>Nam</option>
                      <option value="Nữ"   ${customerInfo.gioiTinh == 'Nữ'   ? 'selected' : ''}>Nữ</option>
                      <option value="Khác" ${customerInfo.gioiTinh == 'Khác' ? 'selected' : ''}>Khác</option>
                    </select>
                  </div>
                </c:if>

                <div class="form-group profile-form-full">
                  <label class="form-label">Mật Khẩu Mới</label>
                  <div class="input-group">
                    <input type="password" name="matKhau" class="form-control"
                           value="${customerInfo.matKhau}" required>
                    <i class="fa-solid fa-lock input-group-icon"></i>
                  </div>
                </div>
              </div>

              <div style="margin-top:var(--space-xl);">
                <button type="submit" class="btn btn-primary btn-lg btn-shimmer">
                  <i class="fa-solid fa-floppy-disk"></i> Lưu Thay Đổi
                </button>
              </div>
            </form>
          </div>

          <!-- Order History -->
          <c:if test="${sessionScope.currentUser.role == 'CUSTOMER'}">
            <div class="profile-section">
              <div class="profile-section-title">
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch Sử Đơn Hàng
              </div>
              <div class="data-table-wrap">
                <table class="data-table">
                  <thead>
                    <tr>
                      <th>Mã Đơn</th>
                      <th>Tổng Tiền</th>
                      <th>Trạng Thái</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="o" items="${orders}">
                      <tr>
                        <td><strong style="color:var(--text-primary);">${o.id}</strong></td>
                        <td style="color:var(--primary); font-weight:700;">
                          <fmt:formatNumber value="${o.tongTien}" type="number"/> đ
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${o.trangThai eq 'Đã thanh toán'}">
                              <span class="order-status status-paid">${o.trangThai}</span>
                            </c:when>
                            <c:when test="${o.trangThai eq 'Đã hủy'}">
                              <span class="order-status status-cancel">${o.trangThai}</span>
                            </c:when>
                            <c:otherwise>
                              <span class="order-status status-other">${o.trangThai}</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                      <tr>
                        <td colspan="3" style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
                          <i class="fa-solid fa-box-open" style="display:block; font-size:32px; margin-bottom:var(--space-sm);"></i>
                          Bạn chưa có đơn hàng nào.
                        </td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </c:if>
        </div>

      </div><!-- end .profile-layout -->
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
