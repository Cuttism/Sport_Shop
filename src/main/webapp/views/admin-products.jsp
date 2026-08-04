<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Quản Lý Sản Phẩm | SportShop</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <style>
    body { background: var(--bg-deep); }

    /* Hover & Click effect cho Stat Cards */
    .stat-card-clickable {
      cursor: pointer;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
      text-decoration: none;
      display: block;
    }
    .stat-card-clickable:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-md);
    }
    .stat-card.active-filter {
      border: 2px solid var(--primary) !important;
    }

    /* ===== CATEGORY STRIP STYLES ===== */
    .category-strip {
      background: var(--bg-card);
      border: 1px solid var(--border);
      border-radius: var(--radius-lg);
      padding: 4px;
      margin-bottom: var(--space-lg);
    }
    .category-strip-inner {
      display: flex;
      align-items: center;
      gap: 6px;
      overflow-x: auto;
      scrollbar-width: none;
    }
    .category-strip-inner::-webkit-scrollbar { display: none; }

    .category-pill {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 8px 16px;
      font-size: 13px;
      font-weight: 600;
      color: var(--text-muted);
      cursor: pointer;
      white-space: nowrap;
      border-radius: var(--radius-md);
      transition: var(--transition-fast);
      text-decoration: none;
      border: 1px solid transparent;
    }
    .category-pill i { font-size: 14px; }
    .category-pill:hover {
      color: var(--text-primary);
      background: rgba(255, 255, 255, 0.05);
    }
    .category-pill.active {
      color: #fff;
      background: var(--primary);
      border-color: var(--primary);
    }

    /* Modal */
    .modal { display: none; position: fixed; inset: 0; background: rgba(0,0,0,0.7); align-items: center; justify-content: center; z-index: 2000; backdrop-filter: blur(4px); }
    .modal.open { display: flex; }
    .modal-box { background: var(--bg-navy); border: 1px solid var(--border-light); border-radius: var(--radius-xl); padding: var(--space-xl); width: 440px; max-width: 95vw; box-shadow: var(--shadow-lg); animation: modalIn 0.25s ease-out; }
    @keyframes modalIn { from { opacity: 0; transform: scale(0.95) translateY(-16px); } to { opacity: 1; transform: scale(1) translateY(0); } }
    .modal-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--space-xl); padding-bottom: var(--space-md); border-bottom: 1px solid var(--border); }
    .modal-title { font-family: var(--font-display); font-size: 22px; letter-spacing: 1px; color: var(--text-primary); }
    .modal-close { width: 32px; height: 32px; border-radius: var(--radius-md); background: rgba(255,255,255,0.06); border: 1px solid var(--border); color: var(--text-muted); font-size: 18px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: var(--transition-fast); line-height: 1; }
    .modal-close:hover { background: rgba(255,71,87,0.15); color: var(--danger); }
    .modal-fields { display: flex; flex-direction: column; gap: var(--space-md); }

    .search-wrap { display: flex; align-items: center; gap: var(--space-sm); }
    .search-input-wrap { position: relative; display: flex; align-items: center; }
    .search-input-wrap i { position: absolute; left: 12px; color: var(--text-muted); font-size: 14px; }
    .search-input-wrap input { padding-left: 36px; height: 36px; border-radius: var(--radius-md); }
  </style>
