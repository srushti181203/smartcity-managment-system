<%@ page import="java.sql.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Result - Smart City Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .card {
            background: #ffffffee;
            padding: 40px 35px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
            max-width: 500px;
            width: 90%;
            text-align: center;
        }

        h2 {
            color: #1e3c72;
            margin-bottom: 20px;
            font-size: 2rem;
        }

        .message {
            margin-top: 20px;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .success {
            color: green;
        }

        .error {
            color: red;
        }

        a {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 20px;
            background: linear-gradient(to right, #00c6ff, #0072ff);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        a:hover {
            background: linear-gradient(to right, #0072ff, #00c6ff);
        }

        .footer {
            margin-top: 30px;
            font-size: 0.85rem;
            color: #666;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>🔐 Login Result</h2>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

    boolean isRegistered = false;
    String resultMessage = "";

    // Check DB
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/smartcity", "root", "Mysterycatx24"
        );

        String sql = "SELECT * FROM persons WHERE username = ? AND password = ? AND email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            isRegistered = true;
            resultMessage = "✅ Welcome, " + username + "! You have logged in successfully.";
        } else {
            resultMessage = "❌ Person not registered or wrong credentials!";
        }
    } catch (Exception e) {
        resultMessage = "⚠️ Error: " + e.getMessage();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {}
    }

    // Send email notification
    final String fromEmail = "srushtihv181203@gmail.com";     // your Gmail
    final String fromPassword = "dbvj lmsd ihsd umsr";        // Gmail App Password
    final String toEmail = email;                             // Notify user

    try {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, fromPassword);
            }
        };

        Session mailSession = Session.getInstance(props, auth);

        MimeMessage msg = new MimeMessage(mailSession);
        msg.setFrom(new InternetAddress(fromEmail, "Smart City Portal"));
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        msg.setSubject("Login Attempt Result - Smart City Portal");

        String body;
        if (isRegistered) {
            body = "Hello " + username + ",\n\nYour login was successful!\n\nSmart City Team";
        } else {
            body = "Hello " + username + ",\n\nYour login attempt failed. Wrong credentials or not registered.\n\nSmart City Team";
        }

        msg.setText(body);

        Transport.send(msg);
%>
    <div class="message success">✅ Email sent to <%= toEmail %></div>
<%
    } catch (Exception e) {
%>
    <div class="message error">⚠️ Error sending email: <%= e.getMessage() %></div>
<%
    }
%>

    <div class="message <%= isRegistered ? "success" : "error" %>">
        <%= resultMessage %>
    </div>

    <a href="login.jsp">🔙 Back to Login</a> | <a href="registerperson.jsp">📝 Register</a>
    <div class="footer">
        &copy; <%= java.time.Year.now() %> Smart City Portal
    </div>
</div>
</body>
</html>
