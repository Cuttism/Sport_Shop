package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    private static final String SERVER = "localhost";
    private static final String PORT = "1433";
    private static final String DATABASE = "sport_DB";
    private static final String USER = "sa";
    private static final String PASSWORD = "123456";
    
    // Note: Use encrypt=true;trustServerCertificate=true if needed for newer JDBC drivers
    private static final String URL = "jdbc:sqlserver://" + SERVER + ":" + PORT 
            + ";databaseName=" + DATABASE 
            + ";encrypt=true;trustServerCertificate=true;";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load the SQL Server JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        Connection conn = getConnection();
        if (conn != null) {
            System.out.println("Connection successful!");
        } else {
            System.out.println("Connection failed!");
        }
    }
}
