<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int deptId = 0;
    String deptName = null;
    String message = null;
    boolean success = false;

    try {
        deptId = Integer.parseInt(request.getParameter("deptid"));
        deptName = request.getParameter("deptname");

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "UPDATE departments SET deptname=? WHERE deptid=?")) {
            ps.setString(1, deptName);
            ps.setInt(2, deptId);
            int rows = ps.executeUpdate();
            if (rows > 0) {
                message = "Department updated successfully!";
                success = true;
            } else {
                message = "No department found with ID: " + deptId;
            }
        }
    } catch(Exception e) {
        message = "Error updating department: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Department</title>
    <style>
        body {
            background: #e0f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .message-box {
            background: white;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            text-align: center;
            max-width: 400px;
        }
        h1 {
            font-weight: 700;
            margin-bottom: 20px;
            color: <%=(success ? "#00796b" : "#c62828")%>;
        }
        p {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
        }
        .redirect-info {
            font-size: 14px;
            color: #555;
        }
    </style>
    <meta http-equiv="refresh" content="3;URL=departments.jsp" />
</head>
<body>
    <div class="message-box">
        <h1><%= success ? "Success!" : "Oops!" %></h1>
        <p><%= message %></p>
        <p class="redirect-info">You will be redirected shortly...</p>
    </div>
</body>
</html>
