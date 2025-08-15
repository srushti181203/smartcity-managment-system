<!DOCTYPE html>
<html>
<head>
    <title>Person Registration - Smart City Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .form-card {
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 12px 24px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            text-align: center;
            color: #1e3c72;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        input[type="submit"] {
            background: linear-gradient(to right, #00c6ff, #0072ff);
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background: linear-gradient(to right, #0072ff, #00c6ff);
        }
    </style>
</head>
<body>
    <div class="form-card">
        <h2>Register Person</h2>
        <form action="saveperson.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="tel" name="phone" placeholder="Phone">
            <input type="text" name="address" placeholder="Address">
            <input type="submit" value="Register">
        </form>
        <p style="text-align:center;">
            Already registered? <a href="login.jsp">Login here</a>
        </p>
    </div>
</body>
</html>
