<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý Sản Phẩm | Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Inter', sans-serif; background-color: #F0F2F5; color: #1B2838; min-height: 100vh; display: flex; flex-direction: column; }
    .navbar { background: linear-gradient(135deg, #1B2838, #0F1923); color: white; padding: 0 40px; display: flex; justify-content: space-between; align-items: center; height: 64px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); position: sticky; top: 0; z-index: 100; }
    .nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
    .nav-logo-text { font-size: 22px; font-weight: 800; background: linear-gradient(135deg, #FF6B35, #FF8C42); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
    .nav-links a { color: #8B9BB4; text-decoration: none; font-size: 14px; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: 0.3s; }
    .nav-links a:hover, .nav-links a.active { color: #fff; background: rgba(255, 107, 53, 0.1); }
    
    .container { max-width: 1200px; margin: 0 auto; padding: 32px 40px; width: 100%; flex: 1; }
    .header-section { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
    .header-section h2 { font-size: 20px; font-weight: 700; color: #1B2838; }
    .btn-add { background: linear-gradient(135deg, #00D67F, #00B86B); color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.3s; text-decoration: none; display: inline-block; }
    .btn-add:hover { transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,214,127,0.3); }
    
    /* Page Header */
    .page-header { background: linear-gradient(135deg, #1B2838 0%, #2A3F55 100%); padding: 32px 40px; position: relative; overflow: hidden; }
    .page-header::before { content: ''; position: absolute; top: -50%; right: -20%; width: 60%; height: 200%; background: repeating-linear-gradient(45deg, transparent, transparent 30px, rgba(255, 107, 53, 0.04) 30px, rgba(255, 107, 53, 0.04) 60px); }
    .header-inner { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; position: relative; z-index: 2; }
    .header-inner h1 { font-size: 24px; font-weight: 800; color: #fff; display: flex; align-items: center; gap: 10px; }
    .admin-badge { display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px; border-radius: 30px; font-size: 13px; font-weight: 700; background: rgba(255, 107, 53, 0.15); color: #FF6B35; border: 1px solid rgba(255, 107, 53, 0.3); }
    
    /* Footer */
    .footer { background: linear-gradient(135deg, #1B2838, #0F1923); padding: 24px 40px; text-align: center; margin-top: auto; }
    .footer p { color: #4A5E75; font-size: 13px; }
    .footer .brand { color: #FF6B35; font-weight: 700; }
    
    .msg { padding: 12px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; font-weight: 500; }
    .msg.success { background: rgba(0,214,127,0.1); color: #00A360; }
    .msg.error { background: rgba(255,71,87,0.1); color: #E02334; }
    
    .table-card { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; }
    table { width: 100%; border-collapse: collapse; }
    th { background: #1B2838; color: #fff; text-align: left; padding: 16px; font-size: 14px; text-transform: uppercase; }
    td { padding: 16px; border-bottom: 1px solid #E8ECF0; vertical-align: middle; font-size: 14px; }
    tr:last-child td { border-bottom: none; }
    
    .btn-action { padding: 6px 12px; border-radius: 6px; font-size: 12px; font-weight: 600; cursor: pointer; border: none; margin-right: 5px; }
    .btn-edit { background: rgba(255, 184, 48, 0.1); color: #D48E00; }
    .btn-edit:hover { background: #FFB830; color: #fff; }
    .btn-delete { background: rgba(255, 71, 87, 0.1); color: #FF4757; }
    .btn-delete:hover { background: #FF4757; color: #fff; }

    /* Modal styling */
    .modal { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); align-items: center; justify-content: center; z-index: 1000; }
    .modal-content { background: #fff; padding: 30px; border-radius: 12px; width: 400px; max-width: 90%; }
    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid #E8ECF0; padding-bottom: 10px; }
    .modal-title { font-size: 18px; font-weight: 700; color: #1B2838; }
    .close-btn { background: none; border: none; font-size: 20px; cursor: pointer; color: #8B9BB4; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-size: 13px; font-weight: 600; color: #4A5E75; margin-bottom: 8px; }
    .form-group input { width: 100%; padding: 10px; border: 1px solid #E8ECF0; border-radius: 6px; outline: none; font-family: 'Inter'; }
    .form-group input:focus { border-color: #FF6B35; }
    .btn-submit { background: #1B2838; color: white; border: none; padding: 12px; border-radius: 8px; font-weight: 600; cursor: pointer; width: 100%; margin-top: 10px; }
</style>
</head>
<body>
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="nav-logo">
            <span class="nav-logo-text">SportShop</span>
        </a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
            <a href="${pageContext.request.contextPath}/admin/analytics" style="color:#FFB830;">Thống kê</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="active" style="color:#FFB830;">Quản lý Sản Phẩm</a>
            <a href="${pageContext.request.contextPath}/profile">Tài khoản</a>
            <a href="${pageContext.request.contextPath}/login" style="color: #FF4757;">Đăng xuất</a>
        </div>
    </div>

    <!-- ===== PAGE HEADER ===== -->
    <div class="page-header">
        <div class="header-inner">
            <h1>Quản lý Sản Phẩm</h1>
            <span class="admin-badge">Quyền: ADMIN</span>
        </div>
    </div>

    <!-- ===== MAIN CONTENT ===== -->
    <div class="container">
        <div class="header-section">
            <h2>Danh sách sản phẩm</h2>
            <button class="btn-add" onclick="openModal('add', null)">+ Thêm sản phẩm mới</button>
        </div>

        <c:if test="${not empty sessionScope.msg}"><div class="msg success">${sessionScope.msg}</div><c:remove var="msg" scope="session"/></c:if>
        <c:if test="${not empty sessionScope.error}"><div class="msg error">${sessionScope.error}</div><c:remove var="error" scope="session"/></c:if>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>Mã SP</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Số lượng tồn</th>
                        <th>Đơn Giá</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${products}">
                        <tr>
                            <td><strong>${p.id}</strong></td>
                            <td>${p.tenSanPham}</td>
                            <td>${p.soLuongTon}</td>
                            <td style="color:#FF6B35; font-weight:600;"><fmt:formatNumber value="${p.gia}" type="number" groupingUsed="true" /> đ</td>
                            <td>
                                <button class="btn-action btn-edit" onclick="openModal('edit', {id: '${p.id}', name: '${p.tenSanPham}', qty: '${p.soLuongTon}', price: '${p.gia}'})">Sửa</button>
                                <form action="${pageContext.request.contextPath}/admin/products" method="POST" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit" class="btn-action btn-delete">Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty products}">
                        <tr><td colspan="5" style="text-align:center; padding: 20px;">Không có sản phẩm nào.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal Form -->
    <div id="productModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title" id="modalTitle">Thêm Sản Phẩm</div>
                <button class="close-btn" onclick="closeModal()">×</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/products" method="POST">
                <input type="hidden" name="action" id="formAction" value="add">
                
                <div class="form-group">
                    <label>Mã Sản Phẩm</label>
                    <input type="text" name="id" id="prodId" required>
                </div>
                <div class="form-group">
                    <label>Tên Sản Phẩm</label>
                    <input type="text" name="name" id="prodName" required>
                </div>
                <div class="form-group">
                    <label>Số lượng</label>
                    <input type="number" name="quantity" id="prodQty" min="0" required>
                </div>
                <div class="form-group">
                    <label>Giá (VNĐ)</label>
                    <input type="number" name="price" id="prodPrice" min="0" step="1000" required>
                </div>
                
                <button type="submit" class="btn-submit">Lưu Sản Phẩm</button>
            </form>
        </div>
    </div>

    <script>
        function openModal(mode, data) {
            document.getElementById('productModal').style.display = 'flex';
            if (mode === 'edit') {
                document.getElementById('modalTitle').innerText = 'Chỉnh sửa Sản Phẩm';
                document.getElementById('formAction').value = 'update';
                document.getElementById('prodId').value = data.id;
                document.getElementById('prodId').readOnly = true;
                document.getElementById('prodName').value = data.name;
                document.getElementById('prodQty').value = data.qty;
                document.getElementById('prodPrice').value = data.price;
            } else {
                document.getElementById('modalTitle').innerText = 'Thêm Sản Phẩm';
                document.getElementById('formAction').value = 'add';
                document.getElementById('prodId').value = '';
                document.getElementById('prodId').readOnly = false;
                document.getElementById('prodName').value = '';
                document.getElementById('prodQty').value = '';
                document.getElementById('prodPrice').value = '';
            }
        }

        function closeModal() {
            document.getElementById('productModal').style.display = 'none';
        }
    </script>

    <!-- ===== FOOTER ===== -->
    <div class="footer">
        <p>© 2026 <span class="brand">SportShop</span> — Hệ thống quản lý cửa hàng thể thao</p>
    </div>
</body>
</html>
