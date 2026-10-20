<%@ page import="com.shopsphere.model.User" %>
<%@ page import="com.shopsphere.model.Cart" %>
<%@ page import="com.shopsphere.dao.CartDAO" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    List<Cart> cartList = null;
    double subtotal = 0.0;
    double shippingFee = 99.0;

    if (loggedInUser != null) {
        CartDAO cartDAO = new CartDAO();
        cartList = cartDAO.getCartByUserId(loggedInUser.getUserId());
        if (cartList != null) {
            for (Cart c : cartList) {
                subtotal += (c.getPrice() * c.getQuantity());
            }
        }
    }
    double totalAmount = (subtotal > 0) ? (subtotal + shippingFee) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere | Shopping Cart</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; min-height: 100vh; display: flex; flex-direction: column; }
        
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav-links { display: flex; align-items: center; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-size: 16px; }
        .nav-links a:hover { color: #90caf9; }
        .user-name { color: #ffca28; font-weight: bold; margin-left: 20px; }
        .btn-logout { color: #ff5252 !important; font-weight: bold; }

        .page-title { text-align: center; margin: 30px 0 10px; color: #1a237e; }

        .cart-container { max-width: 1100px; margin: 20px auto; padding: 0 20px; display: flex; gap: 30px; flex-wrap: wrap; width: 100%; }
        .cart-items { flex: 2; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); min-width: 300px; }
        .cart-header { font-size: 20px; font-weight: bold; margin-bottom: 20px; color: #1a237e; border-bottom: 2px solid #f4f6f9; padding-bottom: 10px; }

        .cart-item { display: flex; align-items: center; justify-content: space-between; padding: 15px 0; border-bottom: 1px solid #eee; }
        .item-details { display: flex; align-items: center; gap: 15px; }
        .item-img { width: 60px; height: 60px; object-fit: contain; background: #f0f0f0; border-radius: 6px; }
        .item-name { font-weight: bold; font-size: 16px; color: #333; }
        .item-price { color: #666; font-size: 14px; margin-top: 4px; }
        .item-qty { font-weight: bold; font-size: 15px; color: #555; }
        .item-total { font-weight: bold; color: #2e7d32; font-size: 16px; width: 90px; text-align: right; }
        .btn-remove { background: #ff4d4d; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 12px; }
        .btn-remove:hover { background: #cc0000; }

        .order-summary { flex: 1; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); height: fit-content; min-width: 280px; }
        .summary-header { font-size: 20px; font-weight: bold; margin-bottom: 20px; color: #1a237e; border-bottom: 2px solid #f4f6f9; padding-bottom: 10px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 15px; color: #555; }
        .summary-row.total { border-top: 2px solid #eee; padding-top: 15px; margin-top: 15px; font-weight: bold; font-size: 18px; color: #1a237e; }

        .btn-checkout { width: 100%; background: #2e7d32; color: white; border: none; padding: 12px; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 15px; }
        .btn-checkout:hover { background: #1b5e20; }
        .btn-continue { display: block; text-align: center; margin-top: 12px; color: #0d6efd; text-decoration: none; font-size: 14px; }
        .empty-msg { text-align: center; padding: 30px; color: #777; font-size: 18px; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="logo">ShopSphere</a>
        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="products.jsp">Products</a>
            <a href="cart.jsp">Cart</a>

            <% if (loggedInUser != null) { %>
                <span class="user-name">Hi, <%= loggedInUser.getName() %></span>
                <a href="LogoutServlet" class="btn-logout">Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            <% } %>
        </div>
    </nav>

    <h1 class="page-title">Shopping Cart</h1>

    <% if (loggedInUser == null) { %>
        <div class="empty-msg">
            Please <a href="login.jsp" style="color: #0d6efd;">Login</a> to view your shopping cart.
        </div>
    <% } else { %>
        <div class="cart-container">
            <div class="cart-items">
                <div class="cart-header">Your Cart Items</div>
                
                <% if (cartList != null && !cartList.isEmpty()) { 
                    for (Cart item : cartList) { %>
                        <div class="cart-item">
                            <div class="item-details">
                                <img src="<%= item.getImageUrl() %>" alt="<%= item.getProductName() %>" class="item-img" onerror="this.src='https://via.placeholder.com/150'">
                                <div>
                                    <div class="item-name"><%= item.getProductName() %></div>
                                    <div class="item-price">₹<%= item.getPrice() %></div>
                                </div>
                            </div>
                            <div class="item-qty">Qty: <%= item.getQuantity() %></div>
                            <div class="item-total">₹<%= item.getPrice() * item.getQuantity() %></div>
                            
                            <form action="RemoveFromCartServlet" method="POST">
                                <input type="hidden" name="cartId" value="<%= item.getCartId() %>">
                                <button type="submit" class="btn-remove">Remove</button>
                            </form>
                        </div>
                <%  } 
                   } else { %>
                    <div class="empty-msg">Your cart is currently empty!</div>
                <% } %>
            </div>

            <div class="order-summary">
                <div class="summary-header">Order Summary</div>
                <div class="summary-row">
                    <span>Subtotal</span>
                    <span>₹<%= subtotal %></span>
                </div>
                <div class="summary-row">
                    <span>Shipping Fee</span>
                    <span>₹<%= (subtotal > 0) ? shippingFee : 0 %></span>
                </div>
                <div class="summary-row total">
                    <span>Total Amount</span>
                    <span>₹<%= totalAmount %></span>
                </div>
                
                <% if (subtotal > 0) { %>
                    <form action="checkout.jsp" method="GET">
                        <button type="submit" class="btn-checkout">Proceed to Checkout</button>
                    </form>
                <% } %>
                <a href="products.jsp" class="btn-continue">← Continue Shopping</a>
            </div>
        </div>
    <% } %>

</body>
</html>