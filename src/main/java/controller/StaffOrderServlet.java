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

        DonHangDAO dao = new DonHangDAO();
        List<DonHangInfoDTO> orders = dao.getDonHangInfo();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/views/staff-orders.jsp").forward(request, response);
    }
}
