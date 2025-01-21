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

@WebServlet("/EventRegistrationServlet")
public class EventRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Saijeevan@5689";

    // Handle POST requests to register or unregister for an event
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            registerForEvent(request, response);
        } else if ("unregister".equals(action)) {
            unregisterFromEvent(request, response);
        }
    }

    // Register user for an event
    private void registerForEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String eventTitle = request.getParameter("eventTitle");
        String eventDate = request.getParameter("eventDate");
        String eventTime = request.getParameter("eventTime");
        String eventDescription = request.getParameter("eventDescription");

        if (username != null) {
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                // Check if the event already exists for the user
                String checkSql = "SELECT COUNT(*) FROM attendeeEvents WHERE attendeeUsername = ? AND title = ?";
                try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                    checkStmt.setString(1, username);
                    checkStmt.setString(2, eventTitle);
                    ResultSet rs = checkStmt.executeQuery();

                    if (rs.next() && rs.getInt(1) > 0) {
                    	 response.setContentType("text/html");
                	     response.getWriter().println("<script type='text/javascript'>");
                	     response.getWriter().println("alert('You are already registered for this event!');");
                	     response.getWriter().println("window.location.href = 'AttendeeDashboardServlet';");
                	     response.getWriter().println("</script>");
                	     return;
                    }
                }

                // If event does not exist, insert the new event
                String insertSql = "INSERT INTO attendeeEvents (attendeeUsername, title, date, time, description) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, eventTitle);
                    insertStmt.setString(3, eventDate);
                    insertStmt.setString(4, eventTime);
                    insertStmt.setString(5, eventDescription);
                    int result = insertStmt.executeUpdate();

                    if (result > 0) {
                        retrieveRegisteredEvents(request, response); // Retrieve events after registration
                    } else {
                        response.getWriter().println("Registration failed.");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }

    // Unregister user from an event
    private void unregisterFromEvent(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String eventTitle = request.getParameter("eventTitle");

        if (username != null && eventTitle != null) {
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "DELETE FROM attendeeEvents WHERE attendeeUsername = ? AND title = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, username);
                    stmt.setString(2, eventTitle);
                    int result = stmt.executeUpdate();

                    if (result > 0) {
                        retrieveRegisteredEvents(request, response); // Retrieve events after unregistration
                    } else {
                        response.getWriter().println("Unregistration failed.");
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }

    // Retrieve the user's registered events and display them on the JSP
    private void retrieveRegisteredEvents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");

        if (username != null) {
            List<HashMap<String, String>> registeredEvents = new ArrayList<>();
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                String sql = "SELECT title, date, time, description FROM attendeeEvents WHERE attendeeUsername = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, username);
                    ResultSet rs = stmt.executeQuery();

                    while (rs.next()) {
                        HashMap<String, String> event = new HashMap<>();
                        event.put("title", rs.getString("title"));
                        event.put("date", rs.getString("date"));
                        event.put("time", rs.getString("time"));
                        event.put("description", rs.getString("description"));
                        registeredEvents.add(event);
                    }

                    request.setAttribute("registeredEvents", registeredEvents);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("RegisteredEvents.jsp");
                    dispatcher.forward(request, response);

                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Database error: " + e.getMessage());
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }

    // Handle GET requests to retrieve the user's registered events
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        retrieveRegisteredEvents(request, response);
    }
}
