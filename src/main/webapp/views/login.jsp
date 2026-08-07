<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta name="description" content="Đăng nhập vào SportShop để mua sắm và quản lý đơn hàng của bạn.">
      <title>SportShop - Đăng Nhập</title>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
      <style>
        body {
          background: var(--bg-base);
          display: flex;
          overflow: hidden;
        }

        .auth-page {
          display: flex;
          width: 100%;
          min-height: 100vh;
        }

        /* LEFT HERO PANEL */
        .auth-hero {
          flex: 1.2;
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
          position: absolute;
          inset: 0;
          background-image: url('${pageContext.request.contextPath}/images/hero-banner.png');
          background-size: cover;
          background-position: center;
          opacity: 0.25;
        }

        .auth-hero-overlay {
          position: absolute;
          inset: 0;
          background: linear-gradient(135deg, rgba(10, 17, 25, 0.9) 0%, rgba(10, 17, 25, 0.75) 100%);
        }

        .auth-hero::before {
          content: '';
          position: absolute;
          inset: 0;
          background: repeating-linear-gradient(45deg, transparent, transparent 50px,
              rgba(255, 107, 53, 0.025) 50px, rgba(255, 107, 53, 0.025) 100px);
          animation: stripeMove 25s linear infinite;
        }

        @keyframes stripeMove {
          from {
            transform: translate(0, 0);
          }

          to {
            transform: translate(100px, 100px);
          }
        }

        .auth-hero-content {
          position: relative;
          z-index: 2;
          text-align: center;
          max-width: 480px;
        }

        .auth-hero-logo {
          font-family: var(--font-display);
          font-size: 56px;
          letter-spacing: 4px;
          background: linear-gradient(135deg, var(--primary), var(--primary-light), var(--accent));
          -webkit-background-clip: text;
          -webkit-text-fill-color: transparent;
          background-clip: text;
          margin-bottom: var(--space-md);
          display: block;
          animation: logoPulse 3s ease-in-out infinite;
        }

        @keyframes logoPulse {

          0%,
          100% {
            opacity: 1;
          }

          50% {
            opacity: 0.85;
          }
        }

        .auth-hero-tagline {
          font-size: 18px;
          color: var(--text-muted);
          line-height: 1.7;
          margin-bottom: var(--space-2xl);
        }

        .auth-hero-tagline strong {
          color: var(--primary);
        }

        .auth-hero-stats {
          display: flex;
          gap: var(--space-xl);
          justify-content: center;
        }

        .auth-stat-value {
          font-family: var(--font-display);
          font-size: 28px;
          color: var(--primary);
        }

        .auth-stat-label {
          font-size: 11px;
          font-weight: 700;
          letter-spacing: 1.5px;
          text-transform: uppercase;
          color: var(--text-faint);
          margin-top: 2px;
        }

        .auth-stat-divider {
          width: 1px;
          background: var(--border-light);
          align-self: stretch;
        }

        /* RIGHT FORM PANEL */
        .auth-form-panel {
          flex: 0.85;
          background: var(--bg-navy);
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          padding: 60px 48px;
          position: relative;
        }

        .auth-form-panel::before {
          content: '';
          position: absolute;
          left: 0;
          top: 15%;
          height: 70%;
          width: 2px;
          background: linear-gradient(to bottom, transparent, var(--primary), transparent);
        }

        .auth-form-container {
          width: 100%;
          max-width: 400px;
        }

        .auth-form-header {
          margin-bottom: var(--space-2xl);
        }

        .auth-form-header h1 {
          font-family: var(--font-display);
          font-size: 36px;
          letter-spacing: 1.5px;
          color: var(--text-primary);
          margin-bottom: 6px;
        }

        .auth-form-header p {
          font-size: 14px;
          color: var(--text-muted);
        }

        .auth-form-fields {
          display: flex;
          flex-direction: column;
          gap: var(--space-lg);
          margin-bottom: var(--space-lg);
        }

        .auth-link-row {
          text-align: center;
          font-size: 14px;
          color: var(--text-muted);
          margin-top: var(--space-lg);
        }

        .auth-link-row a {
          color: var(--primary);
          font-weight: 600;
          transition: var(--transition-fast);
        }

        .auth-link-row a:hover {
          color: var(--primary-light);
          text-decoration: underline;
        }

        .demo-box {
          margin-top: var(--space-xl);
          background: rgba(255, 255, 255, 0.03);
          border: 1px solid var(--border);
          border-radius: var(--radius-lg);
          padding: var(--space-md);
          border-left: 3px solid var(--primary);
        }

        .demo-box-title {
          font-size: 11px;
          font-weight: 700;
          text-transform: uppercase;
          letter-spacing: 1.5px;
          color: var(--primary);
          margin-bottom: var(--space-md);
        }

        .demo-item {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 7px 0;
          border-bottom: 1px solid var(--border);
        }

        .demo-item:last-child {
          border-bottom: none;
        }

        .demo-item-role {
          font-size: 13px;
          color: var(--text-muted);
        }

        .demo-item-code {
          background: rgba(255, 107, 53, 0.12);
          color: var(--primary-light);
          padding: 3px 10px;
          border-radius: var(--radius-sm);
          font-size: 12px;
          font-weight: 700;
          font-family: 'Consolas', monospace;
          cursor: pointer;
          transition: var(--transition-fast);
          border: 1px solid rgba(255, 107, 53, 0.2);
        }

        .demo-item-code:hover {
          background: rgba(255, 107, 53, 0.2);
        }

        @media (max-width: 900px) {
          .auth-page {
            flex-direction: column;
          }

          .auth-hero {
            flex: none;
            min-height: 300px;
            padding: 40px 24px;
          }

          .auth-form-panel {
            flex: none;
            padding: 40px 24px;
          }

          .auth-form-panel::before {
            display: none;
          }

          body {
            overflow: auto;
          }
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
              Nền tảng quản lý cửa hàng <strong>thể thao</strong> thông minh.<br>
              Nhanh chóng &mdash; Chính xác &mdash; Hiệu quả.
            </p>
            <div class="auth-hero-stats">
              <div>
                <div class="auth-stat-value">10+</div>
                <div class="auth-stat-label">Sản Phẩm</div>
              </div>
              <div class="auth-stat-divider"></div>
              <div>
                <div class="auth-stat-value">7+</div>
                <div class="auth-stat-label">Khách Hàng</div>
              </div>
              <div class="auth-stat-divider"></div>
              <div>
                <div class="auth-stat-value">24/7</div>
                <div class="auth-stat-label">Hỗ Trợ</div>
              </div>
            </div>
          </div>
        </div>

        <!-- RIGHT FORM -->
        <div class="auth-form-panel">
          <div class="auth-form-container">
            <div class="auth-form-header">
              <h1>Đăng Nhập</h1>
              <p>Nhập thông tin tài khoản của bạn để truy cập hệ thống</p>
            </div>

            <c:if test="${not empty error}">
              <div class="alert alert-error" style="margin-bottom:var(--space-lg);">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
              </div>
            </c:if>

            <c:if test="${not empty success}">
              <div class="alert alert-success" style="margin-bottom:var(--space-lg);">
                <i class="fa-solid fa-circle-check"></i> ${success}
              </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST">
              <div class="auth-form-fields">
                <div class="form-group">
                  <label class="form-label" for="username">Tên Đăng Nhập</label>
                  <div class="input-group">
                    <input type="text" id="username" name="username" class="form-control"
                      placeholder="Mã NV, Email hoặc Số điện thoại" required autocomplete="off">
                    <i class="fa-solid fa-user input-group-icon"></i>
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label" for="password">Mật Khẩu</label>
                  <div class="input-group">
                    <input type="password" id="password" name="password" class="form-control"
                      placeholder="Nhập mật khẩu của bạn" required autocomplete="off">
                    <i class="fa-solid fa-lock input-group-icon"></i>
                  </div>
                </div>
              </div>
              <button type="submit" class="btn btn-primary btn-full btn-lg btn-shimmer">
                <i class="fa-solid fa-right-to-bracket"></i> Đăng Nhập
              </button>
            </form>

            <div class="auth-link-row">
              Chưa có tài khoản?
              <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
            </div>

            <div class="auth-link-row" style="margin-top: 10px;">
              <a href="${pageContext.request.contextPath}/home" style="color: var(--text-muted);"><i
                  class="fa-solid fa-house"></i> Quay về Trang Chủ</a>
            </div>

            <div class="demo-box">
              <div class="demo-box-title">Tài Khoản Demo (Mật khẩu: 123)</div>
              <div class="demo-item">
                <span class="demo-item-role">Quản trị viên</span>
                <code class="demo-item-code" onclick="fillDemo('NVIT01')">NVIT01</code>
              </div>
              <div class="demo-item">
                <span class="demo-item-role">Nhân viên bán hàng</span>
                <code class="demo-item-code" onclick="fillDemo('NVBH01')">NVBH01</code>
              </div>
              <div class="demo-item">
                <span class="demo-item-role">Khách hàng</span>
                <code class="demo-item-code" onclick="fillDemo('KH01')">KH01</code>
              </div>
            </div>
          </div>
        </div>

      </div>
      <script>
        function fillDemo(id) {
          document.getElementById('username').value = id;
          document.getElementById('password').value = '123';
          document.getElementById('username').focus();
        }
      </script>
    </body>

    </html>