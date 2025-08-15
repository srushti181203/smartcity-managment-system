<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Citizen Registration</title>
    <style>
        body {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
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
            background: rgba(255, 255, 255, 0.1);
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
            text-align: center;
            width: 350px;
        }
        h1 {
            margin-bottom: 30px;
            font-weight: 700;
            letter-spacing: 1.5px;
        }
        select {
            width: 100%;
            padding: 12px 10px;
            font-size: 16px;
            border-radius: 8px;
            border: none;
            outline: none;
            color: #333;
            background: #fff;
            transition: box-shadow 0.3s ease;
            cursor: pointer;
        }
        select:hover, select:focus {
            box-shadow: 0 0 8px #2575fc;
        }
        input[type="submit"] {
            margin-top: 25px;
            width: 100%;
            background-color: #2575fc;
            border: none;
            padding: 14px;
            color: white;
            font-size: 18px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #1759c1;
        }
        .error-option {
            color: #ff6b6b;
            font-weight: bold;
            cursor: default;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Citizen Registration</h1>
        <form action="citizenreg2.jsp" method="post">
            <label for="statename">Your State:</label><br><br>
            <select name="statename" id="statename" required>
                <%
                    Connection con = null;
                    Statement st = null;
                    ResultSet rs = null;
                    try {
                        con = DBConnection.getConnection();
                        st = con.createStatement();
                        rs = st.executeQuery("SELECT stateid, statename FROM smartstates");
                        while (rs.next()) {
                %>
                            <option value="<%= rs.getString("statename") %>"><%= rs.getString("statename") %></option>
                <%
                        }
                    } catch (Exception e) {
                %>
                        <option class="error-option">Error loading states</option>
                <%
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) {}
                        try { if (st != null) st.close(); } catch (Exception e) {}
                        try { if (con != null) con.close(); } catch (Exception e) {}
                    }
                %>
            </select>
            <input type="submit" value="Proceed" />
        </form>
    </div>
</body>
</html>
