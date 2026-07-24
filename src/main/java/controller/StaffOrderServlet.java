package controller;

import java.io.IOException;
import java.util.List;

import dao.DonHangDAO;
import entity.DonHangInfoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/staff/orders")
public class StaffOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        DonHangDAO dao = new DonHangDAO();

        if ("details".equals(action)) {
            String orderId = request.getParameter("orderId");
            List<entity.OrderDetailDTO> details = dao.getOrderDetails(orderId);
            request.setAttribute("details", details);
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/views/staff-order-details.jsp").forward(request, response);
            return;
        }

        List<DonHangInfoDTO> orders = dao.getDonHangInfo();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/views/staff-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            String orderId = request.getParameter("orderId");
            String status = request.getParameter("status");
            
            if (orderId != null && status != null) {
                DonHangDAO dao = new DonHangDAO();
                dao.updateOrderStatus(orderId, status);
            }
        }
        response.sendRedirect(request.getContextPath() + "/staff/orders");
    }
}
