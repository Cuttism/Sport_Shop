package controller;

import java.io.IOException;
import java.util.List;

import dao.SanPhamDAO;
import entity.SanPham;
import entity.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SanPhamDAO sanPhamDAO;

    @Override
    public void init() throws ServletException {
        sanPhamDAO = new SanPhamDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserSession currentUser = (UserSession) session.getAttribute("currentUser");

        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            session.setAttribute("error", "Bạn không có quyền truy cập trang này.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<SanPham> products = sanPhamDAO.findAll();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/views/admin-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserSession currentUser = (UserSession) session.getAttribute("currentUser");

        if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "";

        try {
            switch (action) {
                case "add": {
                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    int qty = Integer.parseInt(request.getParameter("quantity"));
                    double price = Double.parseDouble(request.getParameter("price"));

                    SanPham sp = new SanPham();
                    sp.setId(id);
                    sp.setTenSanPham(name);
                    sp.setSoLuongTon(qty);
                    sp.setGia(price);

                    if (sanPhamDAO.findById(id) != null) {
                        session.setAttribute("error", "Mã sản phẩm đã tồn tại.");
                    } else if (sanPhamDAO.insert(sp)) {
                        session.setAttribute("msg", "Thêm sản phẩm thành công!");
                    } else {
                        session.setAttribute("error", "Thêm thất bại!");
                    }
                    break;
                }
                case "update": {
                    String id = request.getParameter("id");
                    String name = request.getParameter("name");
                    int qty = Integer.parseInt(request.getParameter("quantity"));
                    double price = Double.parseDouble(request.getParameter("price"));

                    SanPham sp = new SanPham();
                    sp.setId(id);
                    sp.setTenSanPham(name);
                    sp.setSoLuongTon(qty);
                    sp.setGia(price);

                    if (sanPhamDAO.update(sp)) {
                        session.setAttribute("msg", "Cập nhật sản phẩm thành công!");
                    } else {
                        session.setAttribute("error", "Cập nhật thất bại!");
                    }
                    break;
                }
                case "delete": {
                    String id = request.getParameter("id");
                    if (sanPhamDAO.delete(id)) {
                        session.setAttribute("msg", "Xóa sản phẩm thành công!");
                    } else {
                        session.setAttribute("error", "Xóa thất bại! Sản phẩm có thể đang nằm trong đơn hàng.");
                    }
                    break;
                }
            }
        } catch (Exception e) {
            session.setAttribute("error", "Đã có lỗi xảy ra: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/products");
    }
}
