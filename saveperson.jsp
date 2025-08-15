<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*, javax.mail.internet.*" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Result</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    Connection conn = null;
    PreparedStatement pstmt = null;
    boolean isInserted = false;
    String dbMessage = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/smartcity", "root", "Mysterycatx24"
        );

        String sql = "INSERT INTO persons (username, password, email, phone, address) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        pstmt.setString(3, email);
        pstmt.setString(4, phone);
        pstmt.setString(5, address);

        int rows = pstmt.executeUpdate();
        if (rows > 0) {
            isInserted = true;
            dbMessage = "✅ Registration successful!";
        } else {
            dbMessage = "❌ Registration failed. Please try again.";
        }
    } catch (Exception e) {
        dbMessage = "⚠️ Error: " + e.getMessage();
    } finally {
        try { if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); } catch (SQLException e) {}
    }

    // Send Email Notification
    final String fromEmail = "srushtihv181203@gmail.com";
    final String fromPassword = "dbvj lmsd ihsd umsr";
    final String toEmail = email;

    String subject;
    String emailBody;

    if (isInserted) {
        subject = "✅ Welcome to Smart City Portal!";
        emailBody = "Hello " + username + ",\n\n" +
                     "Thank you for registering at Smart City Portal.\n\n" +
                     "We are excited to have you onboard.\n\n" +
                     "Best Regards,\nSmart City Team";
    } else {
        subject = "⚠️ Registration Failed";
        emailBody = "Hello " + username + ",\n\n" +
                     "Unfortunately, your registration could not be completed.\n\n" +
                     "Error: " + dbMessage + "\n\n" +
                     "Please try again.\n\n" +
                     "Best Regards,\nSmart City Team";
    }

    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");
    props.put("mail.smtp.port", "587");
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");

    try {
        Authenticator auth = new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(fromEmail, fromPassword);
            }
        };

        Session mailSession = Session.getInstance(props, auth);

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(subject);
        message.setText(emailBody);

        Transport.send(message);
%>
    <h2><%= dbMessage %></h2>
    <p>📧 Email sent to <%= toEmail %></p>
<%
    } catch (Exception e) {
%>
    <h2><%= dbMessage %></h2>
    <p>⚠️ Failed to send email: <%= e.getMessage() %></p>
<%
    }
%>
    <a href="registerperson.jsp">🔙 Back to Registration</a> | <a href="login.jsp">🔑 Go to Login</a>
</body>
</html>
