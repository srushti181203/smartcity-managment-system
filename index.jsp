<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Smart City Portal</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 10%, transparent 10.01%) center/20px 20px;
            z-index: 0;
            animation: animateBackground 20s linear infinite;
        }

        @keyframes animateBackground {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .container {
            position: relative;
            z-index: 1;
            width: 520px;
            background: rgba(255, 255, 255, 0.95);
            padding: 45px 35px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.2);
            text-align: center;
            backdrop-filter: blur(10px);
        }

        h1 {
            font-size: 2.6rem;
            color: #1e3c72;
            margin-bottom: 25px;
            font-weight: 700;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.1);
            background: linear-gradient(90deg, #00c6ff, #0072ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        p {
            font-size: 1.1rem;
            color: #444;
            margin-bottom: 30px;
        }

        .nav-links {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 15px;
        }

        .nav-links a {
            background: linear-gradient(135deg, #FF6FD8, #3813C2);
            color: white;
            text-decoration: none;
            padding: 14px 20px;
            border-radius: 14px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 5px 15px rgba(56, 19, 194, 0.3);
        }

        .nav-links a:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #3813C2, #FF6FD8);
            box-shadow: 0 8px 20px rgba(255, 111, 216, 0.5);
        }

        .footer {
            margin-top: 30px;
            font-size: 0.85rem;
            color: #666;
            font-weight: 500;
        }

        /* Responsive */
        @media (max-width: 600px) {
            .container {
                width: 90%;
                padding: 30px 20px;
            }

            h1 {
                font-size: 2rem;
            }

            .nav-links {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🌆 Smart City Portal</h1>
        <p>
            A unified platform for Citizens, Officers, and Administrators.<br>
            Please choose your action below:
        </p>
        <div class="nav-links">
            <a href="login.jsp">🔐 Login</a>
            <a href="registerperson.jsp">📝 Register</a>
            <a href="citizenreg.jsp">👤 Citizen Registration</a>
            <a href="officerreg.jsp">🧑‍💼 Officer Registration</a>
            <a href="passwordreset.jsp">🔁 Reset Password</a>
            <a href="citylist.jsp">🏙️ List of Smart Cities</a>
            <a href="departments.jsp">🏢 Departments</a>
            <a href="registercomplaint.jsp">📣 Register Complaint</a>
        </div>
        <div class="footer">
            &copy; <%= java.time.Year.now() %> Smart City Portal. All rights reserved.
        </div>
    </div>
</body>
</html>
