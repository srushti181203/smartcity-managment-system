<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Smart City Portal</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            margin: 0;
            padding: 0;
            height: 100vh;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            font-family: 'Poppins', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .login-card {
            background: #ffffffee;
            padding: 40px 35px;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
            max-width: 400px;
            width: 100%;
            text-align: center;
            backdrop-filter: blur(10px);
        }

        h2 {
            margin-bottom: 20px;
            color: #1e3c72;
            font-size: 2rem;
            font-weight: 600;
            letter-spacing: 1px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 18px;
            margin-top: 15px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            padding: 12px 15px;
            border: 2px solid #1e3c72;
            border-radius: 8px;
            font-size: 1rem;
            outline: none;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #0072ff;
        }

        input[type="submit"] {
            background: linear-gradient(to right, #00c6ff, #0072ff);
            color: white;
            border: none;
            padding: 12px 0;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1.05rem;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        input[type="submit"]:hover {
            background: linear-gradient(to right, #0072ff, #00c6ff);
            transform: scale(1.02);
        }

        .register-link {
            margin-top: 20px;
            font-size: 0.95rem;
            color: #444;
        }

        .register-link a {
            color: #0072ff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: #00c6ff;
        }

        .footer {
            margin-top: 20px;
            font-size: 0.8rem;
            color: #777;
        }

        @media (max-width: 480px) {
            .login-card {
                padding: 30px 20px;
            }

            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-card">
        <h2>🔐 Smart City Login</h2>
        <form action="loginprocess.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required />
            <input type="email" name="email" placeholder="Email" required />
            <input type="password" name="password" placeholder="Password" required />
            <input type="submit" value="Login" />
        </form>
        <div class="register-link">
            New user? <a href="registerperson.jsp">Register here</a>
        </div>
        <div class="footer">
            &copy; <%= java.time.Year.now() %> Smart City Portal
        </div>
    </div>
</body>
</html>
