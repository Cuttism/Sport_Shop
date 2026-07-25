<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Sản Phẩm | SportShop Admin</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <style>
    body { background: var(--bg-deep); }

    /* Modal */
    .modal {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0,0,0,0.7);
      align-items: center;
      justify-content: center;
      z-index: 2000;
      backdrop-filter: blur(4px);
    }
    .modal.open { display: flex; }

    .modal-box {
      background: var(--bg-navy);
      border: 1px solid var(--border-light);
      border-radius: var(--radius-xl);
      padding: var(--space-xl);
      width: 440px;
      max-width: 95vw;
      box-shadow: var(--shadow-lg);
      animation: modalIn 0.25s ease-out;
    }

    @keyframes modalIn {
      from { opacity: 0; transform: scale(0.95) translateY(-16px); }
      to   { opacity: 1; transform: scale(1) translateY(0); }
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: var(--space-xl);
      padding-bottom: var(--space-md);
      border-bottom: 1px solid var(--border);
    }

    .modal-title {
      font-family: var(--font-display);
      font-size: 22px;
      letter-spacing: 1px;
      color: var(--text-primary);
    }

    .modal-close {
      width: 32px;
      height: 32px;
      border-radius: var(--radius-md);
      background: rgba(255,255,255,0.06);
      border: 1px solid var(--border);
      color: var(--text-muted);
      font-size: 18px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: var(--transition-fast);
      line-height: 1;
    }

    .modal-close:hover { background: rgba(255,71,87,0.15); color: var(--danger); }

    .modal-fields { display: flex; flex-direction: column; gap: var(--space-md); }

    .stock-badge {
      display: inline-block;
      font-size: 12px;
      font-weight: 700;
      padding: 3px 10px;
      border-radius: var(--radius-full);
    }
  </style>
</head>
<body>
<div class="admin-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="wordmark">SportShop</div>
      <span class="role-badge admin">Quản Trị Viên</span>
    </div>

    <div class="sidebar-user">
      <div class="sidebar-user-avatar">${sessionScope.currentUser.hoTen.substring(0,1)}</div>
      <div>
        <div class="sidebar-user-name">${sessionScope.currentUser.hoTen}</div>
        <div class="sidebar-user-id">${sessionScope.currentUser.id}</div>
      </div>
    </div>

    <nav class="sidebar-nav">
      <div class="sidebar-section-label">Quản Trị</div>
      <a href="${pageContext.request.contextPath}/admin/analytics" class="sidebar-link">
        <i class="fa-solid fa-chart-line"></i> Thống Kê & Báo Cáo
      </a>
      <a href="${pageContext.request.contextPath}/admin/products" class="sidebar-link active">
        <i class="fa-solid fa-box-open"></i> Quản Lý Sản Phẩm
      </a>

      <div class="sidebar-section-label" style="margin-top:var(--space-md);">Cửa Hàng</div>
      <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
        <i class="fa-solid fa-house"></i> Về Trang Chủ
      </a>
      <a href="${pageContext.request.contextPath}/staff/orders" class="sidebar-link">
        <i class="fa-solid fa-clipboard-list"></i> Xem Đơn Hàng
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="${pageContext.request.contextPath}/login">
        <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng Xuất
      </a>
    </div>
  </aside>

  <!-- MAIN CONTENT -->
  <div class="admin-main">
    <div class="admin-topbar">
      <h1>Quản Lý Sản Phẩm</h1>
      <div style="display:flex; align-items:center; gap:var(--space-md);">
        <span class="badge badge-warning"><i class="fa-solid fa-shield-halved"></i> ADMIN</span>
        <button class="btn btn-primary btn-md" onclick="openModal('add', null)">
          <i class="fa-solid fa-plus"></i> Thêm Sản Phẩm
        </button>
      </div>
    </div>

    <div class="admin-content">
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

      <!-- Stats row -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <div class="stat-card" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
          <div class="stat-card-value">${products.size()}</div>
          <div class="stat-card-label">Tổng Sản Phẩm</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-check-circle"></i></div>
          <div class="stat-card-value">
            <c:set var="inStock" value="0"/>
            <c:forEach var="p" items="${products}">
              <c:if test="${p.soLuongTon > 20}"><c:set var="inStock" value="${inStock + 1}"/></c:if>
            </c:forEach>
            ${inStock}
          </div>
          <div class="stat-card-label">Còn Hàng</div>
        </div>
        <div class="stat-card" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
          <div class="stat-card-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
          <div class="stat-card-value">
            <c:set var="lowStock" value="0"/>
            <c:forEach var="p" items="${products}">
              <c:if test="${p.soLuongTon <= 20}"><c:set var="lowStock" value="${lowStock + 1}"/></c:if>
            </c:forEach>
            ${lowStock}
          </div>
          <div class="stat-card-label">Sắp Hết Hàng</div>
        </div>
      </div>

      <!-- Product Table -->
      <div class="data-table-wrap">
        <div style="padding:var(--space-md) var(--space-lg); border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between;">
          <div style="font-size:15px; font-weight:600; color:var(--text-secondary);">Danh Sách Sản Phẩm</div>
          <span class="badge badge-neutral">${products.size()} sản phẩm</span>
        </div>
        <table class="data-table">
          <thead>
            <tr>
              <th>Mã SP</th>
              <th>Tên Sản Phẩm</th>
              <th>Tồn Kho</th>
              <th>Đơn Giá</th>
              <th>Thao Tác</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="p" items="${products}">
              <tr>
                <td><strong style="color:var(--primary); font-family:monospace;">${p.id}</strong></td>
                <td style="color:var(--text-secondary); font-weight:500;">${p.tenSanPham}</td>
                <td>
                  <c:choose>
                    <c:when test="${p.soLuongTon <= 20}">
                      <span class="badge badge-warning"><i class="fa-solid fa-triangle-exclamation"></i> ${p.soLuongTon} còn lại</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge badge-success"><i class="fa-solid fa-circle-check"></i> ${p.soLuongTon}</span>
                    </c:otherwise>
                  </c:choose>
                </td>
                <td style="color:var(--primary); font-weight:700; font-family:var(--font-display); font-size:16px;">
                  <fmt:formatNumber value="${p.gia}" type="number" groupingUsed="true"/> đ
                </td>
                <td>
                  <div style="display:flex; gap:var(--space-sm);">
                    <button class="btn btn-sm" style="background:rgba(255,184,48,0.1);color:var(--accent);border:1px solid rgba(255,184,48,0.3);"
                            onclick="openModal('edit', {id: '${p.id}', name: '${p.tenSanPham}', qty: '${p.soLuongTon}', price: '${p.gia}'})">
                      <i class="fa-solid fa-pen-to-square"></i> Sửa
                    </button>
                    <form action="${pageContext.request.contextPath}/admin/products" method="POST" style="display:inline;"
                          onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm ${p.tenSanPham}?');">
                      <input type="hidden" name="action" value="delete">
                      <input type="hidden" name="id" value="${p.id}">
                      <button type="submit" class="btn btn-danger btn-sm">
                        <i class="fa-solid fa-trash-can"></i> Xóa
                      </button>
                    </form>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty products}">
              <tr>
                <td colspan="5" style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
                  Chưa có sản phẩm nào trong hệ thống.
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div><!-- end .admin-main -->

