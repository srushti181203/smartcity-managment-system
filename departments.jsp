<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Department Management</title>
    <style>
        body {
            background-color: #f4f7f9;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 40px 0;
            color: #2c3e50;
        }
        h1 {
            color: #2980b9;
            font-weight: 700;
            margin-bottom: 30px;
        }
        table {
            border-collapse: collapse;
            width: 70%;
            max-width: 700px;
            margin: 0 auto;
            background: white;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        th, td {
            padding: 14px 20px;
            text-align: left;
            border-bottom: 1px solid #e3e8ee;
            font-size: 1.1em;
        }
        th {
            background-color: #3498db;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.1em;
        }
        tr:hover {
            background-color: #d6eaff;
            cursor: default;
        }
        tr:last-child td {
            border-bottom: none;
        }
        .error-row {
            text-align: center;
            color: #c0392b;
            background: #fdecea;
            font-weight: 600;
        }
        a {
            display: inline-block;
            margin-top: 25px;
            padding: 10px 25px;
            background-color: #2980b9;
            color: white;
            font-weight: 600;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #1f618d;
        }
        center {
            text-align: center;
        }
    </style>
</head>
<body>
    <center>
        <h1>Departments</h1>
        <table>
            <tr>
                <th>Dept ID</th>
                <th>Department Name</th>
            </tr>
            <%
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    con = DBConnection.getConnection();
                    st = con.createStatement();
                    rs = st.executeQuery("SELECT * FROM department");
                    while(rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("dept_id") %></td>
                <td><%= rs.getString("dept_name") %></td>
            </tr>
            <%
                    }
                } catch(Exception e) {
            %>
            <tr class="error-row"><td colspan="2">Error loading departments: <%= e.getMessage() %></td></tr>
            <%
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (st != null) st.close(); } catch (Exception e) {}
                    try { if (con != null) con.close(); } catch (Exception e) {}
                }
            %>
        </table>
        <a href="adddept.jsp">Add New Department</a>
    </center>
</body>
</html>
