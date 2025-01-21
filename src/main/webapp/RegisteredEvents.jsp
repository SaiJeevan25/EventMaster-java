<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.HashMap" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registered Events</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-gray-200 via-gray-300 to-gray-400 font-poppins">

    <header class="bg-gray-800 text-white bg-opacity-90 m-1 mt-2 p-4 rounded-lg shadow-8xl">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <h1 class="text-2xl pl-2 font-semibold"><a href="AttendeeDashboardServlet" class="hover:text-gray-600 transition duration-200">Attendee Dashboard</a></h1>
            <nav class="flex items-center space-x-6">
                <p class="text-xl font-medium"><%= session.getAttribute("name") %></p>
                <a href="Login.jsp" class="hover:text-indigo-200">Logout</a>
            </nav>
        </div>
    </header>

    <div class="max-w-4xl mx-auto p-8">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Your Registered Events</h2>

        <div class="space-y-6">
            <% 
                List<HashMap<String, String>> registeredEvents = (List<HashMap<String, String>>) request.getAttribute("registeredEvents");

                if (registeredEvents != null && !registeredEvents.isEmpty()) {
                    for (HashMap<String, String> event : registeredEvents) {
            %>
                <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-xl transition duration-200">
                    <h3 class="text-2xl font-semibold text-gray-800"><%= event.get("title") %></h3>
                    <p class="text-gray-600 mt-2"><%= event.get("description") %></p>
                    <p class="text-gray-600 mt-4">Date: <%= event.get("date") %> | Time: <%= event.get("time") %></p>
                    
                    <!-- Form to unregister from the event -->
                    <form action="EventRegistrationServlet" method="post" class="mt-4">
                        <input type="hidden" name="action" value="unregister" />
                        <input type="hidden" name="eventTitle" value="<%= event.get("title") %>" />
                        <button type="submit" class="inline-block px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-400 transition duration-200">
                            Unregister
                        </button>
                    </form>
                </div>
            <% 
                    }
                } else {
            %>
                <p class="text-xl font-medium text-center text-gray-700">No events registered yet.</p>
            <% 
                }
            %>
        </div>
    </div>
</body>
</html>
