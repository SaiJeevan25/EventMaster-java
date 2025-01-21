//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/LoginServlet")
//public class LoginServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    // Database connection details
//    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
//    private static final String DB_USER = "root";
//    private static final String DB_PASS = "Saijeevan@5689";
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Get login credentials from form
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
//            // Query to check email and password
//            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
//            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
//                stmt.setString(1, username);
//                stmt.setString(2, password); // In production, hash and verify hashed password
//
//                try (ResultSet rs = stmt.executeQuery()) {
//                    if (rs.next()) {
//                        // If user is found, create a session and redirect to the appropriate dashboard
//                        HttpSession session = request.getSession();
//                        session.setAttribute("user", rs.getString("name"));
//                        session.setAttribute("accountType", rs.getString("accountType"));
//
//                        // Check user type and redirect accordingly
//                        String accountType = rs.getString("accountType");
//
//                        if ("host".equalsIgnoreCase(accountType)) {
//                            response.sendRedirect("HostDashboard.jsp"); // Redirect to Host Dashboard
//                        } else if ("attendee".equalsIgnoreCase(accountType)) {
//                            response.sendRedirect("AttendeeDashboard.jsp"); // Redirect to Attendee Dashboard
//                        } else {
//                            // In case accountType doesn't match expected values
//                            response.getWriter().println("Unknown account type.");
//                        }
//                    } else {
//                        // Invalid credentials
//                        response.getWriter().println("Invalid email or password. Please try again.");
//                    }
//                }
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            response.getWriter().println("Database connection error: " + e.getMessage());
//        }
//    }
//}

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:mysql://localhost:3306/eventmanagement";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "Saijeevan@5689";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get login credentials from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            response.getWriter().println("Username and password are required.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
            // Query to check username and password
            String sql = "SELECT name, accountType FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password); // In production, replace with hashed password verification

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // If user is found, create a session and redirect to the appropriate dashboard
                        String name = rs.getString("name");
                        String accountType = rs.getString("accountType");

                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        session.setAttribute("name", name);
                        session.setAttribute("accountType", accountType);

                        // Check user type and redirect accordingly
                        if ("host".equalsIgnoreCase(accountType)) {
                            response.sendRedirect("HostDashboard.jsp");
                        } else if ("attendee".equalsIgnoreCase(accountType)) {
                            response.sendRedirect("AttendeeDashboardServlet");
                        } else {
                            response.getWriter().println("Unknown account type. Please contact support.");
                        }
                    } else {
                    	response.setContentType("text/html");
	               	    response.getWriter().println("<script type='text/javascript'>");
	               	    response.getWriter().println("alert('Invalid Username or Password');");
	               	    response.getWriter().println("window.location.href = 'Login.jsp';");
	               	    response.getWriter().println("</script>");
	               	    return;
                    }
                }
            }
        } catch (SQLException e) {
            // Log the error and return a generic error message
            e.printStackTrace();
            response.getWriter().println("An error occurred while processing your request. Please try again later.");
        }
    }
}
