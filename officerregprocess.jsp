<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Officer Registration</title>
    <style>
        body {
            background: linear-gradient(135deg, #72edf2 10%, #5151e5 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }
        .message-box {
            background: rgba(0, 0, 0, 0.6);
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            text-align: center;
            width: 400px;
        }
        h2 {
            margin: 0 0 20px;
            font-weight: 700;
        }
        .success {
            color: #4caf50;
            text-shadow: 1px 1px 3px #2e7d32;
        }
        .error {
            color: #ff5252;
            text-shadow: 1px 1px 3px #b71c1c;
        }
        a.back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 25px;
            background: #fff;
            color: #5151e5;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s, color 0.3s;
        }
        a.back-link:hover {
            background-color: #5151e5;
            color: #fff;
        }
    </style>
</head>
<body>
    <div class="message-box">
    <%
        String name = request.getParameter("oname");
        String deptParam = request.getParameter("dept");
        String cityParam = request.getParameter("ocity");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (name == null || deptParam == null || cityParam == null || username == null || password == null ||
            name.trim().isEmpty() || deptParam.trim().isEmpty() || cityParam.trim().isEmpty() ||
            username.trim().isEmpty() || password.trim().isEmpty()) {
    %>
            <h2 class="error">Error: Missing required form data.</h2>
            <p>Please go back and fill out all fields.</p>
    <%
        } else {
            int deptId = Integer.parseInt(deptParam);
            int cityId = Integer.parseInt(cityParam);

            Connection con = null;
            PreparedStatement ps1 = null;
            PreparedStatement ps2 = null;

            try {
                con = DBConnection.getConnection();

                // Insert into officers table
                String sql1 = "INSERT INTO officers (name, deptid, cityid) VALUES (?, ?, ?)";
                ps1 = con.prepareStatement(sql1);
                ps1.setString(1, name);
                ps1.setInt(2, deptId);
                ps1.setInt(3, cityId);
                ps1.executeUpdate();

                // Insert into smartlogin table
                String sql2 = "INSERT INTO smartlogin (username, password, usertype, email) VALUES (?, ?, 'officer', '')";
                ps2 = con.prepareStatement(sql2);
                ps2.setString(1, username);
                ps2.setString(2, password);
                ps2.executeUpdate();
    %>
                <h2 class="success">Officer Registered Successfully!</h2>
                <p>Welcome <strong><%= name %></strong>, your account has been created.</p>
    <%
            } catch(Exception e) {
    %>
                <h2 class="error">Error:</h2>
                <p><%= e.getMessage() %></p>
    <%
                e.printStackTrace();
            } finally {
                try { if (ps1 != null) ps1.close(); } catch (Exception e) {}
                try { if (ps2 != null) ps2.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        }
    %>
        <a class="back-link" href="officerreg.jsp">Go Back</a>
    </div>
</body>
</html>
