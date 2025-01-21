<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Events</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-indigo-200 via-indigo-300 to-indigo-400 h-screen font-poppins">
    <% 
        // Retrieve the list of events from the request
        List<HashMap<String, String>> events = (List<HashMap<String, String>>) request.getAttribute("events");

        // Check if there are no events
        if (events == null || events.isEmpty()) {
    %>
    <div class="max-w-4xl mx-auto p-8">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">No Events Available</h2>
    </div>
    <% } else { %>

    <header class="bg-gray-800 text-white bg-opacity-90 m-1 mt-2 p-4 rounded-lg shadow-8xl">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <p class="text-3xl pl-6 font-semibold text-white"><a href="HostDashboard.jsp" class="hover:text-gray-600 transition duration-200">Host Dashboard</a></p>
            <nav class="space-x-6 text-lg">
                <p class="text-xl font-medium"><%= session.getAttribute("name") %></p>
            </nav>
        </div>
    </header>

    <div class="max-w-4xl mx-auto p-8">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Your Events</h2>

        <table class="min-w-full bg-white shadow-lg rounded-lg">
            <thead class="bg-indigo-600 text-white">
                <tr>
                    <th class="py-3 px-6 text-left">Event Name</th>
                    <th class="py-3 px-6 text-left">Date</th>
                    <th class="py-3 px-6 text-left">Time</th>
                    <th class="py-3 px-6 text-left">Description</th>
                </tr>
            </thead>
            <tbody class="text-gray-700">
                <% 
                    // Iterate over the list of events and display them
                    for (HashMap<String, String> event : events) {
                %>
                <tr class="border-b">
                    <td class="py-3 px-6"><%= event.get("eventTitle") %></td>
                    <td class="py-3 px-6"><%= event.get("eventDate") %></td>
                    <td class="py-3 px-6"><%= event.get("eventTime") %></td>
                    <td class="py-3 px-6"><%= event.get("eventDescription") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</body>
</html>
