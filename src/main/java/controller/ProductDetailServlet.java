package controller;

import java.io.IOException;
import java.util.List;

import dao.ReviewDAO;
import dao.SanPhamDAO;
import entity.Review;
import entity.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        SanPhamDAO spDAO = new SanPhamDAO();
        SanPham product = spDAO.findById(id);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        ReviewDAO reviewDAO = new ReviewDAO();
        List<Review> reviews = reviewDAO.findByProductId(id);
        
        double avgRating = 0;
        if (!reviews.isEmpty()) {
            double sum = 0;
            for (Review r : reviews) sum += r.getSoSao();
            avgRating = sum / reviews.size();
        }

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);
        request.setAttribute("avgRating", avgRating);
        request.getRequestDispatcher("/views/product_detail.jsp").forward(request, response);
    }
}
