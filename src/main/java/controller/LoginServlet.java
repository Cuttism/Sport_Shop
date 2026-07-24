package controller;

import java.io.IOException;

import dao.UserDAO;
import entity.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	// 1. Phương thức GET: Hiển thị form đăng nhập khi truy cập
	// http://localhost:8080/PolyCoffee/login
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Cấu hình tiếng Việt cho request/response phòng hờ
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		request.getRequestDispatcher("/views/login.jsp").forward(request, response);
	}

	// 2. Phương thức POST: Xử lý đăng nhập bằng dữ liệu từ Database
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Bắt buộc thêm 2 dòng này đầu hàm doPost để không bị lỗi font tiếng Việt khi
		// báo lỗi
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// Lấy ID nhập vào từ thẻ <input name="username"> trong file login.jsp
		String idInput = request.getParameter("username");
		String passwordInput = request.getParameter("password");

		// Gọi UserDAO để tìm người dùng từ Database thật
		UserDAO userDAO = new UserDAO();
		UserSession user = userDAO.login(idInput, passwordInput);

		// Xử lý điều hướng hoặc báo lỗi
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("currentUser", user); // Lưu vào session cho AuthFilter kiểm tra

			// Điều hướng dựa theo vai trò (Redirect sang các URL tương ứng)
			if (user.getRole().equals("ADMIN")) {
				response.sendRedirect(request.getContextPath() + "/admin/analytics");
			} else if (user.getRole().equals("STAFF")) {
				response.sendRedirect(request.getContextPath() + "/staff/orders");
			} else {
				response.sendRedirect(request.getContextPath() + "/home");
			}
		} else {
			// Gửi thông báo lỗi quay ngược lại trang login.jsp
			request.setAttribute("error", "Tài khoản không tồn tại hoặc không hợp lệ!");
			request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		}
	}
}