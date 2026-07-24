<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="jakarta.tags.core" prefix="c" %>
		<!DOCTYPE html>
		<html lang="vi">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>SportShop - Đăng nhập</title>
			<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
				rel="stylesheet">
			<style>
				/* ============================================= */
				/* RESET & BASE                                  */
				/* ============================================= */
				* {
					box-sizing: border-box;
					margin: 0;
					padding: 0;
				}

				body {
					font-family: 'Inter', 'Segoe UI', sans-serif;
					background-color: #0F1923;
					color: #fff;
					min-height: 100vh;
					display: flex;
					overflow: hidden;
				}

				/* ============================================= */
				/* SPLIT SCREEN LAYOUT                           */
				/* ============================================= */
				.login-page {
					display: flex;
					width: 100%;
					min-height: 100vh;
				}

				/* --- LEFT HERO PANEL --- */
				.hero-panel {
					flex: 1.2;
					background: linear-gradient(135deg, #0F1923 0%, #1B2838 50%, #0F1923 100%);
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;
					padding: 60px;
					position: relative;
					overflow: hidden;
				}

				/* Diagonal stripe pattern overlay */
				.hero-panel::before {
					content: '';
					position: absolute;
					top: -50%;
					left: -50%;
					width: 200%;
					height: 200%;
					background: repeating-linear-gradient(45deg,
							transparent,
							transparent 40px,
							rgba(255, 107, 53, 0.03) 40px,
							rgba(255, 107, 53, 0.03) 80px);
					animation: stripeMove 20s linear infinite;
				}

				@keyframes stripeMove {
					0% {
						transform: translate(0, 0);
					}

					100% {
						transform: translate(80px, 80px);
					}
				}

				/* Glowing orb decoration */
				.hero-panel::after {
					content: '';
					position: absolute;
					width: 400px;
					height: 400px;
					background: radial-gradient(circle, rgba(255, 107, 53, 0.15) 0%, transparent 70%);
					border-radius: 50%;
					bottom: -100px;
					right: -100px;
					animation: orbPulse 4s ease-in-out infinite;
				}

				@keyframes orbPulse {

					0%,
					100% {
						transform: scale(1);
						opacity: 0.5;
					}

					50% {
						transform: scale(1.2);
						opacity: 0.8;
					}
				}

				.hero-content {
					position: relative;
					z-index: 2;
					text-align: center;
					max-width: 480px;
				}

				.hero-logo {
					font-size: 64px;
					margin-bottom: 16px;
					display: block;
					animation: logoBounce 2s ease-in-out infinite;
				}

				@keyframes logoBounce {

					0%,
					100% {
						transform: translateY(0);
					}

					50% {
						transform: translateY(-10px);
					}
				}

				.hero-brand {
					font-size: 42px;
					font-weight: 900;
					letter-spacing: -1px;
					margin-bottom: 8px;
					background: linear-gradient(135deg, #FF6B35, #FF8C42, #FFB830);
					-webkit-background-clip: text;
					-webkit-text-fill-color: transparent;
					background-clip: text;
				}

				.hero-tagline {
					font-size: 18px;
					color: #8B9BB4;
					font-weight: 500;
					margin-bottom: 40px;
					line-height: 1.6;
				}

				.hero-tagline strong {
					color: #FF6B35;
					-webkit-text-fill-color: #FF6B35;
				}

				.hero-stats {
					display: flex;
					gap: 32px;
					justify-content: center;
				}

				.hero-stat {
					text-align: center;
				}

				.hero-stat-value {
					font-size: 28px;
					font-weight: 800;
					color: #FF6B35;
				}

				.hero-stat-label {
					font-size: 12px;
					color: #8B9BB4;
					text-transform: uppercase;
					letter-spacing: 1px;
					margin-top: 4px;
				}

				/* --- RIGHT FORM PANEL --- */
				.form-panel {
					flex: 0.8;
					background: #1B2838;
					display: flex;
					flex-direction: column;
					justify-content: center;
					align-items: center;
					padding: 60px 48px;
					position: relative;
				}

				/* Orange accent line on the left edge of form panel */
				.form-panel::before {
					content: '';
					position: absolute;
					left: 0;
					top: 15%;
					height: 70%;
					width: 3px;
					background: linear-gradient(to bottom, transparent, #FF6B35, transparent);
				}

				.form-container {
					width: 100%;
					max-width: 380px;
				}

				.form-header {
					margin-bottom: 36px;
				}

				.form-header h2 {
					font-size: 28px;
					font-weight: 800;
					color: #fff;
					margin-bottom: 8px;
				}

				.form-header p {
					font-size: 14px;
					color: #8B9BB4;
				}

				/* ============================================= */
				/* FORM ELEMENTS                                 */
				/* ============================================= */
				.form-group {
					margin-bottom: 24px;
				}

				.form-group label {
					display: block;
					font-size: 13px;
					font-weight: 600;
					color: #8B9BB4;
					text-transform: uppercase;
					letter-spacing: 0.5px;
					margin-bottom: 8px;
				}

				.input-wrapper {
					position: relative;
				}

				.input-wrapper .icon {
					position: absolute;
					left: 14px;
					top: 50%;
					transform: translateY(-50%);
					font-size: 18px;
					color: #8B9BB4;
					transition: color 0.3s;
				}

				.form-group input[type="text"] {
					width: 100%;
					padding: 14px 14px 14px 44px;
					background: #0F1923;
					border: 2px solid #2A3F55;
					border-radius: 10px;
					color: #fff;
					font-size: 15px;
					font-family: 'Inter', sans-serif;
					outline: none;
					transition: all 0.3s ease;
				}

				.form-group input[type="text"]::placeholder {
					color: #4A5E75;
				}

				.form-group input[type="text"]:focus {
					border-color: #FF6B35;
					box-shadow: 0 0 0 4px rgba(255, 107, 53, 0.15);
				}

				.form-group input[type="text"]:focus+.icon,
				.form-group input[type="text"]:focus~.icon {
					color: #FF6B35;
				}

				/* ============================================= */
				/* BUTTON                                        */
				/* ============================================= */
				.btn-login {
					width: 100%;
					padding: 14px;
					background: linear-gradient(135deg, #FF6B35, #E85A2A);
					color: #fff;
					border: none;
					border-radius: 10px;
					cursor: pointer;
					font-size: 16px;
					font-weight: 700;
					font-family: 'Inter', sans-serif;
					letter-spacing: 0.5px;
					transition: all 0.3s ease;
					position: relative;
					overflow: hidden;
				}

				.btn-login:hover {
					transform: scale(1.03);
					box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
				}

				.btn-login:active {
					transform: scale(0.98);
				}

				/* Shimmer effect on button */
				.btn-login::after {
					content: '';
					position: absolute;
					top: 0;
					left: -100%;
					width: 100%;
					height: 100%;
					background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
					transition: left 0.5s;
				}

				.btn-login:hover::after {
					left: 100%;
				}

				/* ============================================= */
				/* ERROR MESSAGE                                 */
				/* ============================================= */
				.error-msg {
					background: rgba(255, 71, 87, 0.15);
					border: 1px solid rgba(255, 71, 87, 0.3);
					color: #FF4757;
					padding: 12px 16px;
					border-radius: 10px;
					font-size: 14px;
					font-weight: 500;
					margin-bottom: 24px;
					text-align: center;
					animation: slideDown 0.4s ease-out;
				}

				@keyframes slideDown {
					from {
						opacity: 0;
						transform: translateY(-10px);
					}

					to {
						opacity: 1;
						transform: translateY(0);
					}
				}



				/* ============================================= */
				/* SUCCESS MESSAGE                               */
				/* ============================================= */
				.success-msg {
					background: rgba(0, 214, 127, 0.15);
					border: 1px solid rgba(0, 214, 127, 0.3);
					color: #00D67F;
					padding: 12px 16px;
					border-radius: 10px;
					font-size: 14px;
					font-weight: 500;
					margin-bottom: 24px;
					text-align: center;
					animation: slideDown 0.4s ease-out;
				}

				/* ============================================= */
				/* LINKS                                         */
				/* ============================================= */
				.link-box {
					margin-top: 24px;
					text-align: center;
					font-size: 14px;
					color: #8B9BB4;
				}

				.link-box a {
					color: #FF6B35;
					text-decoration: none;
					font-weight: 600;
					transition: color 0.3s ease;
				}

				.link-box a:hover {
					color: #FF8C42;
					text-decoration: underline;
				}

				/* ============================================= */
				/* HINT BOX                                      */
				/* ============================================= */
				.hint-box {
					margin-top: 32px;
					background: rgba(15, 25, 35, 0.6);
					border: 1px solid #2A3F55;
					padding: 16px;
					border-radius: 10px;
					position: relative;
				}

				.hint-box::before {
					content: '';
					position: absolute;
					left: 0;
					top: 0;
					bottom: 0;
					width: 3px;
					background: #FF6B35;
					border-radius: 3px 0 0 3px;
				}

				.hint-title {
					font-size: 12px;
					font-weight: 700;
					color: #FF6B35;
					text-transform: uppercase;
					letter-spacing: 1px;
					margin-bottom: 12px;
				}

				.hint-item {
					display: flex;
					justify-content: space-between;
					align-items: center;
					padding: 6px 0;
				}

				.hint-item span {
					font-size: 13px;
					color: #8B9BB4;
				}

				.hint-item code {
					background: rgba(255, 107, 53, 0.15);
					color: #FF8C42;
					padding: 3px 10px;
					border-radius: 6px;
					font-size: 13px;
					font-weight: 600;
					font-family: 'JetBrains Mono', 'Consolas', monospace;
				}

				/* ============================================= */
				/* RESPONSIVE                                    */
				/* ============================================= */
				@media (max-width: 900px) {
					.login-page {
						flex-direction: column;
					}

					.hero-panel {
						flex: none;
						padding: 40px 24px;
						min-height: auto;
					}

					.hero-logo {
						font-size: 48px;
					}

					.hero-brand {
						font-size: 32px;
					}

					.hero-tagline {
						font-size: 15px;
						margin-bottom: 24px;
					}

					.hero-stats {
						gap: 20px;
					}

					.form-panel {
						flex: none;
						padding: 40px 24px;
					}

					.form-panel::before {
						display: none;
					}
				}
			</style>
		</head>

		<body>

			<div class="login-page">

				<!-- ===== LEFT HERO PANEL ===== -->
				<div class="hero-panel">
					<div class="hero-content">
						<span class="hero-logo"></span>
						<h1 class="hero-brand">SportShop</h1>
						<p class="hero-tagline">
							Nền tảng quản lý cửa hàng <strong>thể thao</strong> thông minh.<br>
							Nhanh chóng. Chính xác. Hiệu quả.
						</p>
						<div class="hero-stats">
							<div class="hero-stat">
								<div class="hero-stat-value">10+</div>
								<div class="hero-stat-label">Sản phẩm</div>
							</div>
							<div class="hero-stat">
								<div class="hero-stat-value">7+</div>
								<div class="hero-stat-label">Khách hàng</div>
							</div>
							<div class="hero-stat">
								<div class="hero-stat-value">24/7</div>
								<div class="hero-stat-label">Hỗ trợ</div>
							</div>
						</div>
					</div>
				</div>

				<!-- ===== RIGHT FORM PANEL ===== -->
				<div class="form-panel">
					<div class="form-container">

						<div class="form-header">
							<h2>Đăng nhập</h2>
							<p>Nhập mã định danh của bạn để truy cập hệ thống</p>
						</div>

						<c:if test="${not empty error}">
							<div class="error-msg">${error}</div>
						</c:if>

						<c:if test="${not empty success}">
							<div class="success-msg">${success}</div>
						</c:if>

						<form action="${pageContext.request.contextPath}/login" method="POST">
							<div class="form-group">
								<label for="username">Mã tài khoản (ID)</label>
								<div class="input-wrapper">
									<input type="text" id="username" name="username"
										placeholder="VD: NVIT01, NVBH01, KH01..." required autocomplete="off">
									<span class="icon"></span>
								</div>
							</div>
							<div class="form-group">
								<label for="password">Mật khẩu (Mặc định: 123)</label>
								<div class="input-wrapper">
									<input type="password" id="password" name="password" style="width: 100%; padding: 14px 14px 14px 44px; background: #0F1923; border: 2px solid #2A3F55; border-radius: 10px; color: #fff; font-size: 15px; font-family: 'Inter', sans-serif; outline: none; transition: all 0.3s ease;"
										placeholder="Nhập mật khẩu" required autocomplete="off">
									<span class="icon"></span>
								</div>
							</div>
							<button type="submit" class="btn-login">Đăng nhập →</button>
						</form>

						<div class="link-box">
							Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a>
						</div>

						<div class="hint-box">
							<div class="hint-title">Tài khoản demo</div>
							<div class="hint-item">
								<span>Admin hệ thống</span>
								<code>NVIT01</code>
							</div>
							<div class="hint-item">
								<span>Nhân viên bán hàng</span>
								<code>NVBH01</code>
							</div>
							<div class="hint-item">
								<span>Khách hàng</span>
								<code>KH01</code>
							</div>
						</div>

					</div>
				</div>

			</div>

		</body>

		</html>
		</style>
		</head>

		</html>