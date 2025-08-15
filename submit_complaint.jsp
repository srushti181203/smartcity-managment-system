<%@ page import="java.sql.*" %>
<%@ page import="javax.mail.*, javax.mail.internet.*" %>
<%@ page import="java.util.Properties" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complaint Submission Result - Smart City Portal</title>
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
        .success { color: green; }
        .error { color: red; }
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
    <h2>📣 Complaint Submission Result</h2>
<%
    // 1️⃣ Get parameters from form
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String department = request.getParameter("department");
    String state = request.getParameter("state");
    String city = request.getParameter("city");
    String complaint = request.getParameter("complaint");
    String userEmail = request.getParameter("email"); // email field from form

    boolean isValidUser = false;
    boolean isInserted = false;
    String resultMessage = "";

    Connection conn = null;
    PreparedStatement checkStmt = null;
    PreparedStatement insertStmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smartcity", "root", "Mysterycatx24");

        // 2️⃣ Check username and password in persons table
        String checkSql = "SELECT * FROM persons WHERE username = ? AND password = ?";
        checkStmt = conn.prepareStatement(checkSql);
        checkStmt.setString(1, username);
        checkStmt.setString(2, password);
        rs = checkStmt.executeQuery();

        if (rs.next()) {
            isValidUser = true;

            // 3️⃣ Insert complaint if valid
            String insertSql = "INSERT INTO complaints1 (username, password, department, state, city, complaint) VALUES (?, ?, ?, ?, ?, ?)";
            insertStmt = conn.prepareStatement(insertSql);
            insertStmt.setString(1, username);
            insertStmt.setString(2, password);
            insertStmt.setString(3, department);
            insertStmt.setString(4, state);
            insertStmt.setString(5, city);
            insertStmt.setString(6, complaint);
            int rows = insertStmt.executeUpdate();

            if (rows > 0) {
                isInserted = true;
                resultMessage = "✅ Complaint submitted successfully!";
            } else {
                resultMessage = "❌ Failed to submit complaint.";
            }
        } else {
            resultMessage = "❌ Wrong username or password!";
        }
    } catch (Exception e) {
        resultMessage = "⚠️ Database Error: " + e.getMessage();
    } finally {
        try { if (rs != null) rs.close(); if (checkStmt != null) checkStmt.close(); if (insertStmt != null) insertStmt.close(); if (conn != null) conn.close(); } catch (SQLException e) {}
    }

    out.println("<div class='message " + (isInserted ? "success" : "error") + "'>" + resultMessage + "</div>");

    // 4️⃣ Send email notification to provided email (userEmail)
    final String fromEmail = "srushtihv181203@gmail.com"; // Your email
    final String fromPassword = "dbvj lmsd ihsd umsr";     // App password
    String toEmail = "pawankalyan8043@gmail.com"; // send to the email they entered

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
        msg.setSubject("Complaint Submission Status - Smart City Portal");

        String body;
        if (isValidUser && isInserted) {
            body = "Hello " + username + ",\n\nYour complaint has been successfully submitted.\n\nDetails:\nDepartment: " + department + "\nState: " + state + "\nCity: " + city + "\nComplaint: " + complaint + "\n\nThank you,\nSmart City Team";
        } else if (!isValidUser) {
            body = "Hello " + username + ",\n\nYour complaint submission failed because the username or password you entered is incorrect.\n\nPlease try again.\n\nRegards,\nSmart City Team";
        } else {
            body = "Hello " + username + ",\n\nYour complaint submission failed due to an internal error.\n\nPlease try again later.\n\nRegards,\nSmart City Team";
        }

        msg.setText(body);
        Transport.send(msg);
%>
    <div class="message success">✅ Email notification sent to <%= toEmail %></div>
<%
    } catch (Exception e) {
%>
    <div class="message error">⚠️ Error sending email: <%= e.getMessage() %></div>
<%
    }
%>

    <a href="registercomplaint.jsp">🔙 Back to Complaint Form</a>
    <div class="footer">
        &copy; <%= java.time.Year.now() %> Smart City Portal
    </div>
</div>
</body>
</html>
