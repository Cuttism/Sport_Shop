package controller;

import java.io.IOException;

import dao.ReviewDAO;
import entity.UserSession;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/product/review")
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        UserSession user = (UserSession) session.getAttribute("currentUser");

        String productId = request.getParameter("productId");
        
        if (user == null || !"CUSTOMER".equals(user.getRole())) {
            request.getSession().setAttribute("errorReview", "Bạn phải đăng nhập với tư cách khách hàng để đánh giá!");
            response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            return;
        }

        try {
            int soSao = Integer.parseInt(request.getParameter("soSao"));
            String noiDung = request.getParameter("noiDung");

            ReviewDAO dao = new ReviewDAO();
            boolean success = dao.insertReview(productId, user.getId(), soSao, noiDung);

            if (success) {
                request.getSession().setAttribute("msgReview", "Cảm ơn bạn đã đánh giá sản phẩm!");
            } else {
                request.getSession().setAttribute("errorReview", "Có lỗi xảy ra, vui lòng thử lại.");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("errorReview", "Dữ liệu không hợp lệ.");
        }

        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }
}
