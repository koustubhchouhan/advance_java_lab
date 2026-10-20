<%@ page import="com.shopsphere.model.User" %> <% User loggedInUser = (User)
session.getAttribute("user"); String orderId = request.getParameter("orderId");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>ShopSphere | Order Success</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background-color: #f8f9fa;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .card {
        background: white;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        text-align: center;
        max-width: 420px;
      }
      .icon {
        font-size: 60px;
        color: #2e7d32;
        margin-bottom: 15px;
      }
      h1 {
        color: #1a237e;
        margin-bottom: 10px;
        font-size: 26px;
      }
      p {
        color: #555;
        margin-bottom: 20px;
        font-size: 15px;
      }
      .order-id {
        font-weight: bold;
        background: #e8f5e9;
        color: #2e7d32;
        padding: 8px 15px;
        border-radius: 20px;
        display: inline-block;
        margin-bottom: 25px;
      }
      .btn-home {
        background: #0d6efd;
        color: white;
        padding: 10px 22px;
        text-decoration: none;
        border-radius: 5px;
        font-size: 15px;
        font-weight: bold;
      }
      .btn-home:hover {
        background: #0b5ed7;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <div class="icon">🎉</div>
      <h1>Order Placed Successfully!</h1>
      <p>
        Thank you for shopping with ShopSphere. Your order is being processed.
      </p>
      <div class="order-id">Order ID: #<%= orderId %></div>
      <br />
      <a href="products.jsp" class="btn-home">Continue Shopping</a>
    </div>
  </body>
</html>
