import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Saijeevan@5689";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String username = request.getParameter("username");  // Username used as identifier
        String password = request.getParameter("password");
        String accountType = request.getParameter("accountType");

        // Validate inputs (optional but recommended)

        // JDBC connection
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // SQL query for inserting the user data into the users table
            String sql = "INSERT INTO users (name, username, password, accountType) VALUES (?, ?, ?, ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, username);
                stmt.setString(3, password); // Hashing the password before storing is recommended
                stmt.setString(4, accountType);

                int rowsInserted = stmt.executeUpdate();

                // If registration is successful and account type is "host", create a new table
                if (rowsInserted > 0) {
                    response.sendRedirect("Login.jsp");  // Redirect to login page on success
                } else {
                    response.getWriter().println("Registration failed. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database connection error: " + e.getMessage());
        }
    }
}