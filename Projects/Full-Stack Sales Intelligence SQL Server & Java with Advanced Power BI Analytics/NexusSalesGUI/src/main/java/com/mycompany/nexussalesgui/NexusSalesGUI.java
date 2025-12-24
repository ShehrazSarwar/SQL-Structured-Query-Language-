package com.mycompany.nexussalesgui;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

public class NexusSalesGUI extends JFrame {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;"
                + "databaseName=Nexus_Sales_Intelligence;"
                + "integratedSecurity=true;"
                + "encrypt=true;"
                + "trustServerCertificate=true;";

    private Connection connection;

    private CardLayout cardLayout;
    private JPanel mainPanel;

    private JTextField usernameField;
    private JPasswordField passwordField;
    private JButton loginButton;

    private int loggedInUserId;

    // Tables for Products and Customers
    private JTable productTable;
    private JTable customerTable;
    private DefaultTableModel productModel;
    private DefaultTableModel customerModel;

    public NexusSalesGUI() {
        setTitle("Nexus Sales Intelligence System");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        try {
            connection = DriverManager.getConnection(DB_URL);
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Database connection failed: " + ex.getMessage());
            System.exit(0);
        }

        cardLayout = new CardLayout();
        mainPanel = new JPanel(cardLayout);

        mainPanel.add(createLoginPanel(), "login");
        mainPanel.add(createAdminPanel(), "admin");

        add(mainPanel);
        cardLayout.show(mainPanel, "login");
    }

    private JPanel createLoginPanel() {
        JPanel panel = new JPanel(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();
        gbc.insets = new Insets(10, 10, 10, 10);

        JLabel userLabel = new JLabel("Username:");
        JLabel passLabel = new JLabel("Password:");
        usernameField = new JTextField(15);
        passwordField = new JPasswordField(15);
        loginButton = new JButton("Login");

        gbc.gridx = 0; gbc.gridy = 0; panel.add(userLabel, gbc);
        gbc.gridx = 1; panel.add(usernameField, gbc);
        gbc.gridx = 0; gbc.gridy = 1; panel.add(passLabel, gbc);
        gbc.gridx = 1; panel.add(passwordField, gbc);
        gbc.gridx = 0; gbc.gridy = 2; gbc.gridwidth = 2; panel.add(loginButton, gbc);

        loginButton.addActionListener(e -> login());

        return panel;
    }

    private JPanel createAdminPanel() {
        JPanel panel = new JPanel(new BorderLayout());

        // Split pane for Products and Customers
        JSplitPane splitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
        splitPane.setDividerLocation(250);

        // Products panel
        JPanel productPanel = new JPanel(new BorderLayout());
        productPanel.setBorder(BorderFactory.createTitledBorder("Products"));

        productModel = new DefaultTableModel();
        productTable = new JTable(productModel);
        JScrollPane productScroll = new JScrollPane(productTable);
        productPanel.add(productScroll, BorderLayout.CENTER);

        JPanel prodControlPanel = new JPanel();
        JButton refreshProducts = new JButton("Refresh Products");
        JButton deleteProduct = new JButton("Delete Selected Product");
        prodControlPanel.add(refreshProducts);
        prodControlPanel.add(deleteProduct);
        productPanel.add(prodControlPanel, BorderLayout.SOUTH);

        refreshProducts.addActionListener(e -> loadProducts());
        deleteProduct.addActionListener(e -> deleteSelectedProduct());

        // Customers panel
        JPanel customerPanel = new JPanel(new BorderLayout());
        customerPanel.setBorder(BorderFactory.createTitledBorder("Customers"));

        customerModel = new DefaultTableModel();
        customerTable = new JTable(customerModel);
        JScrollPane customerScroll = new JScrollPane(customerTable);
        customerPanel.add(customerScroll, BorderLayout.CENTER);

        JPanel custControlPanel = new JPanel();
        JButton refreshCustomers = new JButton("Refresh Customers");
        JButton deleteCustomer = new JButton("Delete Selected Customer");
        custControlPanel.add(refreshCustomers);
        custControlPanel.add(deleteCustomer);
        customerPanel.add(custControlPanel, BorderLayout.SOUTH);

        refreshCustomers.addActionListener(e -> loadCustomers());
        deleteCustomer.addActionListener(e -> deleteSelectedCustomer());

        splitPane.setTopComponent(productPanel);
        splitPane.setBottomComponent(customerPanel);

        panel.add(splitPane, BorderLayout.CENTER);

        return panel;
    }

    private void login() {
        String username = usernameField.getText();
        String password = new String(passwordField.getPassword());

        try {
            String sql = "SELECT user_id, user_role, is_authorized FROM sales.dim_users WHERE username = ? AND password_hash = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                boolean authorized = rs.getBoolean("is_authorized");
                String role = rs.getString("user_role");
                loggedInUserId = rs.getInt("user_id");

                if (!authorized) {
                    JOptionPane.showMessageDialog(this, "Access revoked. Contact Admin.");
                    return;
                }

                if (role.equals("Admin")) {
                    cardLayout.show(mainPanel, "admin");
                    loadProducts();
                    loadCustomers();
                } else {
                    JOptionPane.showMessageDialog(this, "You do not have Admin privileges.");
                }
            } else {
                JOptionPane.showMessageDialog(this, "Invalid username or password.");
            }

        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Login failed: " + ex.getMessage());
        }
    }

