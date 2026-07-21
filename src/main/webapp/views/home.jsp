<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="jakarta.tags.core" prefix="c" %>
		<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
			<!DOCTYPE html>
			<html lang="vi">

			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<title>SportShop - Trang chủ cửa hàng thể thao</title>
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
						background-color: #F0F2F5;
						color: #1B2838;
						min-height: 100vh;
						display: flex;
						flex-direction: column;
					}

					/* ============================================= */
					/* NAVBAR                                        */
					/* ============================================= */
					.navbar {
						background: linear-gradient(135deg, #1B2838, #0F1923);
						color: white;
						padding: 0 40px;
						display: flex;
						justify-content: space-between;
						align-items: center;
						height: 64px;
						position: sticky;
						top: 0;
						z-index: 100;
						box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
					}

					.nav-logo {
						display: flex;
						align-items: center;
						gap: 10px;
						text-decoration: none;
					}

					.nav-logo-icon {
						font-size: 28px;
					}

					.nav-logo-text {
						font-size: 22px;
						font-weight: 800;
						background: linear-gradient(135deg, #FF6B35, #FF8C42);
						-webkit-background-clip: text;
						-webkit-text-fill-color: transparent;
						background-clip: text;
					}

					.nav-links {
						display: flex;
						align-items: center;
						gap: 8px;
					}

					.nav-links a {
						color: #8B9BB4;
						text-decoration: none;
						font-size: 14px;
						font-weight: 500;
						padding: 8px 16px;
						border-radius: 8px;
						transition: all 0.3s ease;
						position: relative;
					}

					.nav-links a:hover {
						color: #fff;
						background: rgba(255, 107, 53, 0.1);
					}

					.nav-links a.active {
						color: #FF6B35;
					}

					.nav-links a.logout {
						color: #FF4757;
						border: 1px solid rgba(255, 71, 87, 0.3);
					}

					.nav-links a.logout:hover {
						background: rgba(255, 71, 87, 0.1);
					}

					/* ============================================= */
					/* HERO / WELCOME SECTION                        */
					/* ============================================= */
					.hero-section {
						background: linear-gradient(135deg, #1B2838 0%, #2A3F55 100%);
						padding: 48px 40px;
						position: relative;
						overflow: hidden;
					}

					/* Diagonal stripe decoration */
					.hero-section::before {
						content: '';
						position: absolute;
						top: -50%;
						right: -20%;
						width: 60%;
						height: 200%;
						background: repeating-linear-gradient(45deg,
								transparent,
								transparent 30px,
								rgba(255, 107, 53, 0.04) 30px,
								rgba(255, 107, 53, 0.04) 60px);
					}

					.hero-inner {
						max-width: 1200px;
						margin: 0 auto;
						position: relative;
						z-index: 2;
					}

					.hero-welcome {
						display: flex;
						justify-content: space-between;
						align-items: center;
					}

					.hero-text h1 {
						font-size: 28px;
						font-weight: 800;
						color: #fff;
						margin-bottom: 8px;
					}

					.hero-text h1 .wave {
						display: inline-block;
						animation: wave 2s ease-in-out infinite;
					}

					@keyframes wave {

						0%,
						100% {
							transform: rotate(0deg);
						}

						25% {
							transform: rotate(20deg);
						}

						75% {
							transform: rotate(-10deg);
						}
					}

					.hero-text p {
						font-size: 15px;
						color: #8B9BB4;
					}

					.hero-text .user-id {
						color: #FF8C42;
						font-weight: 600;
					}

					.hero-badge {
						display: inline-flex;
						align-items: center;
						gap: 6px;
						padding: 8px 16px;
						border-radius: 30px;
						font-size: 13px;
						font-weight: 700;
						letter-spacing: 0.5px;
					}

					.hero-badge.customer {
						background: rgba(0, 214, 127, 0.15);
						color: #00D67F;
						border: 1px solid rgba(0, 214, 127, 0.3);
					}

					.hero-badge.admin {
						background: rgba(255, 107, 53, 0.15);
						color: #FF6B35;
						border: 1px solid rgba(255, 107, 53, 0.3);
					}

					.hero-badge.staff {
						background: rgba(255, 184, 48, 0.15);
						color: #FFB830;
						border: 1px solid rgba(255, 184, 48, 0.3);
					}

					/* Guest banner */
					.guest-banner {
						background: linear-gradient(135deg, #1B2838, #2A3F55);
						padding: 40px;
						text-align: center;
						position: relative;
						overflow: hidden;
					}

					.guest-banner h2 {
						font-size: 24px;
						color: #fff;
						margin-bottom: 12px;
					}

					.guest-banner p {
						color: #8B9BB4;
						font-size: 15px;
						margin-bottom: 20px;
					}

					.guest-banner .btn-login-cta {
						display: inline-block;
						padding: 12px 32px;
						background: linear-gradient(135deg, #FF6B35, #E85A2A);
						color: #fff;
						text-decoration: none;
						border-radius: 10px;
						font-weight: 700;
						font-size: 15px;
						transition: all 0.3s ease;
					}

					.guest-banner .btn-login-cta:hover {
						transform: scale(1.05);
						box-shadow: 0 8px 25px rgba(255, 107, 53, 0.4);
					}

					/* ============================================= */
					/* MAIN CONTENT                                  */
					/* ============================================= */
					.main-content {
						max-width: 1200px;
						margin: 0 auto;
						padding: 32px 40px;
						width: 100%;
						flex: 1;
					}

					.section-header {
						display: flex;
						justify-content: space-between;
						align-items: center;
						margin-bottom: 24px;
					}

					.section-header h2 {
						font-size: 22px;
						font-weight: 800;
						color: #1B2838;
						display: flex;
						align-items: center;
						gap: 8px;
					}

					.section-header .orange-bar {
						display: inline-block;
						width: 4px;
						height: 24px;
						background: #FF6B35;
						border-radius: 2px;
					}

					.product-count {
						font-size: 13px;
						color: #8B9BB4;
						font-weight: 500;
					}

					/* ============================================= */
					/* PRODUCT GRID                                  */
					/* ============================================= */
					.product-grid {
						display: grid;
						grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
						gap: 24px;
					}

					.product-card {
						background: #fff;
						border-radius: 14px;
						padding: 24px;
						box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
						border: 1px solid #E8ECF0;
						transition: all 0.3s ease;
						position: relative;
						overflow: hidden;
					}

					/* Orange gradient top stripe */
					.product-card::before {
						content: '';
						position: absolute;
						top: 0;
						left: 0;
						right: 0;
						height: 3px;
						background: linear-gradient(90deg, #FF6B35, #FF8C42, #FFB830);
						opacity: 0;
						transition: opacity 0.3s ease;
					}

					.product-card:hover {
						transform: translateY(-8px);
						box-shadow: 0 12px 32px rgba(0, 0, 0, 0.1);
						border-color: rgba(255, 107, 53, 0.3);
					}

					.product-card:hover::before {
						opacity: 1;
					}

					.product-icon {
						width: 56px;
						height: 56px;
						border-radius: 14px;
						display: flex;
						align-items: center;
						justify-content: center;
						font-size: 28px;
						margin-bottom: 16px;
						background: linear-gradient(135deg, rgba(255, 107, 53, 0.1), rgba(255, 140, 66, 0.05));
					}

					.product-card h4 {
						font-size: 16px;
						font-weight: 700;
						color: #1B2838;
						margin-bottom: 8px;
						line-height: 1.4;
					}

					.product-meta {
						display: flex;
						justify-content: space-between;
						align-items: center;
						margin-top: 16px;
						padding-top: 16px;
						border-top: 1px solid #F0F2F5;
					}

					.product-price {
						font-size: 18px;
						font-weight: 800;
						color: #FF6B35;
					}

					.product-stock {
						font-size: 12px;
						font-weight: 600;
						color: #00D67F;
						background: rgba(0, 214, 127, 0.1);
						padding: 4px 10px;
						border-radius: 20px;
					}

					.product-stock.low {
						color: #FF4757;
						background: rgba(255, 71, 87, 0.1);
					}
					
					.btn-add-cart {
						display: block;
						text-align: center;
						background: rgba(255, 107, 53, 0.1);
						color: #FF6B35;
						text-decoration: none;
						padding: 12px;
						border-radius: 10px;
						margin-top: 20px;
						font-weight: 700;
						font-size: 14px;
						transition: all 0.3s ease;
					}
					
					.btn-add-cart:hover {
						background: #FF6B35;
						color: #fff;
						transform: translateY(-2px);
					}

					/* ============================================= */
					/* FOOTER                                        */
					/* ============================================= */
					.footer {
						background: linear-gradient(135deg, #1B2838, #0F1923);
						padding: 24px 40px;
						text-align: center;
						margin-top: auto;
					}

					.footer p {
						color: #4A5E75;
						font-size: 13px;
					}

					.footer .brand {
						color: #FF6B35;
						font-weight: 700;
					}

					/* ============================================= */
					/* RESPONSIVE                                    */
					/* ============================================= */
					@media (max-width: 768px) {
						.navbar {
							padding: 0 20px;
						}

						.hero-section {
							padding: 32px 20px;
						}

						.hero-welcome {
							flex-direction: column;
							gap: 16px;
							align-items: flex-start;
						}

						.main-content {
							padding: 24px 20px;
						}

						.product-grid {
							grid-template-columns: 1fr;
						}
					}
				</style>
			</head>

			<body>

				<!-- ===== NAVBAR ===== -->
				<div class="navbar">
					<a href="${pageContext.request.contextPath}/home" class="nav-logo">
						<span class="nav-logo-icon">🏀</span>
						<span class="nav-logo-text">SportShop</span>
					</a>
					<div class="nav-links">
						<a href="${pageContext.request.contextPath}/home" class="active">🏠 Trang chủ</a>
						<form action="${pageContext.request.contextPath}/search" method="GET" style="display:flex; align-items:center;">
							<input type="text" name="keyword" value="${keyword}" placeholder="Tìm sản phẩm..." style="padding:6px 12px; border-radius:6px 0 0 6px; border:none; outline:none; font-family:'Inter'; font-size:13px; width:180px;">
							<button type="submit" style="padding:6px 10px; border-radius:0 6px 6px 0; border:none; background:#FF6B35; color:white; cursor:pointer; font-size:13px;">🔍</button>
						</form>
						<a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng <c:if test="${not empty sessionScope.cart}"><span style="background:#FF4757; color:white; padding:2px 6px; border-radius:10px; font-size:12px; margin-left:4px;">${sessionScope.cart.size()}</span></c:if></a>
						<c:if test="${not empty sessionScope.currentUser}">
							<a href="${pageContext.request.contextPath}/profile">👤 Tài khoản</a>
							<a href="${pageContext.request.contextPath}/login" class="logout">🚪 Đăng xuất</a>
						</c:if>
					</div>
				</div>

				<!-- ===== HERO SECTION ===== -->
				<c:choose>
					<c:when test="${not empty sessionScope.currentUser}">
						<div class="hero-section">
							<div class="hero-inner">
								<div class="hero-welcome">
									<div class="hero-text">
										<h1>Xin chào, ${sessionScope.currentUser.hoTen}! <span class="wave">👋</span>
										</h1>
										<p>Mã tài khoản: <span class="user-id">${sessionScope.currentUser.id}</span></p>
									</div>
									<c:choose>
										<c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
											<span class="hero-badge admin">🛡️ ADMIN</span>
										</c:when>
										<c:when test="${sessionScope.currentUser.role == 'STAFF'}">
											<span class="hero-badge staff">⚙️ STAFF</span>
										</c:when>
										<c:otherwise>
											<span class="hero-badge customer">🎯 KHÁCH HÀNG</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="guest-banner">
							<h2>🏅 Chào mừng đến với SportShop</h2>
							<p>Đăng nhập để khám phá thế giới thể thao, mua sắm và quản lý đơn hàng dễ dàng.</p>
							<a href="${pageContext.request.contextPath}/login" class="btn-login-cta">Đăng nhập ngay
								→</a>
						</div>
					</c:otherwise>
				</c:choose>

				<!-- ===== MAIN CONTENT ===== -->
				<div class="main-content">

					<div class="section-header">
						<h2><span class="orange-bar"></span>
							<c:choose>
								<c:when test="${not empty keyword}">
									Kết quả tìm kiếm cho: '${keyword}'
								</c:when>
								<c:otherwise>
									Sản phẩm nổi bật
								</c:otherwise>
							</c:choose>
						</h2>
						<span class="product-count">
							<c:if test="${not empty products}">${products.size()} sản phẩm</c:if>
						</span>
					</div>

					<div class="product-grid">
						<c:forEach var="product" items="${products}" varStatus="status">
							<div class="product-card">
								<div class="product-icon">
									<c:choose>
										<c:when test="${status.index % 5 == 0}">👟</c:when>
										<c:when test="${status.index % 5 == 1}">👕</c:when>
										<c:when test="${status.index % 5 == 2}">🏸</c:when>
										<c:when test="${status.index % 5 == 3}">⚽</c:when>
										<c:otherwise>🏋️</c:otherwise>
									</c:choose>
								</div>
								<h4><a href="${pageContext.request.contextPath}/product?id=${product.id}" style="text-decoration:none; color:inherit;">${product.tenSanPham}</a></h4>
								<div class="product-meta">
									<span class="product-price">
										<fmt:formatNumber value="${product.gia}" type="number" groupingUsed="true" /> đ
									</span>
									<c:choose>
										<c:when test="${product.soLuongTon <= 20}">
											<span class="product-stock low">Còn ${product.soLuongTon}</span>
										</c:when>
										<c:otherwise>
											<span class="product-stock">Còn ${product.soLuongTon}</span>
										</c:otherwise>
									</c:choose>
								</div>
								<a href="${pageContext.request.contextPath}/cart?action=add&id=${product.id}" class="btn-add-cart">🛒 Thêm vào giỏ</a>
							</div>
						</c:forEach>
					</div>

				</div>

				<!-- ===== FOOTER ===== -->
				<div class="footer">
					<p>© 2026 <span class="brand">SportShop</span> — Hệ thống quản lý cửa hàng thể thao</p>
				</div>

				<!-- ===== CHATBOT WIDGET ===== -->
				<div class="chatbot-widget" id="chatbotWidget">
					<div class="chatbot-header" onclick="toggleChat()">
						<span style="font-size:18px;">💬</span>
						<span style="font-weight:600; flex:1;">Hỗ trợ trực tuyến</span>
						<span id="chatToggleIcon">▲</span>
					</div>
					<div class="chatbot-body" id="chatbotBody">
						<div class="chat-messages" id="chatMessages">
							<div class="message bot">Xin chào! Tôi có thể giúp gì cho bạn?</div>
						</div>
						<div class="chat-input-area">
							<input type="text" id="chatInput" placeholder="Nhập tin nhắn..." onkeypress="handleChatKeyPress(event)">
							<button onclick="sendMessage()">Gửi</button>
						</div>
					</div>
				</div>

				<style>
					.chatbot-widget { position: fixed; bottom: 20px; right: 20px; width: 320px; background: #fff; border-radius: 12px; box-shadow: 0 5px 25px rgba(0,0,0,0.15); overflow: hidden; z-index: 1000; display: flex; flex-direction: column; transition: all 0.3s ease; }
					.chatbot-header { background: linear-gradient(135deg, #1B2838, #0F1923); color: white; padding: 12px 16px; display: flex; align-items: center; gap: 10px; cursor: pointer; }
					.chatbot-body { height: 0; display: flex; flex-direction: column; transition: height 0.3s ease; }
					.chatbot-widget.open .chatbot-body { height: 350px; }
					.chat-messages { flex: 1; padding: 16px; overflow-y: auto; display: flex; flex-direction: column; gap: 12px; background: #F8F9FA; }
					.message { max-width: 80%; padding: 10px 14px; border-radius: 12px; font-size: 13px; line-height: 1.5; }
					.message.bot { background: #fff; color: #1B2838; align-self: flex-start; border: 1px solid #E8ECF0; border-bottom-left-radius: 4px; }
					.message.user { background: #FF6B35; color: white; align-self: flex-end; border-bottom-right-radius: 4px; }
					.chat-input-area { display: flex; padding: 12px; background: #fff; border-top: 1px solid #E8ECF0; }
					.chat-input-area input { flex: 1; border: 1px solid #E8ECF0; border-radius: 20px; padding: 8px 16px; font-family: 'Inter'; font-size: 13px; outline: none; }
					.chat-input-area input:focus { border-color: #FF6B35; }
					.chat-input-area button { background: none; border: none; color: #FF6B35; font-weight: 700; padding: 0 10px; cursor: pointer; }
				</style>

				<script>
					function toggleChat() {
						const widget = document.getElementById('chatbotWidget');
						const icon = document.getElementById('chatToggleIcon');
						widget.classList.toggle('open');
						icon.innerText = widget.classList.contains('open') ? '▼' : '▲';
					}
					function handleChatKeyPress(e) { if (e.key === 'Enter') sendMessage(); }
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
							appendMessage('Lỗi kết nối tới máy chủ.', 'bot');
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