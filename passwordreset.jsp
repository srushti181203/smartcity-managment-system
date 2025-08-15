<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset</title>
    <style>
        body {
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }
        .reset-container {
            background: #ffffffdd;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            width: 350px;
            text-align: center;
        }
        h1 {
            color: #0066cc;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }
        form input[type="text"],
        form input[type="password"] {
            width: 90%;
            padding: 12px 15px;
            margin: 10px 0 20px 0;
            border: 2px solid #0066cc;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        form input[type="text"]:focus,
        form input[type="password"]:focus {
            outline: none;
            border-color: #004a99;
            box-shadow: 0 0 8px #004a99aa;
        }
        form input[type="submit"] {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 700;
            transition: background-color 0.3s;
        }
        form input[type="submit"]:hover {
            background-color: #004a99;
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <h1>Password Reset</h1>
        <form action="resetprocess.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="newpass" placeholder="New Password" required><br>
            <input type="password" name="confirmpass" placeholder="Confirm Password" required><br>
            <input type="submit" value="Reset Password">
        </form>
    </div>
</body>
</html>
