package controller;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import dao.DonHangDAO;
import dao.UserDAO;
import entity.DonHangInfoDTO;
import entity.KhachHang;
import entity.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserSession user = (UserSession) session.getAttribute("currentUser");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDAO userDAO = new UserDAO();
        KhachHang kh = null;

        if ("CUSTOMER".equals(user.getRole())) {
            kh = userDAO.getCustomerById(user.getId());
            DonHangDAO dhDAO = new DonHangDAO();
            List<DonHangInfoDTO> allOrders = dhDAO.getDonHangInfo();
            List<DonHangInfoDTO> userOrders = allOrders.stream()
                    .filter(o -> o.getTenKhachHang() != null && o.getTenKhachHang().equals(user.getHoTen()))
                    .collect(Collectors.toList());
            request.setAttribute("orders", userOrders);
        } else {
            kh = new KhachHang();
            kh.setId(user.getId());
            kh.setHoTen(user.getHoTen());
            kh.setMatKhau(userDAO.getPasswordById(user.getId()));
            // For admin/staff, we don't display orders
            request.setAttribute("orders", java.util.Collections.emptyList());
        }

        request.setAttribute("customerInfo", kh);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        UserSession user = (UserSession) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String hoTen = request.getParameter("hoTen");
        String dienThoai = request.getParameter("dienThoai");
        String diaChi = request.getParameter("diaChi");
        String email = request.getParameter("email");
        String ngaySinhStr = request.getParameter("ngaySinh");
        String gioiTinh = request.getParameter("gioiTinh");
        String matKhau = request.getParameter("matKhau");

        java.sql.Date ngaySinh = null;
        if (ngaySinhStr != null && !ngaySinhStr.trim().isEmpty()) {
            try {
                ngaySinh = java.sql.Date.valueOf(ngaySinhStr);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        UserDAO userDAO = new UserDAO();
        boolean success = false;
        
        if ("CUSTOMER".equals(user.getRole())) {
            success = userDAO.updateCustomer(user.getId(), hoTen, dienThoai, diaChi, email, ngaySinh, gioiTinh, matKhau);
        } else {
            success = userDAO.updateGenericUser(user.getId(), hoTen, matKhau);
        }
        
        if (success) {
            user.setHoTen(hoTen);
            session.setAttribute("currentUser", user);
            request.getSession().setAttribute("msg", "Cập nhật hồ sơ thành công!");
        } else {
            request.getSession().setAttribute("error", "Lỗi cập nhật hồ sơ!");
        }
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
