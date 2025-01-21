import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/AttendeeDashboardServlet")
public class AttendeeDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Saijeevan@5689";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve events from the database
        List<HashMap<String, String>> events = new ArrayList<>();
        
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String selectSql = "SELECT title, date, time, description FROM events";  // Adjust query as needed
            try (PreparedStatement stmt = conn.prepareStatement(selectSql)) {
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        HashMap<String, String> event = new HashMap<>();
                        event.put("eventTitle", rs.getString("title"));
                        event.put("eventDate", rs.getString("date"));
                        event.put("eventTime", rs.getString("time"));
                        event.put("eventDescription", rs.getString("description"));
                        events.add(event);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }

        // Set the events list as a request attribute
        request.setAttribute("events", events);

        // Forward to the JSP page to display the events
        RequestDispatcher dispatcher = request.getRequestDispatcher("AttendeeDashboard.jsp");
        dispatcher.forward(request, response);
    }
}
