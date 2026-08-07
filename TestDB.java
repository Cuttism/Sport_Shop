import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TestDB {
    public static void main(String[] args) {
        String SERVER = "localhost";
        String PORT = "1433";
        String DATABASE = "sport_DB";
        String USER = "sa";
        String PASSWORD = "123";
        String URL = "jdbc:sqlserver://" + SERVER + ":" + PORT + ";databaseName=" + DATABASE + ";encrypt=true;trustServerCertificate=true;";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = conn.prepareStatement("SELECT TOP 1 TenSanPham FROM SAN_PHAM");
                 ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("Product: " + rs.getString(1));
                    System.out.println("Bytes: ");
                    for (byte b : rs.getString(1).getBytes("UTF-8")) {
                        System.out.printf("%02X ", b);
                    }
                    System.out.println();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
