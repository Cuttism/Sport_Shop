package controller;

import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		request.getRequestDispatcher("/views/register.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		String id = request.getParameter("id");
		String hoTen = request.getParameter("hoTen");
		String dienThoai = request.getParameter("dienThoai");
		String diaChi = request.getParameter("diaChi");

		// Validate
		if (id == null || id.trim().isEmpty() || !id.trim().startsWith("KH")) {
			request.setAttribute("error", "Mã tài khoản phải bắt đầu bằng 'KH' (Ví dụ: KH08).");
			request.getRequestDispatcher("/views/register.jsp").forward(request, response);
			return;
		}

		UserDAO dao = new UserDAO();
		
		// Check ID existence
		if (dao.checkIdExist(id)) {
			request.setAttribute("error", "Mã tài khoản đã tồn tại. Vui lòng chọn mã khác.");
			request.getRequestDispatcher("/views/register.jsp").forward(request, response);
			return;
		}

		// Register
		boolean success = dao.registerCustomer(id, hoTen, dienThoai, diaChi);

		if (success) {
			request.setAttribute("success", "Đăng ký thành công! Bạn có thể đăng nhập ngay.");
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		} else {
			request.setAttribute("error", "Có lỗi xảy ra trong quá trình đăng ký. Vui lòng thử lại.");
			request.getRequestDispatcher("/views/register.jsp").forward(request, response);
		}
	}
}
