package com.shopsphere.servlet;

import java.io.IOException;
import java.util.List;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.Cart;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User loggedInUser = (User) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String addressLine = request.getParameter("addressLine");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String paymentMethod = request.getParameter("paymentMethod");

        CartDAO cartDAO = new CartDAO();
        List<Cart> cartList = cartDAO.getCartByUserId(loggedInUser.getUserId());

        if (cartList == null || cartList.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        double subtotal = 0;
        for (Cart c : cartList) {
            subtotal += (c.getPrice() * c.getQuantity());
        }
        double totalAmount = subtotal + 99.0; // Including Shipping

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.placeOrder(loggedInUser.getUserId(), addressLine, city, state, pincode, totalAmount,
                paymentMethod, cartList);

        if (orderId > 0) {
            response.sendRedirect("order_success.jsp?orderId=" + orderId);
        } else {
            response.sendRedirect("checkout.jsp?error=failed");
        }
    }
}