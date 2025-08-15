<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Process</title>
    <style>
        body {
            background: linear-gradient(135deg, #74ebd5 0%, #ACB6E5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .message-box {
            background: rgba(0,0,0,0.5);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.6);
            text-align: center;
            width: 400px;
        }
        h2 {
            font-weight: 700;
            font-size: 1.6em;
            margin-bottom: 25px;
            color: #f0f8ff;
        }
        a {
            display: inline-block;
            background-color: #43cea2;
            color: #fff;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            margin-top: 15px;
        }
        a:hover {
            background-color: #2e8b57;
        }
    </style>
</head>
<body>
<div class="message-box">
<%
    String name = request.getParameter("cname");
    String gender = request.getParameter("cgender");
    String city = request.getParameter("ccity");
    String area = request.getParameter("carea");
    String phone = request.getParameter("cphone");
    String email = request.getParameter("cemail");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection();

        // Insert into smartcitizen1
        String sql = "INSERT INTO smartcitizen1 (name, gender, city, area, phone, email, approved) VALUES (?, ?, ?, ?, ?, ?, 0)";
        ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, name);
        ps.setString(2, gender);
        ps.setString(3, city);
        ps.setString(4, area);
        ps.setString(5, phone);
        ps.setString(6, email);

        int result = ps.executeUpdate();

        if (result > 0) {
            // Insert login credentials using email as username
            PreparedStatement ps2 = con.prepareStatement(
                "INSERT INTO smartlogin (username, password, usertype) VALUES (?, ?, ?)"
            );
            ps2.setString(1, email); // use email as username
            ps2.setString(2, "default123"); // default password
            ps2.setString(3, "citizen");
            ps2.executeUpdate();
            ps2.close();
%>
            <h2>🎉 Registration successful! Await admin approval.</h2>
            <a href="index.jsp">Go to Home</a>
<%
            // Send Email Notification
            final String fromEmail = "srushtihv181203@gmail.com";     // your Gmail
            final String fromPassword = "dbvj lmsd ihsd umsr";  
            final String toEmail = email;

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, fromPassword);
                }
            });

            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(fromEmail, "Smart City Portal"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Smart City Portal - Registration Confirmation");

            String body = "Hello " + name + ",\n\n"
                        + "Thank you for registering with the Smart City Portal.\n"
                        + "Your registration was successful and is pending admin approval.\n\n"
                        + "Your login username is: " + email + "\n"
                        + "Your default password is: default123\n\n"
                        + "Regards,\nSmart City Team";

            message.setText(body);
            Transport.send(message);
%>
            <h2>✅ Confirmation Email Sent to <%= email %></h2>
<%
        } else {
%>
            <h2>❌ Registration failed. Please try again.</h2>
            <a href="citizenreg.jsp">Try Again</a>
<%
        }
    } catch (Exception e) {
%>
        <h2>⚠️ Error: <%= e.getMessage() %></h2>
        <a href="citizenreg.jsp">Back to Registration</a>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>
</div>
</body>
</html>
