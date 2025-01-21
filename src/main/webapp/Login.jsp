<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-blue-400 via-teal-400 to-green-500 h-screen flex items-center justify-center font-poppins">
    <div class="w-full max-w-md p-8 bg-gray-800 bg-opacity-90 rounded-xl shadow-2xl">
        <h2 class="text-3xl font-semibold text-center text-gray-100">Login to Your Account</h2>
        <form action="LoginServlet" method="POST" class="mt-6">
            <label for="email" class="block text-sm font-medium text-gray-200">Username:</label>
            <input type="text" id="username" name="username" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
            
            <label for="password" class="block text-sm font-medium text-gray-200 mt-4">Password:</label>
            <input type="password" id="password" name="password" required class="w-full px-4 py-2 mt-2 bg-gray-600 text-white border border-gray-400 rounded-md focus:outline-none focus:ring-2 focus:ring-teal-400">
            
            <button type="submit" class="w-full mt-6 py-2 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500">Login</button>
            
            <p class="text-center text-white mt-4">Don't have an account? 
                <a href="Register.jsp" class="text-green-500 hover:underline">Sign Up</a>
            </p>
        </form>
    </div>
</body>
</html>