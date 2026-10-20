package com.shopsphere.servlet;

import java.io.IOException;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddProductServlet")
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Security check: Only Admin can add products
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(request.getParameter("discount"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageUrl = request.getParameter("imageUrl");

        Product p = new Product();
        p.setCategoryId(categoryId);
        p.setName(name);
        p.setBrand(brand);
        p.setDescription(description);
        p.setPrice(price);
        p.setDiscount(discount);
        p.setStock(stock);
        p.setImageUrl(imageUrl);

        ProductDAO dao = new ProductDAO();
        boolean added = dao.addProduct(p);

        if (added) {
            response.sendRedirect("add_product.jsp?msg=added");
        } else {
            response.sendRedirect("add_product.jsp?error=failed");
        }
    }
}