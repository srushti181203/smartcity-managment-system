<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Officer Registration</title>
    <style>
        body {
            background: linear-gradient(135deg, #89f7fe 0%, #66a6ff 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #222;
        }
        .container {
            background: white;
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #0652DD;
            margin-bottom: 25px;
            font-weight: 700;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label, select, input[type="text"], input[type="password"] {
            font-size: 1rem;
            margin-bottom: 15px;
        }
        input[type="text"], input[type="password"], select {
            padding: 10px;
            border-radius: 8px;
            border: 1.5px solid #ddd;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus, input[type="password"]:focus, select:focus {
            border-color: #0652DD;
            outline: none;
        }
        input[type="submit"] {
            background-color: #0652DD;
            color: white;
            font-weight: 600;
            padding: 12px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #054bb5;
        }
        /* Add spacing labels for inputs */
        label {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .field-group {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>New Officer Registration</h1>
        <form action="officerregprocess.jsp" method="post">
            <div class="field-group">
                <label for="oname">Full Name:</label>
                <input type="text" id="oname" name="oname" required>
            </div>

            <div class="field-group">
                <label for="dept">Department:</label>
                <select id="dept" name="dept" required>
                    <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    try {
                        con = DBConnection.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("SELECT dept_id, dept_name FROM department");
                        while (rs.next()) {
                    %>
                        <option value="<%= rs.getInt("dept_id") %>"><%= rs.getString("dept_name") %></option>
                    <%
                        }
                    } catch (Exception e) {
                        out.println("<option disabled>Error loading departments</option>");
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (st != null) st.close(); } catch (Exception e) {}
                        try { if (con != null) con.close(); } catch (Exception e) {}
                    }
                    %>
                </select>
            </div>

            <div class="field-group">
                <label for="ocity">City:</label>
                <select id="ocity" name="ocity" required>
                    <%
                    Connection con2 = null;
                    Statement st2 = null;
                    ResultSet rs2 = null;
                    try {
                        con2 = DBConnection.getConnection();
                        st2 = con2.createStatement();
                        rs2 = st2.executeQuery("SELECT cityid, cityname FROM smartcities");
                        while (rs2.next()) {
                    %>
                        <option value="<%= rs2.getInt("cityid") %>"><%= rs2.getString("cityname") %></option>
                    <%
                        }
                    } catch (Exception e) {
                        out.println("<option disabled>Error loading cities</option>");
                        e.printStackTrace();
                    } finally {
                        try { if (rs2 != null) rs2.close(); } catch (Exception e) {}
                        try { if (st2 != null) st2.close(); } catch (Exception e) {}
                        try { if (con2 != null) con2.close(); } catch (Exception e) {}
                    }
                    %>
                </select>
            </div>

            <div class="field-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>

            <div class="field-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <input type="submit" value="Register Officer">
        </form>
    </div>
</body>
</html>
