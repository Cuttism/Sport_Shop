package controller;

import java.io.IOException;

import dao.AnalyticsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/analytics")
public class AnalyticsServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Thiết lập mã hóa tiếng Việt
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// Gọi AnalyticsDAO để lấy số liệu thống kê thật từ Database
		AnalyticsDAO dao = new AnalyticsDAO();
		request.setAttribute("totalRevenue", dao.getTotalRevenue());
		request.setAttribute("totalOrders", dao.getTotalOrders());
		request.setAttribute("totalCustomers", dao.getTotalCustomers());
		request.setAttribute("totalProducts", dao.getTotalProducts());
		request.setAttribute("totalBills", dao.getTotalBills());
		request.setAttribute("pendingOrders", dao.getPendingOrders());

		// Chuyển tiếp sang giao diện thống kê doanh thu
		request.getRequestDispatcher("/views/analytics.jsp").forward(request, response);
	}
}
