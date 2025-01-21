<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

    
</head>
<body class="bg-gradient-to-br from-blue-300 via-purple-400 to-indigo-500 h-screen flex items-center justify-center font-poppins">

    <div class="w-full max-w-md p-8 bg-gray-900 bg-opacity-90 text-white rounded-xl shadow-lg">
        <h2 class="text-3xl font-semibold text-center">Register for an Account</h2>
        <form action="RegisterServlet" method="POST" class="mt-6">
            <label for="name" class="block text-sm font-medium text-gray-100">Full Name:</label>
            <input type="text" id="name" name="name" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
            
            <label for="email" class="block text-sm font-medium text-gray-100 mt-4">Username:</label>
            <input type="text" id="username" name="username" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
            
            <label for="password" class="block text-sm font-medium text-gray-100 mt-4">Password:</label>
            <input type="password" id="password" name="password" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
            
            <label for="accountType" class="block text-sm font-medium text-grey mt-4">Account Type:</label>
            <select id="accountType" name="accountType" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
                <option disabled selected>Select</option>
                <option value="host">Host</option>
                <option value="attendee">Attendee</option>
            </select>

            <button type="submit" class="w-full mt-6 py-2 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-800 focus:outline-none focus:ring-2 focus:ring-blue-500">Register</button>
        </form>
    </div>

</body>
</html>