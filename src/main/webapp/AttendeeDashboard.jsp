<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendee Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-teal-300 via-blue-300 to-indigo-400 font-poppins">

    <% 
        // Retrieve the username from the session
        String name = (String) session.getAttribute("name");
        String username = (String) session.getAttribute("username");

        // Check if the user is logged in
        if (username == null) {
            // Redirect to login if the session is invalid
            response.sendRedirect("Login.jsp");
            return;
        }

        // Retrieve the list of events from the request
        List<HashMap<String, String>> events = (List<HashMap<String, String>>) request.getAttribute("events");
    %>

    <header class="bg-gray-800 text-white bg-opacity-90 m-1 mt-2 p-4 rounded-lg shadow-8xl">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <h1 class="text-2xl pl-2 font-semibold"><a href="AttendeeDashboardServlet" class="hover:text-gray-600 transition duration-200">Attendee Dashboard</a></h1>
            <nav class="flex items-center space-x-6">
                <p class="text-xl font-medium"><%= name %></p>
                <a href="EventRegistrationServlet" class="hover:text-indigo-200">Registered Events</a>
                <a href="Login.jsp" class="hover:text-indigo-200">Logout</a>
            </nav>
        </div>
    </header>

    <div class="max-w-7xl mx-auto p-10">
        <h2 class="text-4xl font-bold text-center text-gray-800 mb-10">Available Events</h2>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-10">
            
            <% 
                // If no events are found
                if (events == null || events.isEmpty()) {
            %>
                <div class="text-center text-gray-600 font-semibold">No events available at the moment.</div>
            <% 
                } else {
                    // Iterate over the list of events and display them
                    for (HashMap<String, String> event : events) {
            %>
                <form action="EventRegistrationServlet" method="POST">
                    <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-2xl transition duration-200">
                        <input type="hidden" name="action" value="register">
                        <input type="hidden" name="eventTitle" value="<%= event.get("eventTitle") %>">
                        <input type="hidden" name="eventDate" value="<%= event.get("eventDate") %>">
                        <input type="hidden" name="eventTime" value="<%= event.get("eventTime") %>">
                        <input type="hidden" name="eventDescription" value="<%= event.get("eventDescription") %>">
                        <h3 class="text-2xl font-semibold text-gray-800"><%= event.get("eventTitle") %></h3>
                        <p class="text-gray-600 mt-2"><%= event.get("eventDescription") %></p>
                        <p class="text-gray-600 mt-4">Date: <%= event.get("eventDate") %></p>
                        <p class="text-gray-600 mt-4">Time: <%= event.get("eventTime") %></p>
                        <button type="submit" class="mt-4 inline-block px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600">Register</button>
                    </div>
                </form>
            <% 
                    } 
                }
            %>
            
        </div>
    </div>

</body>
</html>
