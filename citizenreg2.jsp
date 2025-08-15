<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Citizen Registration - Step 2</title>
    <style>
        body {
            background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #fff;
        }
        .container {
            background: rgba(255, 255, 255, 0.15);
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.4);
            width: 400px;
            text-align: center;
        }
        h1 {
            margin-bottom: 30px;
            font-weight: 700;
            font-size: 1.8em;
            letter-spacing: 1.2px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            color: #fff;
        }
        label {
            font-weight: 600;
            margin-bottom: 6px;
            text-align: left;
        }
        input[type="text"], input[type="email"], select {
            padding: 10px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
            color: #333;
        }
        input[type="text"]:focus, input[type="email"]:focus, select:focus {
            box-shadow: 0 0 8px #43cea2;
            background: #fff;
        }
        input[type="submit"] {
            margin-top: 20px;
            background-color: #185a9d;
            color: white;
            font-weight: 700;
            padding: 12px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #0f3c66;
        }
        .form-group {
            display: flex;
            flex-direction: column;
            text-align: left;
        }
    </style>
</head>
<body>
<%
    String state_name = request.getParameter("statename");
%>
<div class="container">
    <h1>Citizen Registration - <%= state_name %></h1>
    <form action="citizenregprocess.jsp" method="post">
        <div class="form-group">
            <label for="cname">Name:</label>
            <input type="text" id="cname" name="cname" required />
        </div>

        <div class="form-group">
            <label for="cgender">Gender:</label>
            <select name="cgender" id="cgender">
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </div>

        <div class="form-group">
            <label for="ccity">City:</label>
            <select name="ccity" id="ccity" required>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DBConnection.getConnection();
                    String sql = "SELECT cityid, cityname FROM smartcities WHERE state = (SELECT stateid FROM smartstates WHERE statename = ?)";
                    ps = con.prepareStatement(sql);
                    ps.setString(1, state_name);
                    rs = ps.executeQuery();

                    while (rs.next()) {
            %>
                        <option value="<%= rs.getInt("cityid") %>"><%= rs.getString("cityname") %></option>
            <%
                    }
                } catch (Exception e) {
            %>
                    <option>Error loading cities</option>
            <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (con != null) con.close(); } catch (Exception e) {}
                }
            %>
            </select>
        </div>

        <div class="form-group">
            <label for="carea">Area:</label>
            <input type="text" id="carea" name="carea" required />
        </div>

        <div class="form-group">
            <label for="cphone">Phone:</label>
            <input type="text" id="cphone" name="cphone" required />
        </div>

        <div class="form-group">
            <label for="cemail">Email:</label>
            <input type="email" id="cemail" name="cemail" required />
        </div>

        <input type="submit" value="Register" />
    </form>
</div>
</body>
</html>