</div><!-- end .admin-layout -->

<!-- MODAL -->
<div id="productModal" class="modal">
  <div class="modal-box">
    <div class="modal-header">
      <div class="modal-title" id="modalTitle">Thêm Sản Phẩm</div>
      <button class="modal-close" onclick="closeModal()">&times;</button>
    </div>
    <form action="${pageContext.request.contextPath}/admin/products" method="POST">
      <input type="hidden" name="action" id="formAction" value="add">
      <div class="modal-fields">
        <div class="form-group">
          <label class="form-label">Mã Sản Phẩm</label>
          <div class="input-group">
            <input type="text" name="id" id="prodId" class="form-control" required placeholder="VD: SP11">
            <i class="fa-solid fa-hashtag input-group-icon"></i>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Tên Sản Phẩm</label>
          <div class="input-group">
            <input type="text" name="name" id="prodName" class="form-control" required placeholder="Nhập tên sản phẩm...">
            <i class="fa-solid fa-tag input-group-icon"></i>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Số Lượng Tồn Kho</label>
          <div class="input-group">
            <input type="number" name="quantity" id="prodQty" class="form-control" min="0" required placeholder="0">
            <i class="fa-solid fa-boxes-stacked input-group-icon"></i>
          </div>
        </div>
        <div class="form-group">
          <label class="form-label">Giá (VNĐ)</label>
          <div class="input-group">
            <input type="number" name="price" id="prodPrice" class="form-control" min="0" step="1000" required placeholder="0">
            <i class="fa-solid fa-dong-sign input-group-icon"></i>
          </div>
        </div>
        <div style="margin-top:var(--space-sm); display:flex; gap:var(--space-md);">
          <button type="submit" class="btn btn-primary btn-full btn-md">
            <i class="fa-solid fa-floppy-disk"></i> Lưu Sản Phẩm
          </button>
          <button type="button" class="btn btn-secondary btn-md" onclick="closeModal()" style="flex-shrink:0;">
            Hủy
          </button>
        </div>
      </div>
    </form>
  </div>
</div>

<script>
  function openModal(mode, data) {
    const modal = document.getElementById('productModal');
    modal.classList.add('open');
    if (mode === 'edit') {
      document.getElementById('modalTitle').innerText = 'Chỉnh Sửa Sản Phẩm';
      document.getElementById('formAction').value = 'update';
      document.getElementById('prodId').value = data.id;
      document.getElementById('prodId').readOnly = true;
      document.getElementById('prodId').style.opacity = '0.5';
      document.getElementById('prodName').value = data.name;
      document.getElementById('prodQty').value = data.qty;
      document.getElementById('prodPrice').value = data.price;
    } else {
      document.getElementById('modalTitle').innerText = 'Thêm Sản Phẩm Mới';
      document.getElementById('formAction').value = 'add';
      document.getElementById('prodId').value = '';
      document.getElementById('prodId').readOnly = false;
      document.getElementById('prodId').style.opacity = '1';
      document.getElementById('prodName').value = '';
      document.getElementById('prodQty').value = '';
      document.getElementById('prodPrice').value = '';
    }
  }

  function closeModal() {
    document.getElementById('productModal').classList.remove('open');
  }

  // Close modal clicking outside
  document.getElementById('productModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
  });
</script>
</body>
</html>
