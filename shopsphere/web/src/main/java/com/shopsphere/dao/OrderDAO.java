package com.shopsphere.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.shopsphere.model.Cart;
import com.shopsphere.model.Order;
import com.shopsphere.util.DBConnection;

public class OrderDAO {

    public int placeOrder(int userId, String addressLine, String city, String state, String pincode,
            double totalAmount, String paymentMethod, List<Cart> cartList) {

        int orderId = -1;
        Connection con = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Transaction management start

            String addrQuery = "INSERT INTO addresses (user_id, address_line, city, state, pincode, address_type) VALUES (?, ?, ?, ?, ?, 'HOME')";
            int addressId = -1;

            try (PreparedStatement addrPs = con.prepareStatement(addrQuery, Statement.RETURN_GENERATED_KEYS)) {
                addrPs.setInt(1, userId);
                addrPs.setString(2, addressLine);
                addrPs.setString(3, city);
                addrPs.setString(4, state);
                addrPs.setString(5, pincode);
                addrPs.executeUpdate();

                ResultSet rsAddr = addrPs.getGeneratedKeys();
                if (rsAddr.next()) {
                    addressId = rsAddr.getInt(1);
                }
            }

            String orderQuery = "INSERT INTO orders (user_id, address_id, total_amount, payment_method, payment_status, order_status) VALUES (?, ?, ?, ?, 'SUCCESS', 'PLACED')";
            try (PreparedStatement orderPs = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS)) {
                orderPs.setInt(1, userId);
                orderPs.setInt(2, addressId);
                orderPs.setDouble(3, totalAmount);
                orderPs.setString(4, paymentMethod);
                orderPs.executeUpdate();

                ResultSet rsOrder = orderPs.getGeneratedKeys();
                if (rsOrder.next()) {
                    orderId = rsOrder.getInt(1);
                }
            }

            String itemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement itemPs = con.prepareStatement(itemQuery)) {
                for (Cart c : cartList) {
                    itemPs.setInt(1, orderId);
                    itemPs.setInt(2, c.getProductId());
                    itemPs.setInt(3, c.getQuantity());
                    itemPs.setDouble(4, c.getPrice());
                    itemPs.addBatch();
                }
                itemPs.executeBatch();
            }

            String clearCartQuery = "DELETE FROM cart WHERE user_id = ?";
            try (PreparedStatement clearPs = con.prepareStatement(clearCartQuery)) {
                clearPs.setInt(1, userId);
                clearPs.executeUpdate();
            }

            con.commit(); // Transaction Complete
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        return orderId;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String query = "SELECT o.order_id, o.user_id, u.name as user_name, o.total_amount, o.payment_method, o.payment_status, o.order_status, o.created_at "
                +
                "FROM orders o JOIN users u ON o.user_id = u.user_id ORDER BY o.created_at DESC";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setUserId(rs.getInt("user_id"));
                o.setUserName(rs.getString("user_name"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setPaymentStatus(rs.getString("payment_status"));
                o.setOrderStatus(rs.getString("order_status"));
                o.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(o);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        boolean success = false;
        String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);
            success = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

}