    private void loadProducts() {
        try {
            productModel.setRowCount(0);
            productModel.setColumnIdentifiers(new Object[]{"Product Key", "Product ID", "Name", "Category", "Cost", "Active"});

            String sql = "SELECT product_key, product_id, product_name, category, cost, is_active FROM sales.dim_products";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                productModel.addRow(new Object[]{
                        rs.getInt("product_key"),
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("category"),
                        rs.getDouble("cost"),
                        rs.getBoolean("is_active")
                });
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error loading products: " + ex.getMessage());
        }
    }

    private void loadCustomers() {
        try {
            customerModel.setRowCount(0);
            customerModel.setColumnIdentifiers(new Object[]{"Customer Key", "Customer ID", "Name", "Country", "Active"});

            String sql = "SELECT customer_key, customer_id, first_name, last_name, country, is_active FROM sales.dim_customers";
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                customerModel.addRow(new Object[]{
                        rs.getInt("customer_key"),
                        rs.getInt("customer_id"),
                        rs.getString("first_name") + " " + rs.getString("last_name"),
                        rs.getString("country"),
                        rs.getBoolean("is_active")
                });
            }
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error loading customers: " + ex.getMessage());
        }
    }

    private void deleteSelectedProduct() {
        int selectedRow = productTable.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Select a product to delete.");
            return;
        }
        int productKey = (int) productModel.getValueAt(selectedRow, 0);

        try {
            CallableStatement cs = connection.prepareCall("{call sales.sp_DeleteProduct_Safe(?, ?)}");
            cs.setInt(1, productKey);
            cs.setInt(2, loggedInUserId);
            cs.execute();

            JOptionPane.showMessageDialog(this, "Product soft-deleted successfully.");
            loadProducts();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }

    private void deleteSelectedCustomer() {
        int selectedRow = customerTable.getSelectedRow();
        if (selectedRow == -1) {
            JOptionPane.showMessageDialog(this, "Select a customer to delete.");
            return;
        }
        int customerKey = (int) customerModel.getValueAt(selectedRow, 0);

        try {
            CallableStatement cs = connection.prepareCall("{call sales.sp_DeleteCustomer_Safe(?, ?)}");
            cs.setInt(1, customerKey);
            cs.setInt(2, loggedInUserId);
            cs.execute();

            JOptionPane.showMessageDialog(this, "Customer soft-deleted successfully.");
            loadCustomers();
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(this, "Error: " + ex.getMessage());
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new NexusSalesGUI().setVisible(true));
    }
}