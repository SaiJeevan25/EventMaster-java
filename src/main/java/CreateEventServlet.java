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
import jakarta.servlet.http.HttpSession;

@WebServlet("/CreateEventServlet")
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Saijeevan@5689";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Event creation logic (same as before)
        createEvent(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Event retrieval logic (new logic for GET request)
        retrieveEvents(request, response);
    }

    private void createEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String eventType = request.getParameter("event-title");
        String customTitle = request.getParameter("custom-event-title");
        String eventDate = request.getParameter("event-date");
        String eventTime = request.getParameter("event-time");
        String eventDescription = request.getParameter("event-description");

        // Use custom title if provided
        if ("custom".equals(eventType) && customTitle != null && !customTitle.trim().isEmpty()) {
            eventType = customTitle;
        }

        // Retrieve the host's username from the session
        HttpSession session = request.getSession();
        String hostUsername = (String) session.getAttribute("username");

        // Validate mandatory fields
        if (hostUsername == null || eventType == null || eventDate == null || eventTime == null || eventDescription == null) {
            response.getWriter().println("All fields are required. Please try again.");
            return;
        }

        // Insert the event into the database
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Insert the event into the database
            String insertSql = "INSERT INTO events (hostUsername, title, date, time, description) VALUES (?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setString(1, hostUsername);
                stmt.setString(2, eventType);
                stmt.setString(3, eventDate);
                stmt.setString(4, eventTime);
                stmt.setString(5, eventDescription);
                stmt.executeUpdate();
            }

            // Redirect to ViewEvent.jsp to show the events
            retrieveEvents(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }

    private void retrieveEvents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the host's username from the session
        HttpSession session = request.getSession();
        String hostUsername = (String) session.getAttribute("username");

        // Retrieve the list of events for the logged-in host
        List<HashMap<String, String>> events = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            String selectSql = "SELECT title, date, time, description FROM events WHERE hostUsername = ?";
            try (PreparedStatement stmt = conn.prepareStatement(selectSql)) {
                stmt.setString(1, hostUsername);
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
        }

        // Set the events list as a request attribute and forward to the JSP page
        request.setAttribute("events", events);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ViewEvent.jsp");
        dispatcher.forward(request, response);
    }
}
