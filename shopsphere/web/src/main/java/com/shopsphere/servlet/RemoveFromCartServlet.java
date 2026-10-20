package com.shopsphere.servlet;

import java.io.IOException;

import com.shopsphere.dao.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));

        CartDAO cartDAO = new CartDAO();
        cartDAO.removeFromCart(cartId);

        response.sendRedirect("cart.jsp");
    }
}