</head>
<body>
<div class="admin-layout">

  <!-- SIDEBAR -->
  <aside class="sidebar">
    <div class="sidebar-logo">
      <div class="wordmark">SportShop</div>
      <span class="role-badge ${sessionScope.currentUser.role == 'ADMIN' ? 'admin' : 'staff'}">
        ${sessionScope.currentUser.role == 'ADMIN' ? 'Quản Trị Viên' : 'Nhân Viên'}
      </span>
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
      <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/analytics" class="sidebar-link">
          <i class="fa-solid fa-chart-line"></i> Thống Kê & Báo Cáo
        </a>
      </c:if>
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
        <span class="badge ${sessionScope.currentUser.role == 'ADMIN' ? 'badge-warning' : 'badge-info'}">
          <i class="fa-solid ${sessionScope.currentUser.role == 'ADMIN' ? 'fa-shield-halved' : 'fa-user-gear'}"></i> 
          ${sessionScope.currentUser.role}
        </span>
        
        <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
          <button class="btn btn-primary btn-md" onclick="openModal('add', null)">
            <i class="fa-solid fa-plus"></i> Thêm Sản Phẩm
          </button>
        </c:if>
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

      <!-- STAT CARDS (CLICK ĐỂ LỌC TRỰC TIẾP DƯỚI BẢNG) -->
      <div class="stat-cards" style="margin-bottom:var(--space-xl);">
        <!-- Tất cả sản phẩm -->
        <a href="${pageContext.request.contextPath}/admin/products" class="stat-card-clickable">
          <div class="stat-card ${empty filter ? 'active-filter' : ''}" style="--stat-color:var(--primary); --stat-bg:rgba(255,107,53,0.1);">
            <div class="stat-card-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
            <div class="stat-card-value">${allProducts.size()}</div>
            <div class="stat-card-label">Tổng Sản Phẩm (Tất cả)</div>
          </div>
        </a>

        <!-- Còn hàng -->
        <a href="${pageContext.request.contextPath}/admin/products?filter=inStock" class="stat-card-clickable">
          <div class="stat-card ${filter == 'inStock' ? 'active-filter' : ''}" style="--stat-color:var(--success); --stat-bg:rgba(0,214,127,0.1);">
            <div class="stat-card-icon"><i class="fa-solid fa-check-circle"></i></div>
            <div class="stat-card-value">
              <c:set var="inStockCount" value="0"/>
              <c:forEach var="p" items="${allProducts}">
                <c:if test="${p.soLuongTon > 20}"><c:set var="inStockCount" value="${inStockCount + 1}"/></c:if>
              </c:forEach>
              ${inStockCount}
            </div>
            <div class="stat-card-label">Còn Hàng Dồi Dào</div>
          </div>
        </a>

        <!-- SẮP HẾT HÀNG -->
        <a href="${pageContext.request.contextPath}/admin/products?filter=lowStock" class="stat-card-clickable">
          <div class="stat-card ${filter == 'lowStock' ? 'active-filter' : ''}" style="--stat-color:var(--warning); --stat-bg:rgba(255,184,48,0.1);">
            <div class="stat-card-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div class="stat-card-value">
              <c:set var="lowStockCount" value="0"/>
              <c:forEach var="p" items="${allProducts}">
                <c:if test="${p.soLuongTon <= 20}"><c:set var="lowStockCount" value="${lowStockCount + 1}"/></c:if>
              </c:forEach>
              ${lowStockCount}
            </div>
            <div class="stat-card-label">Sắp Hết Hàng (Cần nhập)</div>
          </div>
        </a>
      </div>

      <!-- ===== CATEGORY STRIP ===== -->
      <div class="category-strip">
        <div class="category-strip-inner">
          <a href="${pageContext.request.contextPath}/admin/products" 
             class="category-pill ${empty keyword ? 'active' : ''}">
            <i class="fa-solid fa-th-large"></i> Tất Cả Sản Phẩm
          </a>
          <a href="${pageContext.request.contextPath}/admin/products?keyword=Giày" 
             class="category-pill ${keyword == 'Giày' ? 'active' : ''}">
            <i class="fa-solid fa-shoe-prints"></i> Giày Thể Thao
          </a>
          <a href="${pageContext.request.contextPath}/admin/products?keyword=Áo" 
             class="category-pill ${keyword == 'Áo' ? 'active' : ''}">
            <i class="fa-solid fa-shirt"></i> Áo Thể Thao
          </a>
          <a href="${pageContext.request.contextPath}/admin/products?keyword=Quần" 
             class="category-pill ${keyword == 'Quần' ? 'active' : ''}">
            <i class="fa-solid fa-shorts"></i> Quần Thể Thao
          </a>
          <a href="${pageContext.request.contextPath}/admin/products?keyword=Vợt" 
             class="category-pill ${keyword == 'Vợt' ? 'active' : ''}">
            <i class="fa-solid fa-table-tennis-paddle-ball"></i> Dụng Cụ Vợt
          </a>
          <a href="${pageContext.request.contextPath}/admin/products?keyword=Bóng" 
             class="category-pill ${keyword == 'Bóng' ? 'active' : ''}">
            <i class="fa-solid fa-basketball"></i> Các Loại Bóng
          </a>
        </div>
      </div>

      <!-- Product Table Wrap -->
      <div class="data-table-wrap">
        <div style="padding:var(--space-md) var(--space-lg); border-bottom:1px solid var(--border); display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:var(--space-md);">
          <div>
            <div style="font-size:15px; font-weight:600; color:var(--text-secondary);">
              Danh Sách Sản Phẩm 
              <c:if test="${filter == 'lowStock'}"><span style="color:var(--warning); font-size:13px;">(Đang lọc: Sắp hết hàng)</span></c:if>
              <c:if test="${not empty keyword}"><span style="color:var(--primary); font-size:13px;">(Từ khóa: "${keyword}")</span></c:if>
            </div>
          </div>
          
          <!-- Thanh tìm kiếm -->
          <form action="${pageContext.request.contextPath}/admin/products" method="GET" class="search-wrap">
            <c:if test="${not empty filter}">
              <input type="hidden" name="filter" value="${filter}">
            </c:if>
            <div class="search-input-wrap">
              <i class="fa-solid fa-magnifying-glass"></i>
              <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm tên sản phẩm...">
            </div>
            <button type="submit" class="btn btn-primary btn-sm">Tìm</button>
            <c:if test="${not empty keyword || not empty filter}">
              <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary btn-sm" style="color:var(--danger);">Xóa lọc</a>
            </c:if>
          </form>
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
                    <c:when test="${p.soLuongTon == 0}">
                      <span class="badge badge-error"><i class="fa-solid fa-circle-xmark"></i> Hết hàng</span>
                    </c:when>
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
                    
                    <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                      <form action="${pageContext.request.contextPath}/admin/products" method="POST" style="display:inline;"
                            onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm ${p.tenSanPham}?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="id" value="${p.id}">
                        <button type="submit" class="btn btn-danger btn-sm">
                          <i class="fa-solid fa-trash-can"></i> Xóa
                        </button>
                      </form>
                    </c:if>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty products}">
              <tr>
                <td colspan="5" style="text-align:center; padding:var(--space-2xl); color:var(--text-faint);">
                  Không tìm thấy sản phẩm nào khớp với bộ lọc!
                </td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</div>

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
            <input type="text" name="name" id="prodName" class="form-control" required placeholder="Nhập tên sản phẩm..."
                   ${sessionScope.currentUser.role != 'ADMIN' ? 'readonly style="opacity:0.6;"' : ''}>
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
            <input type="number" name="price" id="prodPrice" class="form-control" min="0" step="1000" required placeholder="0"
                   ${sessionScope.currentUser.role != 'ADMIN' ? 'readonly style="opacity:0.6;"' : ''}>
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

  document.getElementById('productModal').addEventListener('click', function(e) {
    if (e.target === this) closeModal();
  });
</script>
</body>
</html>