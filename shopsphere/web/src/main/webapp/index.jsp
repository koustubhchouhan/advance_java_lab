<%@ page import="com.shopsphere.model.User" %>
<%
    
    User loggedInUser = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere | Home</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; }
        
        /* Navbar */
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav-links { display: flex; align-items: center; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-size: 16px; }
        .nav-links a:hover { color: #90caf9; }
        .user-name { color: #ffca28; font-weight: bold; margin-left: 20px; font-size: 16px; }
        .btn-logout { color: #ff5252 !important; font-weight: bold; }

        /* Hero Banner */
        .hero { text-align: center; padding: 80px 20px; background: white; margin-bottom: 30px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .hero h1 { font-size: 40px; color: #1a237e; margin-bottom: 15px; }
        .hero p { font-size: 18px; color: #666; margin-bottom: 25px; }
        .btn-primary { background: #0d6efd; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-size: 16px; display: inline-block; }
        .btn-primary:hover { background: #0b5ed7; }

        /* Features Section */
        .features { display: flex; justify-content: center; gap: 20px; max-width: 1000px; margin: 0 auto; padding: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; text-align: center; flex: 1; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .card h3 { color: #1a237e; margin-bottom: 10px; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="logo">ShopSphere</a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="cart.jsp">Cart</a>

            <%-- Dynamic Session & Admin Navigation Logic --%>
            <% if (loggedInUser != null) { %>
                <span class="user-name">Hi, <%= loggedInUser.getName() %></span>
                
                <%-- Agar user Admin hai toh Admin Panel link dikhega --%>
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

    <section class="hero">
        <h1>Welcome to ShopSphere</h1>
        <p>Your one-stop destination for online shopping.</p>
        <a href="products.jsp" class="btn-primary">Explore Products</a>
    </section>

    <section class="features">
        <div class="card">
            <h3>⚡ Fast Delivery</h3>
            <p>Get your items delivered right to your doorstep quickly.</p>
        </div>
        <div class="card">
            <h3>🔒 Secure Payment</h3>
            <p>100% secure payment gateways for all transactions.</p>
        </div>
        <div class="card">
            <h3>🎧 24/7 Support</h3>
            <p>Our dedicated support team is here to help anytime.</p>
        </div>
    </section>

</body>
</html>