<%@ page import="com.shopsphere.model.User" %>
<%@ page import="com.shopsphere.model.Order" %>
<%@ page import="com.shopsphere.dao.OrderDAO" %>
<%@ page import="java.util.List" %>
<%
    User loggedInUser = (User) session.getAttribute("user");
    if (loggedInUser == null || !"ADMIN".equalsIgnoreCase(loggedInUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    OrderDAO orderDAO = new OrderDAO();
    List<Order> orderList = orderDAO.getAllOrders();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>ShopSphere Admin | Manage Orders</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: Arial, sans-serif; }
        body { background-color: #f8f9fa; }
        .navbar { background: #1a237e; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { color: white; font-size: 24px; font-weight: bold; text-decoration: none; }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; }

        .container { max-width: 1100px; margin: 30px auto; padding: 20px; background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        h2 { color: #1a237e; margin-bottom: 20px; }

        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; font-size: 14px; }
        th { background-color: #f0f2f5; color: #1a237e; }

        .badge { padding: 4px 8px; border-radius: 4px; font-weight: bold; font-size: 12px; }
        .badge-PLACED { background: #fff3cd; color: #856404; }
        .badge-SHIPPED { background: #cce5ff; color: #004085; }
        .badge-DELIVERED { background: #d4edda; color: #155724; }
        .badge-CANCELLED { background: #f8d7da; color: #721c24; }

        .btn-update { background: #1a237e; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer; }
        select { padding: 4px; border-radius: 4px; border: 1px solid #ccc; }
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
        <h2>Customer Orders Management</h2>

        <% if (orderList != null && !orderList.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Amount</th>
                        <th>Payment</th>
                        <th>Current Status</th>
                        <th>Update Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order o : orderList) { %>
                        <tr>
                            <td>#<%= o.getOrderId() %></td>
                            <td><%= o.getUserName() %></td>
                            <td>₹<%= o.getTotalAmount() %></td>
                            <td><%= o.getPaymentMethod() %></td>
                            <td><span class="badge badge-<%= o.getOrderStatus() %>"><%= o.getOrderStatus() %></span></td>
                            <td>
                                <form action="UpdateOrderStatusServlet" method="POST" style="display: flex; gap: 5px;">
                                    <input type="hidden" name="orderId" value="<%= o.getOrderId() %>">
                                    <select name="orderStatus">
                                        <option value="PLACED" <%= "PLACED".equals(o.getOrderStatus()) ? "selected" : "" %>>PLACED</option>
                                        <option value="SHIPPED" <%= "SHIPPED".equals(o.getOrderStatus()) ? "selected" : "" %>>SHIPPED</option>
                                        <option value="DELIVERED" <%= "DELIVERED".equals(o.getOrderStatus()) ? "selected" : "" %>>DELIVERED</option>
                                        <option value="CANCELLED" <%= "CANCELLED".equals(o.getOrderStatus()) ? "selected" : "" %>>CANCELLED</option>
                                    </select>
                                    <button type="submit" class="btn-update">Save</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p style="color: #777;">No orders placed yet.</p>
        <% } %>
    </div>

</body>
</html>