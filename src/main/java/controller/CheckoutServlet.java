package controller;

import java.io.IOException;
import java.util.List;

import dao.DonHangDAO;
import entity.CartItem;
import entity.DonHang;
import entity.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserSession user = (UserSession) session.getAttribute("currentUser");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
        request.setAttribute("total", total);

        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserSession user = (UserSession) session.getAttribute("currentUser");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (user == null || cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        // Có thể lấy thêm diaChiGiaoHang, sdt ở đây nếu cần

        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }

        // Tạo Entity DonHang
        DonHang dh = new DonHang();
        String orderId = "DH" + System.currentTimeMillis();
        dh.setId(orderId);
        dh.setCustomerId(user.getId());
        dh.setSalesStaffId("NVBH01"); // Gán tạm 1 NVBH mặc định quản lý
        dh.setWarehouseStaffId("NVK01"); // Gán tạm 1 NVK mặc định
        dh.setTrangThai("Chờ xử lý");
        dh.setTongTien(total);

        // Lưu xuống DB
        DonHangDAO dao = new DonHangDAO();
        boolean success = dao.insertOrder(dh, cart);

        if (success) {
            // Xóa giỏ hàng
            session.removeAttribute("cart");
            request.setAttribute("successMessage", "Đặt hàng thành công! Mã đơn hàng của bạn là: " + orderId);
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi đặt hàng. Vui lòng thử lại!");
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
        }
    }
}
