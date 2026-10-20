package com.shopsphere.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.shopsphere.model.Cart;
import com.shopsphere.util.DBConnection;

public class CartDAO {

    public boolean addToCart(int userId, int productId, int quantity) {
        boolean success = false;
        String checkQuery = "SELECT quantity FROM cart WHERE user_id = ? AND product_id = ?";
        String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
        String updateQuery = "UPDATE cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement checkPs = con.prepareStatement(checkQuery)) {

            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {

                try (PreparedStatement updatePs = con.prepareStatement(updateQuery)) {
                    updatePs.setInt(1, quantity);
                    updatePs.setInt(2, userId);
                    updatePs.setInt(3, productId);
                    success = updatePs.executeUpdate() > 0;
                }
            } else {
                // Cart me nahi hai toh naya row insert karo
                try (PreparedStatement insertPs = con.prepareStatement(insertQuery)) {
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, productId);
                    insertPs.setInt(3, quantity);
                    success = insertPs.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Cart> getCartByUserId(int userId) {
        List<Cart> cartList = new ArrayList<>();
        String query = "SELECT c.cart_id, c.user_id, c.product_id, c.quantity, p.name, p.price, p.image_url " +
                "FROM cart c JOIN products p ON c.product_id = p.product_id WHERE c.user_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart item = new Cart();
                item.setCartId(rs.getInt("cart_id"));
                item.setUserId(rs.getInt("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setProductName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setImageUrl(rs.getString("image_url"));

                cartList.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartList;
    }

    public boolean removeFromCart(int cartId) {
        boolean success = false;
        String query = "DELETE FROM cart WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, cartId);
            success = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}