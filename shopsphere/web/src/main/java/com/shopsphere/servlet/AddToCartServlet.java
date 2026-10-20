package com.shopsphere.servlet;

import java.io.IOException;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp?msg=login_required");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 1;

        CartDAO cartDAO = new CartDAO();
        boolean added = cartDAO.addToCart(loggedInUser.getUserId(), productId, quantity);

        if (added) {
            response.sendRedirect("cart.jsp");
        } else {
            response.sendRedirect("products.jsp?error=cart_failed");
        }
    }
}