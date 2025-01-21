<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Host Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gradient-to-br from-teal-500 via-blue-500 to-indigo-600 h-screen font-poppins">

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

    <header class="bg-gray-800 text-white bg-opacity-90 m-1 mt-2 p-4 rounded-lg shadow-8xl">
        <div class="max-w-7xl mx-auto flex justify-between items-center">
            <p class="text-3xl pl-6 font-semibold text-white"><a href="HostDashboard.jsp" class="hover:text-gray-600 transition duration-200">Host Dashboard</a></p>
            <nav class="flex items-center space-x-6">
                <p class="text-xl font-medium"><%= name %></p>
                <a href="Login.jsp" class="hover:text-indigo-200 transition-colors duration-300">Logout</a>
            </nav>
        </div>
    </header>

    <div class="max-w-4xl mx-auto p-8">
        <h2 class="text-3xl font-bold text-center text-gray-900 mb-16 hover:underline">Welcome, <%= username %></h2>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-10">
            <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-2xl transition duration-200">
                <h2 class="text-xl font-semibold text-gray-800">Create Event</h2>
                <p class="text-gray-600 mt-2">Create new events and manage them easily from your dashboard.</p>
                <a href="CreateEvent.jsp" class="mt-4 inline-block px-4 py-2 bg-gray-800 text-white rounded-md hover:bg-teal-600 transition duration-200">Create Event</a>
            </div>

            <div class="bg-white p-6 rounded-lg shadow-md hover:shadow-2xl transition duration-200">
                <h2 class="text-2xl font-semibold text-gray-800">View Events</h2>
                <p class="text-gray-600 mt-2">View events you have created.</p>
                <a href="CreateEventServlet" class="mt-4 inline-block px-4 py-2 bg-gray-700 text-white rounded-md hover:bg-teal-600 transition duration-200">View Events</a>
            </div>
        </div>
    </div>
</body>
</html>
