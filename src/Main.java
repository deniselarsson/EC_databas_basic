import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {
    static String username = "Kalle";
    static String password = "password";
    static String url = "jdbc:sqlserver://localhost;databaseName=ECUtbildning";

    public static void main(String[] args) {
        try (var con = DriverManager.getConnection(url, username, password)){
            var statement = con.createStatement();
            var rs = statement.executeQuery("SELECT * FROM Studerande");

            while (rs.next()){
                System.out.println(rs.getString("Fornamn"));
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
