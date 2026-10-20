import javax.swing.*;
import java.awt.event.*;
import java.sql.*;

public class sectionb extends JFrame implements ActionListener {

    JLabel lblName, lblRoll, lblGender, lblBranch;
    JTextField txtName, txtRoll, txtBranch;

    JRadioButton male, female;
    ButtonGroup genderGroup;

    JCheckBox terms;

    JButton submit, reset;

    public sectionb() {

        setTitle("Student Registration Form");
        setSize(450, 450);
        setLayout(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Student Name
        lblName = new JLabel("Student Name");
        lblName.setBounds(30, 30, 120, 30);
        add(lblName);

        txtName = new JTextField();
        txtName.setBounds(170, 30, 180, 30);
        add(txtName);

        // Roll Number
        lblRoll = new JLabel("Roll Number");
        lblRoll.setBounds(30, 80, 120, 30);
        add(lblRoll);

        txtRoll = new JTextField();
        txtRoll.setBounds(170, 80, 180, 30);
        add(txtRoll);

        // Gender
        lblGender = new JLabel("Gender");
        lblGender.setBounds(30, 130, 120, 30);
        add(lblGender);

        male = new JRadioButton("Male");
        male.setBounds(170, 130, 80, 30);
        add(male);

        female = new JRadioButton("Female");
        female.setBounds(260, 130, 100, 30);
        add(female);

        genderGroup = new ButtonGroup();
        genderGroup.add(male);
        genderGroup.add(female);

        // Branch
        lblBranch = new JLabel("Branch");
        lblBranch.setBounds(30, 180, 120, 30);
        add(lblBranch);

        txtBranch = new JTextField();
        txtBranch.setBounds(170, 180, 180, 30);
        add(txtBranch);

        // Terms
        terms = new JCheckBox("I accept Terms & Conditions");
        terms.setBounds(30, 230, 250, 30);
        add(terms);

        // Submit
        submit = new JButton("Submit");
        submit.setBounds(80, 290, 100, 35);
        submit.addActionListener(this);
        add(submit);

        // Reset
        reset = new JButton("Reset");
        reset.setBounds(220, 290, 100, 35);
        reset.addActionListener(this);
        add(reset);

        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        // =========================
        // RESET BUTTON
        // =========================

        if (e.getSource() == reset) {

            txtName.setText("");
            txtRoll.setText("");
            txtBranch.setText("");

            genderGroup.clearSelection();

            terms.setSelected(false);

            return;
        }

        // =========================
        // SUBMIT BUTTON
        // =========================

        if (e.getSource() == submit) {

            // Name validation
            if (txtName.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Please enter Student Name"
                );

                return;
            }

            // Roll validation
            if (txtRoll.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Please enter Roll Number"
                );

                return;
            }

            // Gender validation
            if (!male.isSelected() && !female.isSelected()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Please select Gender"
                );

                return;
            }

            // Branch validation
            if (txtBranch.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Please enter Branch"
                );

                return;
            }

            // Terms validation
            if (!terms.isSelected()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Please accept Terms & Conditions"
                );

                return;
            }

            // Get Gender
            String gender;

            if (male.isSelected()) {
                gender = "Male";
            } else {
                gender = "Female";
            }

            // Get form values
            String name = txtName.getText().trim();
            String rollText = txtRoll.getText().trim();
            String branch = txtBranch.getText().trim();

            // Convert Roll Number to integer
            int roll;

            try {
                roll = Integer.parseInt(rollText);
            } catch (NumberFormatException ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "Roll Number must be a number"
                );

                return;
            }

            // =========================
            // JDBC CONNECTION
            // =========================

            try {

                // Load Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Connect to MySQL
                Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/Git",
                        "root",
                        "manangupta@123"
                );

                // =========================
                // INSERT DATA
                // =========================

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO student (roll, name, gender, branch) VALUES (?, ?, ?, ?)"
                );

                ps.setInt(1, roll);
                ps.setString(2, name);
                ps.setString(3, gender);
                ps.setString(4, branch);

                ps.executeUpdate();

                // Close resources
                ps.close();
                con.close();

                // Success message
                JOptionPane.showMessageDialog(
                        this,
                        "Registration Successful\n\n"
                                + "Name : " + name
                                + "\nRoll Number : " + roll
                                + "\nGender : " + gender
                                + "\nBranch : " + branch
                );

                // Clear form
                txtName.setText("");
                txtRoll.setText("");
                txtBranch.setText("");
                genderGroup.clearSelection();
                terms.setSelected(false);

            } catch (SQLIntegrityConstraintViolationException ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "Roll Number already exists!"
                );

            } catch (Exception ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "Database Error: " + ex.getMessage()
                );

                ex.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {

        new sectionb();
    }
}