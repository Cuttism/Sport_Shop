<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Tạo tài khoản SportShop để bắt đầu mua sắm sản phẩm thể thao chính hãng.">
  <title>SportShop - Đăng Ký Tài Khoản</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-base); display: flex; overflow-y: auto; }
    .auth-page { display: flex; width: 100%; min-height: 100vh; }
    .auth-hero {
      flex: 1;
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 60px;
      background: var(--bg-deep);
      overflow: hidden;
    }
    .auth-hero-bg {
      position: absolute; inset: 0;
      background-image: url('${pageContext.request.contextPath}/images/hero-banner.png');
      background-size: cover; background-position: center; opacity: 0.22;
    }
    .auth-hero-overlay {
      position: absolute; inset: 0;
      background: linear-gradient(135deg, rgba(10,17,25,0.92), rgba(10,17,25,0.78));
    }
    .auth-hero::before {
      content: ''; position: absolute; inset: 0;
      background: repeating-linear-gradient(45deg, transparent, transparent 50px, rgba(255,107,53,0.025) 50px, rgba(255,107,53,0.025) 100px);
      animation: stripeMove 25s linear infinite;
    }
    @keyframes stripeMove { from{transform:translate(0,0)} to{transform:translate(100px,100px)} }
    .auth-hero-content { position: relative; z-index: 2; text-align: center; max-width: 420px; }
    .auth-hero-logo {
      font-family: var(--font-display); font-size: 50px; letter-spacing: 4px;
      background: linear-gradient(135deg, var(--primary), var(--primary-light), var(--accent));
      -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
      margin-bottom: var(--space-md); display: block;
    }
    .auth-hero-tagline { font-size: 16px; color: var(--text-muted); line-height: 1.7; margin-bottom: var(--space-xl); }
    .auth-hero-tagline strong { color: var(--primary); }
    .auth-hero-perks { display: flex; flex-direction: column; gap: var(--space-sm); text-align: left; }
    .perk-item {
      display: flex; align-items: center; gap: 12px;
      padding: 12px 16px; border-radius: var(--radius-md);
      background: rgba(255,255,255,0.04); border: 1px solid var(--border);
      font-size: 13px; color: var(--text-secondary);
    }
    .perk-item i { color: var(--primary); font-size: 15px; width: 18px; text-align: center; }

    .auth-form-panel {
      flex: 1; background: var(--bg-navy);
      display: flex; flex-direction: column; justify-content: center; align-items: center;
      padding: 48px; position: relative; overflow-y: auto;
    }
    .auth-form-panel::before {
      content: ''; position: absolute; left: 0; top: 15%; height: 70%; width: 2px;
      background: linear-gradient(to bottom, transparent, var(--primary), transparent);
    }
    .auth-form-container { width: 100%; max-width: 420px; }
    .auth-form-header { margin-bottom: var(--space-xl); }
    .auth-form-header h1 { font-family: var(--font-display); font-size: 34px; letter-spacing: 1.5px; color: var(--text-primary); margin-bottom: 6px; }
    .auth-form-header p { font-size: 14px; color: var(--text-muted); }
    .auth-form-fields { display: flex; flex-direction: column; gap: var(--space-md); margin-bottom: var(--space-lg); }
    .auth-link-row { text-align: center; font-size: 14px; color: var(--text-muted); margin-top: var(--space-lg); }
    .auth-link-row a { color: var(--primary); font-weight: 600; }
    .auth-link-row a:hover { color: var(--primary-light); text-decoration: underline; }

    /* Make select and date inputs match dark theme */
    .form-control-dark {
      width: 100%; padding: 13px 16px;
      background: rgba(255,255,255,0.05);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-md);
      color: var(--text-primary);
      font-size: 14px; font-family: var(--font-body);
      outline: none; transition: var(--transition-fast);
    }
    .form-control-dark:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(255,107,53,0.15); }
    .form-control-dark option { background: var(--bg-navy); color: var(--text-primary); }

    @media (max-width: 900px) {
      .auth-page { flex-direction: column; }
      .auth-hero { flex: none; min-height: 280px; padding: 40px 24px; }
      .auth-form-panel { flex: none; padding: 40px 24px; }
      .auth-form-panel::before { display: none; }
    }
  </style>
