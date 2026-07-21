package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import dao.SanPhamDAO;
import entity.CartItem;
import entity.SanPham;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action)) {
            String productId = request.getParameter("id");
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getProduct().getId().equals(productId)) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
            if (!found) {
                SanPhamDAO dao = new SanPhamDAO();
                SanPham sp = dao.findById(productId);
                if (sp != null) {
                    cart.add(new CartItem(sp, 1));
                }
            }
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        } else if ("remove".equals(action)) {
            String productId = request.getParameter("id");
            cart.removeIf(item -> item.getProduct().getId().equals(productId));
            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        } else if ("view".equals(action)) {
            double total = 0;
            for (CartItem item : cart) {
                total += item.getSubtotal();
            }
            request.setAttribute("total", total);
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                String productId = request.getParameter("id");
                try {
                    int qty = Integer.parseInt(request.getParameter("quantity"));
                    for (CartItem item : cart) {
                        if (item.getProduct().getId().equals(productId)) {
                            if (qty > 0) {
                                item.setQuantity(qty);
                            } else {
                                cart.remove(item);
                            }
                            break;
                        }
                    }
                } catch (NumberFormatException e) {
                    // ignore
                }
                session.setAttribute("cart", cart);
            }
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
