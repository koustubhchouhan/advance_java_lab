import java.awt.event.*;
import java.sql.*;
import javax.swing.*;

public class studentRegistration extends JFrame implements ActionListener {

    JLabel name, roll, branch, gender;
    JTextField txtname, txtroll, txtbranch;
    JRadioButton male, female;
    JCheckBox terms;
    JButton submit, reset;

    ButtonGroup g;

    studentRegistration() {

        setSize(500, 500);
        setTitle("Student Registration Form (GIT)");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(null);

        name = new JLabel("Name ");
        name.setBounds(30, 30, 100, 20);
        add(name);

        txtname = new JTextField();
        txtname.setBounds(120, 30, 150, 20);
        add(txtname);

        roll = new JLabel("Roll No. ");
        roll.setBounds(30, 60, 100, 20);
        add(roll);

        txtroll = new JTextField();
        txtroll.setBounds(120, 60, 150, 20);
        add(txtroll);

        branch = new JLabel("Branch ");
        branch.setBounds(30, 90, 100, 20);
        add(branch);

        txtbranch = new JTextField();
        txtbranch.setBounds(120, 90, 150, 20);
        add(txtbranch);

        gender = new JLabel("Gender ");
        gender.setBounds(30, 120, 100, 20);
        add(gender);

        male = new JRadioButton("Male");
        male.setBounds(120, 120, 100, 20);
        add(male);

        female = new JRadioButton("Female");
        female.setBounds(120, 140, 100, 20);
        add(female);

        g = new ButtonGroup();
        g.add(male);
        g.add(female);

        terms = new JCheckBox("I accept Terms & Conditions");
        terms.setBounds(30, 170, 250, 20);
        add(terms);

        submit = new JButton("Submit");
        submit.setBounds(60, 210, 100, 25);
        submit.addActionListener(this);
        add(submit);

        reset = new JButton("Reset");
        reset.setBounds(180, 210, 100, 25);
        reset.addActionListener(this);
        add(reset);

        setLocationRelativeTo(null);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {

        if (e.getSource() == submit) {

            if (txtname.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Enter Name");

                return;
            }

            if (txtroll.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Enter Roll Number");

                return;
            }

            if (txtbranch.getText().trim().isEmpty()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Enter Branch");

                return;
            }

            if (!male.isSelected() && !female.isSelected()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Select Gender");

                return;
            }

            if (!terms.isSelected()) {

                JOptionPane.showMessageDialog(
                        this,
                        "Accept Terms");

                return;
            }

            String studentName = txtname.getText().trim();

            int rollNo;

            try {

                rollNo = Integer.parseInt(
                        txtroll.getText().trim());

            } catch (NumberFormatException ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "Roll Number must be a number");

                return;
            }

            String studentBranch = txtbranch.getText().trim();

            String studentGender;

            if (male.isSelected()) {

                studentGender = "Male";

            } else {

                studentGender = "Female";
            }

            String url = "jdbc:mysql://localhost:3306/COLLEGE";

            String username = "root";
            String password = "k_c@2014";

            String query = "INSERT INTO student(roll_no, name, gender, branch) " +
                    "VALUES (?, ?, ?, ?)";

            try {

                Class.forName(
                        "com.mysql.cj.jdbc.Driver");

                Connection con = DriverManager.getConnection(
                        url,
                        username,
                        password);

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1, rollNo);
                ps.setString(2, studentName);
                ps.setString(3, studentGender);
                ps.setString(4, studentBranch);

                int rows = ps.executeUpdate();

                if (rows > 0) {

                    JOptionPane.showMessageDialog(
                            this,
                            "Registration Successful!");

                    txtname.setText("");
                    txtroll.setText("");
                    txtbranch.setText("");

                    g.clearSelection();

                    terms.setSelected(false);
                }

                ps.close();
                con.close();

            } catch (ClassNotFoundException ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "MySQL JDBC Driver not found!");

                ex.printStackTrace();

            } catch (SQLException ex) {

                JOptionPane.showMessageDialog(
                        this,
                        "Database Error: " + ex.getMessage());

                ex.printStackTrace();
            }
        }

        else if (e.getSource() == reset) {

            txtname.setText("");
            txtroll.setText("");
            txtbranch.setText("");

            g.clearSelection();

            terms.setSelected(false);
        }
    }

    public static void main(String[] args) {

        new studentRegistration();

    }
}