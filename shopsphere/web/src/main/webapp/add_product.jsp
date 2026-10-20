<%@ page import="com.shopsphere.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null || !"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ShopSphere Admin | Add Product</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; }
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; }
        
        .container { max-width: 600px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        h2 { color: #1a237e; margin-bottom: 20px; text-align: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group textarea, .form-group select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .row { display: flex; gap: 15px; }
        .btn-submit { width: 100%; background: #1a237e; color: white; border: none; padding: 12px; border-radius: 4px; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background: #0d47a1; }
        .alert-success { background: #d4edda; color: #155724; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
        .alert-error { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 4px; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="logo">ShopSphere Admin</a>
        <div class="nav-links">
            <a href="add_product.jsp">Add Product</a>
            <a href="admin_orders.jsp">Manage Orders</a>
            <a href="products.jsp">View Store</a>
            <a href="LogoutServlet" style="color: #ff5252;">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h2>Add New Product</h2>

        <% if ("added".equals(request.getParameter("msg"))) { %>
            <div class="alert-success">Product added successfully!</div>
        <% } else if ("failed".equals(request.getParameter("error"))) { %>
            <div class="alert-error">Failed to add product. Try again!</div>
        <% } %>

        <form action="AddProductServlet" method="POST">
            <div class="form-group">
                <label>Category</label>
                <select name="categoryId" required>
                    <option value="1">Electronics</option>
                    <option value="2">Fashion</option>
                    <option value="3">Home & Appliances</option>
                </select>
            </div>
            <div class="form-group">
                <label>Product Name</label>
                <input type="text" name="name" placeholder="e.g. Wireless Mouse" required>
            </div>
            <div class="form-group">
                <label>Brand</label>
                <input type="text" name="brand" placeholder="e.g. Logitech" required>
            </div>
            <div class="row">
                <div class="form-group" style="flex: 1;">
                    <label>Price (₹)</label>
                    <input type="number" step="0.01" name="price" placeholder="999.00" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Discount (₹)</label>
                    <input type="number" step="0.01" name="discount" value="0.0">
                </div>
                <div class="form-group" style="flex: 1;">
                    <label>Stock Qty</label>
                    <input type="number" name="stock" value="10" required>
                </div>
            </div>
            <div class="form-group">
                <label>Image URL</label>
                <input type="text" name="imageUrl" placeholder="https://..." required>
            </div>
            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="3" placeholder="Product details..."></textarea>
            </div>
            <button type="submit" class="btn-submit">Add Product</button>
        </form>
    </div>

</body>
</html>