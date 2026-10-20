<%@ page import="com.shopsphere.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
%>

<!-- Navbar Segment -->
<div class="nav-links">
    <a href="index.jsp">Home</a>
    <a href="products.jsp">Products</a>
    <a href="cart.jsp">Cart</a>
    
    <% if (loggedInUser != null) { %>
        <span style="color: #ffca28; font-weight: bold; margin-left: 15px;">
            Hi, <%= loggedInUser.getName() %>
        </span>
        <a href="LogoutServlet" style="color: #ff5252;">Logout</a>
    <% } else { %>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    <% } %>
</div>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ShopSphere | Login</title>
    <style>
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
      }
      body {
        background-color: #f4f6f9;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }

      .navbar {
        background: #1a237e;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
      }
      .navbar .logo {
        color: white;
        font-size: 24px;
        font-weight: bold;
        text-decoration: none;
      }
      .nav-links a {
        color: white;
        text-decoration: none;
        margin-left: 20px;
      }

      .form-container {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 20px;
      }
      .card {
        background: white;
        padding: 35px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 360px;
      }
      .card h2 {
        color: #1a237e;
        text-align: center;
        margin-bottom: 25px;
      }

      .form-group {
        margin-bottom: 18px;
      }
      .form-group label {
        display: block;
        margin-bottom: 6px;
        font-weight: bold;
        font-size: 14px;
      }
      .form-group input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
      }

      .btn {
        width: 100%;
        padding: 10px;
        background: #0d6efd;
        color: white;
        border: none;
        border-radius: 4px;
        font-size: 16px;
        cursor: pointer;
      }
      .btn:hover {
        background: #0b5ed7;
      }
      .link-text {
        text-align: center;
        margin-top: 15px;
        font-size: 14px;
      }
      .link-text a {
        color: #0d6efd;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <nav class="navbar">
      <a href="index.jsp" class="logo">ShopSphere</a>
      <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="products.jsp">Products</a>
        <a href="register.jsp">Register</a>
      </div>
    </nav>

    <div class="form-container">
      <div class="card">
        <h2>User Login</h2>
        <form action="LoginServlet" method="POST">
          <div class="form-group">
            <label>Email Address</label>
            <input
              type="email"
              name="email"
              placeholder="name@example.com"
              required
            />
          </div>
          <div class="form-group">
            <label>Password</label>
            <input
              type="password"
              name="password"
              placeholder="Enter password"
              required
            />
          </div>
          <button type="submit" class="btn">Login</button>
        </form>
        <div class="link-text">
          Don't have an account? <a href="register.jsp">Register here</a>
        </div>
      </div>
    </div>
  </body>
</html>
