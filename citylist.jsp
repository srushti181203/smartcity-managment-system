<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Smart Cities List</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f4f8;
            margin: 0;
            padding: 40px 0;
            color: #333;
        }
        h1 {
            color: #0a3d62;
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
            max-width: 900px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
            background: white;
        }
        th, td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid #e1e8f0;
            font-size: 1em;
        }
        th {
            background: #2980b9;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }
        tr:hover {
            background-color: #d6eaff;
        }
        tr:last-child td {
            border-bottom: none;
        }
        .error-row {
            text-align: center;
            color: #e74c3c;
            font-weight: 600;
            background: #fdecea;
        }
    </style>
</head>
<body>
    <h1>List of Smart Cities</h1>
    <table>
        <tr>
            <th>City ID</th>
            <th>City Name</th>
            <th>State</th>
        </tr>
        <%
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                st = con.createStatement();
                String sql = "SELECT c.cityid, c.cityname, s.statename FROM smartcities c " +
                             "JOIN smartstates s ON c.state = s.stateid";
                rs = st.executeQuery(sql);

                while(rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("cityid") %></td>
                <td><%= rs.getString("cityname") %></td>
                <td><%= rs.getString("statename") %></td>
            </tr>
        <%
                }
            } catch(Exception e) {
        %>
            <tr class="error-row"><td colspan="3">Error loading cities: <%= e.getMessage() %></td></tr>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (st != null) st.close(); } catch (Exception e) {}
                try { if (con != null) con.close(); } catch (Exception e) {}
            }
        %>
    </table>
</body>
</html>
