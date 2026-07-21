package controller;

import java.io.IOException;
import java.util.List;

import dao.SanPhamDAO;
import entity.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		// Fetch products from database
		SanPhamDAO dao = new SanPhamDAO();
		List<SanPham> list = dao.findAll();
		request.setAttribute("products", list);

		// Chuyển tiếp sang giao diện trang chủ
		request.getRequestDispatcher("/views/home.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}