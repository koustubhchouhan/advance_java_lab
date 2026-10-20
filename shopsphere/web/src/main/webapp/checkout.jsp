<%@ page import="com.shopsphere.model.User" %>
<%@ page import="com.shopsphere.model.Cart" %>
<%@ page import="com.shopsphere.dao.CartDAO" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CartDAO cartDAO = new CartDAO();
    List<Cart> cartList = cartDAO.getCartByUserId(loggedInUser.getUserId());
    double subtotal = 0;
    if (cartList != null) {
        for (Cart c : cartList) {
            subtotal += (c.getPrice() * c.getQuantity());
        }
    }
    double totalAmount = (subtotal > 0) ? (subtotal + 99.0) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ShopSphere | Checkout</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; color: #333; }
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .container { max-width: 900px; margin: 30px auto; padding: 20px; display: flex; gap: 30px; flex-wrap: wrap; }
        .form-section { flex: 2; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .summary-section { flex: 1; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); height: fit-content; }
        h2 { color: #1a237e; margin-bottom: 20px; font-size: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; font-size: 14px; }
        .form-group input, .form-group select { width: 100%; padding: 9px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-place { width: 100%; background: #2e7d32; color: white; border: none; padding: 12px; border-radius: 5px; font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 15px; }
        .btn-place:hover { background: #1b5e20; }
        .row { display: flex; gap: 15px; }
        .summary-line { display: flex; justify-content: space-between; margin-bottom: 10px; color: #555; }
        .summary-line.total { border-top: 2px solid #eee; padding-top: 10px; font-weight: bold; font-size: 18px; color: #1a237e; }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="logo">ShopSphere</a>
    </nav>

    <div class="container">
        <div class="form-section">
            <h2>Shipping & Payment Details</h2>
            <form action="PlaceOrderServlet" method="POST">
                <div class="form-group">
                    <label>Street Address / House No.</label>
                    <input type="text" name="addressLine" placeholder="123 Main Street" required>
                </div>
                <div class="row">
                    <div class="form-group" style="flex: 1;">
                        <label>City</label>
                        <input type="text" name="city" placeholder="Jaipur" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>State</label>
                        <input type="text" name="state" placeholder="Rajasthan" required>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group" style="flex: 1;">
                        <label>Pincode</label>
                        <input type="text" name="pincode" placeholder="302001" required>
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>Payment Method</label>
                        <select name="paymentMethod">
                            <option value="COD">Cash on Delivery (COD)</option>
                            <option value="UPI">UPI / Online Payment</option>
                            <option value="CARD">Credit / Debit Card</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn-place">Confirm & Place Order</button>
            </form>
        </div>

        <div class="summary-section">
            <h2>Order Summary</h2>
            <div class="summary-line">
                <span>Subtotal</span>
                <span>₹<%= subtotal %></span>
            </div>
            <div class="summary-line">
                <span>Shipping Fee</span>
                <span>₹99.0</span>
            </div>
            <div class="summary-line total">
                <span>Total Payable</span>
                <span>₹<%= totalAmount %></span>
            </div>
        </div>
    </div>

</body>
</html>