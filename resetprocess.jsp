<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.UUID"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Password Reset Request</title>
    <style>
        body {
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #222;
        }
        .container {
            background: #ffffffdd;
            padding: 35px 45px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            width: 400px;
            text-align: center;
        }
        h2 {
            color: #004a99;
            margin-bottom: 25px;
            font-weight: 700;
            letter-spacing: 1.1px;
        }
        p {
            font-size: 16px;
            line-height: 1.5;
            margin-top: 15px;
            color: #333;
        }
        b {
            color: #0066cc;
            word-break: break-all;
            font-size: 1.1em;
        }
        .error {
            color: #cc0000;
            font-weight: 700;
        }
        .success {
            color: #006600;
            font-weight: 700;
        }
    </style>
</head>
<body>
<div class="container">
<%
    String username = request.getParameter("username");

    if (username == null || username.trim().isEmpty()) {
%>
        <h2 class="error">Please provide a username.</h2>
<%
    } else {
        Connection con = null;
        PreparedStatement ps = null;

        // Generate a unique reset token (UUID)
        String resetToken = UUID.randomUUID().toString();

        try {
            con = DBConnection.getConnection();
            String sql = "INSERT INTO password_resets (username, reset_token) VALUES (?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, resetToken);

            int rows = ps.executeUpdate();
            if (rows > 0) {
%>
                <h2 class="success">Password reset requested successfully!</h2>
                <p>Use this reset token in your password reset link or email:</p>
                <p><b><%= resetToken %></b></p>
<%
            } else {
%>
                <h2 class="error">Failed to request password reset. Please try again.</h2>
<%
            }
        } catch (Exception e) {
%>
            <h2 class="error">Error: <%= e.getMessage() %></h2>
<%
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
%>
</div>
</body>
</html>
