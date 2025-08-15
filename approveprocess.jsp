<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Approval Process</title>
    <style>
        body {
            background: #e6f0ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 50px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }
        .container {
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 128, 0.15);
            text-align: center;
            max-width: 400px;
            width: 100%;
        }
        h2 {
            color: #0047b3;
            margin-bottom: 20px;
            font-weight: 700;
        }
        p {
            font-size: 18px;
            margin-bottom: 30px;
        }
        a {
            background: #0047b3;
            color: white;
            padding: 12px 25px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
            transition: background-color 0.3s ease;
            display: inline-block;
        }
        a:hover {
            background-color: #002d80;
        }
        .error {
            color: #b30000;
            font-weight: 600;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="container">
    <%
        String citizenid = request.getParameter("citizenid");
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("UPDATE smartcitizen SET approved=1 WHERE citizenid=?")) {
            ps.setString(1, citizenid);
            int result = ps.executeUpdate();
            if (result > 0) {
    %>
                <h2>Success!</h2>
                <p>Citizen approved successfully.</p>
                <a href="admin_approve.jsp">Back to Approvals</a>
    <%
            } else {
    %>
                <h2 class="error">Approval Failed</h2>
                <p>Unable to approve the citizen. Please try again.</p>
                <a href="admin_approve.jsp">Back to Approvals</a>
    <%
            }
        } catch (Exception e) {
    %>
            <h2 class="error">Error Occurred</h2>
            <p><%= e.getMessage() %></p>
            <a href="admin_approve.jsp">Back to Approvals</a>
    <%
        }
    %>
    </div>
</body>
</html>
