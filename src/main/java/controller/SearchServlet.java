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

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        SanPhamDAO dao = new SanPhamDAO();
        
        List<SanPham> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.searchByName(keyword.trim());
        } else {
            list = dao.findAll();
        }

        request.setAttribute("products", list);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/views/home.jsp").forward(request, response);
    }
}
