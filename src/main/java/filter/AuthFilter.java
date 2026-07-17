package filter;

import java.io.IOException;

import entity.UserSession;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "AuthFilter", urlPatterns = { "/admin/*", "/staff/*", "/account/*", "/checkout/*" })
public class AuthFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);

		// 1. Kiểm tra đăng nhập
		UserSession user = (session != null) ? (UserSession) session.getAttribute("currentUser") : null;
		String uri = req.getRequestURI();

		if (user == null) {
			// Chưa đăng nhập -> đá về trang login kèm thông báo
			req.setAttribute("error", "Vui lòng đăng nhập để tiếp tục!");
			req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
			return;
		}

		// 2. Kiểm tra phân quyền dựa trên URI đường dẫn
		String role = user.getRole();

		if (uri.contains("/admin/") && !role.equals("ADMIN")) {
			// Không phải Admin mà đòi vào vùng admin
			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập vào chức năng này.");
			return;
		}

		if (uri.contains("/staff/") && !role.equals("STAFF") && !role.equals("ADMIN")) {
			resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập.");
			return;
		}

		// Hợp lệ thì cho đi tiếp tới Servlet/JSP tương ứng
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}
}