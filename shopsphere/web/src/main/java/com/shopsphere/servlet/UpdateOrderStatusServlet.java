package com.shopsphere.servlet;

import java.io.IOException;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/UpdateOrderStatusServlet")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("orderStatus");

        OrderDAO dao = new OrderDAO();
        dao.updateOrderStatus(orderId, status);

        response.sendRedirect("admin_orders.jsp");
    }
}