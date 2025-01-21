<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

</head>
<body class="bg-gradient-to-br from-blue-300 via-blue-400 to-blue-500 font-poppins">
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
    %>
    <header class="bg-gray-800 text-white bg-opacity-90 m-1 mt-2 p-4 rounded-lg shadow-8xl ">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <p class="text-3xl pl-6 font-semibold text-white"><a href="HostDashboard.jsp" class="hover:text-gray-600  transition duration-200">Host Dashboard</a></p>
            <nav class="space-x-6 text-lg">
                <p class="text-xl font-medium"><%= name %></p>
            </nav>
        </div>
    </header>

    <div class="max-w-4xl mx-auto p-8">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Create a New Event</h2>
        <form method="POST" action="CreateEventServlet">
            <!-- Event Title -->
            <div class="mb-4 w-3/4 mx-auto flex flex-col">
                <label for="event-title" class="mb-2 text-lg">Event Title</label>
                <select id="event-title" name="event-title" class="border  shadow-xl p-2 rounded-md">
                    <option value="select" disabled selected>Select Event Type</option>
                    <option value="Conference">Conference</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Webinar">Webinar</option>
                    <option value="Party">Party</option>
                    <option value="custom">Custom</option>
                </select>
                <input type="text" id="custom-event-title" name="custom-event-title" class="border p-2 mt-2  shadow-xl rounded-md hidden" placeholder="Enter custom event title">
            </div>

            <div class="mb-4 w-3/4 mx-auto flex flex-col">
                <label for="event-date" class="mb-2 text-lg">Event Date</label>
                <input type="date" id="event-date" name="event-date" class="border shadow-xl p-2 rounded-md border  " required>
            </div>

            <div class="mb-4 w-3/4 mx-auto flex flex-col">
                <label for="event-time" class="mb-2 text-lg">Event Time</label>
                <input type="time" id="event-time" name="event-time" class="rounded-md border shadow-xl  p-2" required>
            </div>

            <div class="mb-4 w-3/4 mx-auto flex flex-col">
                <label for="event-description" class="mb-2 text-lg">Event Description</label>
                <textarea id="event-description" name="event-description" class="border shadow-xl  p-2 rounded-md" rows="4" required placeholder="Describe the event..."></textarea>
            </div>

        
            <div class="w-3/4 mx-auto">
                <button type="submit" class="bg-green-500 text-white pl-4 pr-4 p-2 text-lg  mx-auto flex flex-col rounded-md hover:bg-green-600 transition duration-150">Create Event</button>
            </div>
        </form>

        <script>
            document.getElementById('event-title').addEventListener('change', function() {
                const customEventTitle = document.getElementById('custom-event-title');
                if (this.value === 'custom') {
                    customEventTitle.classList.remove('hidden');
                } else {
                    customEventTitle.classList.add('hidden');
                }
            });
        </script>
        
    </div>

</body>
</html>