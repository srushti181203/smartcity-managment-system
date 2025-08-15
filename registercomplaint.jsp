<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit a Complaint</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            background: #ffffffee;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        h2 {
            text-align: center;
            color: #1e3c72;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus,
        textarea:focus {
            border-color: #0072ff;
            outline: none;
        }

        textarea {
            resize: vertical;
        }

        input[type="submit"] {
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: background 0.3s;
        }

        input[type="submit"]:hover {
            background: linear-gradient(135deg, #0072ff, #00c6ff);
        }

        @media (max-width: 600px) {
            .form-container {
                padding: 30px 20px;
            }

            h2 {
                font-size: 22px;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>📣 Submit a Complaint</h2>
        <form action="submit_complaint.jsp" method="post">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <label for="department">Department</label>
            <select name="department" id="department" required>
                <option value="">--Select Department--</option>
                <option value="Customer Service">Customer Service</option>
                <option value="Technical Support">Technical Support</option>
                <option value="Billing">Billing</option>
                <option value="Sales">Sales</option>
                <option value="Human Resources">Human Resources</option>
                <option value="IT">IT</option>
                <option value="Administration">Administration</option>
            </select>

            <label for="state">State</label>
            <input type="text" id="state" name="state" required>

            <label for="city">City</label>
            <input type="text" id="city" name="city" required>

            <label for="complaint">Complaint</label>
            <textarea name="complaint" id="complaint" rows="5" required></textarea>

            <input type="submit" value="Submit Complaint">
        </form>
    </div>
</body>
</html>
