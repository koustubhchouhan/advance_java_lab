<%@ page import="com.shopsphere.model.User" %>
<%@ page import="com.shopsphere.model.Product" %>
<%@ page import="com.shopsphere.dao.ProductDAO" %>
<%@ page import="java.util.List" %>
<%
    // Top par loggedInUser ko session se fetch kar rahe hain
    User loggedInUser = (User) session.getAttribute("user");
    
    // Database se products list fetch kar rahe hain
    ProductDAO productDAO = new ProductDAO();
    List<Product> productList = productDAO.getAllProducts();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere | Products</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; }
        
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav-links { display: flex; align-items: center; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-size: 16px; }
        .nav-links a:hover { color: #90caf9; }
        .user-name { color: #ffca28; font-weight: bold; margin-left: 20px; font-size: 16px; }
        .btn-logout { color: #ff5252 !important; font-weight: bold; }

        .page-title { text-align: center; margin: 30px 0 20px; color: #1a237e; }

        /* Product Grid */
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; max-width: 1100px; margin: 0 auto; padding: 20px; }
        .product-card { background: white; border-radius: 8px; padding: 20px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.08); transition: transform 0.2s; }
        .product-card:hover { transform: translateY(-5px); }
        
        .product-img { width: 100%; height: 160px; object-fit: contain; background: #f0f0f0; border-radius: 6px; margin-bottom: 15px; }
        .product-brand { font-size: 12px; color: #888; text-transform: uppercase; letter-spacing: 1px; font-weight: bold; }
        .product-title { font-size: 18px; font-weight: bold; margin: 5px 0 8px; color: #333; }
        .product-price { color: #2e7d32; font-size: 18px; font-weight: bold; margin-bottom: 15px; }
        
        .btn-add { background: #1a237e; color: white; border: none; padding: 10px 18px; border-radius: 4px; cursor: pointer; font-size: 14px; width: 100%; }
        .btn-add:hover { background: #0d47a1; }
        .no-products { text-align: center; width: 100%; color: #777; font-size: 18px; grid-column: 1 / -1; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="logo">ShopSphere</a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="cart.jsp">Cart</a>

            <%-- Dynamic Session & Admin Panel Option --%>
            <% if (loggedInUser != null) { %>
                <span class="user-name">Hi, <%= loggedInUser.getName() %></span>
                
                <% if ("ADMIN".equalsIgnoreCase(loggedInUser.getRole())) { %>
                    <a href="add_product.jsp" style="color: #ffca28; font-weight: bold; margin-left: 15px;">Admin Panel</a>
                <% } %>

                <a href="LogoutServlet" class="btn-logout">Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            <% } %>
        </div>
    </nav>

    <h1 class="page-title">Explore Our Products</h1>

    <div class="grid">
        <% if (productList != null && !productList.isEmpty()) { 
            for (Product p : productList) { %>
                <div class="product-card">
                    <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>" class="product-img" onerror="this.src='https://via.placeholder.com/150'">
                    <div class="product-brand"><%= p.getBrand() %></div>
                    <div class="product-title"><%= p.getName() %></div>
                    <div class="product-price">₹<%= p.getPrice() %></div>
                    
                    <form action="AddToCartServlet" method="POST">
                        <input type="hidden" name="productId" value="<%= p.getProductId() %>">
                        <button type="submit" class="btn-add">Add to Cart</button>
                    </form>
                </div>
        <%  } 
           } else { %>
            <div class="no-products">No products found in database!</div>
        <% } %>
    </div>

</body>
</html>