</head>
<body>
<div class="auth-page">

  <!-- LEFT HERO -->
  <div class="auth-hero">
    <div class="auth-hero-bg"></div>
    <div class="auth-hero-overlay"></div>
    <div class="auth-hero-content">
      <span class="auth-hero-logo">SPORTSHOP</span>
      <p class="auth-hero-tagline">
        Gia nhập cộng đồng mua sắm <strong>thể thao</strong> hàng đầu.<br>
        Nhận ưu đãi độc quyền cho thành viên mới.
      </p>
      <div class="auth-hero-perks">
        <div class="perk-item">
          <i class="fa-solid fa-gift"></i>
          <span>Ưu đãi hấp dẫn cho thành viên mới</span>
        </div>
        <div class="perk-item">
          <i class="fa-solid fa-truck-fast"></i>
          <span>Miễn phí vận chuyển cho đơn từ 500K</span>
        </div>
        <div class="perk-item">
          <i class="fa-solid fa-shield-halved"></i>
          <span>Bảo hành sản phẩm chính hãng 100%</span>
        </div>
        <div class="perk-item">
          <i class="fa-solid fa-headset"></i>
          <span>Hỗ trợ khách hàng 24/7</span>
        </div>
      </div>
    </div>
  </div>

  <!-- RIGHT FORM -->
  <div class="auth-form-panel">
    <div class="auth-form-container">
      <div class="auth-form-header">
        <h1>Đăng Ký</h1>
        <p>Điền thông tin bên dưới để tạo tài khoản mới</p>
      </div>

      <c:if test="${not empty error}">
        <div class="alert alert-error" style="margin-bottom:var(--space-lg);">
          <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/register" method="POST">
        <div class="auth-form-fields">
          <div class="form-group">
            <label class="form-label" for="id">Mã Tài Khoản (Bắt đầu bằng KH)</label>
            <div class="input-group">
              <input type="text" id="id" name="id" class="form-control"
                     placeholder="VD: KH08" required autocomplete="off">
              <i class="fa-solid fa-id-badge input-group-icon"></i>
            </div>
          </div>
          <div class="form-group">
            <label class="form-label" for="hoTen">Họ và Tên</label>
            <div class="input-group">
              <input type="text" id="hoTen" name="hoTen" class="form-control"
                     placeholder="VD: Nguyễn Văn A" required autocomplete="name">
              <i class="fa-solid fa-user input-group-icon"></i>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label" for="dienThoai">Số Điện Thoại</label>
              <div class="input-group">
                <input type="text" id="dienThoai" name="dienThoai" class="form-control"
                       placeholder="0912 345 678" required autocomplete="tel">
                <i class="fa-solid fa-phone input-group-icon"></i>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label" for="gioiTinh">Giới Tính</label>
              <select id="gioiTinh" name="gioiTinh" class="form-control-dark">
                <option value="Nam">Nam</option>
                <option value="Nữ">Nữ</option>
                <option value="Khác">Khác</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="form-label" for="diaChi">Địa Chỉ</label>
            <div class="input-group">
              <input type="text" id="diaChi" name="diaChi" class="form-control"
                     placeholder="VD: Quận 1, TP. Hồ Chí Minh" required>
              <i class="fa-solid fa-location-dot input-group-icon"></i>
            </div>
          </div>
          <div class="form-row">
            <div class="form-group">
              <label class="form-label" for="email">Email</label>
              <div class="input-group">
                <input type="email" id="email" name="email" class="form-control"
                       placeholder="email@example.com" autocomplete="email">
                <i class="fa-solid fa-envelope input-group-icon"></i>
              </div>
            </div>
            <div class="form-group">
              <label class="form-label" for="ngaySinh">Ngày Sinh</label>
              <input type="date" id="ngaySinh" name="ngaySinh" class="form-control-dark">
            </div>
          </div>
          <div class="form-group">
            <label class="form-label" for="matKhau">Mật Khẩu</label>
            <div class="input-group">
              <input type="password" id="matKhau" name="matKhau" class="form-control"
                     placeholder="Tối thiểu 6 ký tự" required>
              <i class="fa-solid fa-lock input-group-icon"></i>
            </div>
          </div>
        </div>
        <button type="submit" class="btn btn-primary btn-full btn-lg btn-shimmer">
          <i class="fa-solid fa-user-plus"></i> Tạo Tài Khoản
        </button>
      </form>

      <div class="auth-link-row">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập ngay</a>
      </div>
    </div>
  </div>

</div>
</body>
</html>
