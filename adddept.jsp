<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Add Department</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(to right, #74ebd5, #acb6e5);
            margin: 0;
            padding: 0;
        }
        .container {
            text-align: center;
            padding: 60px;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
        form {
            background-color: white;
            display: inline-block;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        input[type="text"] {
            width: 250px;
            padding: 10px;
            border: 2px solid #74c0fc;
            border-radius: 6px;
            margin-right: 10px;
            font-size: 16px;
        }
        input[type="submit"] {
            padding: 10px 18px;
            background-color: #1d3557;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #457b9d;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            color: #1d3557;
            font-weight: bold;
        }
        a:hover {
            color: #e63946;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Add New Department</h1>
        <form action="insertdept.jsp" method="post">
            <input type="text" name="dept_name" placeholder="Enter department name" required>
            <input type="submit" value="Add Department">
        </form>
        <br>
        <a href="departments.jsp">← Back to Departments</a>
    </div>
</body>
</html>
