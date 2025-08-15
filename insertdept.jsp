<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String deptName = request.getParameter("dept_name");
    String errorMessage = null;
    String successMessage = null;

    if (deptName != null) {
        deptName = deptName.trim();
        if (!deptName.isEmpty()) {
            try {
                Connection con = DBConnection.getConnection();

                // Check for existing department name
                PreparedStatement checkStmt = con.prepareStatement("SELECT COUNT(*) FROM departments WHERE dept_name = ?");
                checkStmt.setString(1, deptName);
                ResultSet rs = checkStmt.executeQuery();
                rs.next();
                int count = rs.getInt(1);
                rs.close();
                checkStmt.close();

                if (count > 0) {
                    errorMessage = "Department name already exists!";
                } else {
                    // Insert new department
                    PreparedStatement ps = con.prepareStatement("INSERT INTO departments (dept_name) VALUES (?)");
                    ps.setString(1, deptName);
                    ps.executeUpdate();
                    ps.close();
                    successMessage = "Department '" + deptName + "' added successfully!";
                }

                con.close();
            } catch (Exception e) {
                errorMessage = "Error: " + e.getMessage();
            }
        } else {
            errorMessage = "Department name cannot be empty.";
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Departments Management</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

        body {
            background: #eef2f7;
            font-family: 'Roboto', Arial, sans-serif;
            margin: 0;
            padding: 30px 0;
            color: #34495e;
        }
        center {
            max-width: 700px;
            margin: auto;
            background: #fff;
            padding: 35px 40px;
            border-radius: 14px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: 700;
            letter-spacing: 1.1px;
        }
        form {
            margin-bottom: 35px;
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        input[type="text"] {
            flex: 1 1 300px;
            padding: 12px 15px;
            border: 2px solid #3498db;
            border-radius: 8px;
            font-size: 1rem;
            outline-offset: 2px;
            transition: border-color 0.3s ease;
        }
        input[type="text"]:focus {
            border-color: #2980b9;
        }
        input[type="submit"] {
            background: #3498db;
            color: white;
            padding: 12px 28px;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        input[type="submit"]:hover {
            background: #2980b9;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 14px 18px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background: #3498db;
            color: white;
            font-weight: 700;
            letter-spacing: 0.05em;
        }
        tr:hover {
            background: #f0f8ff;
        }
        .message {
            font-weight: 600;
            margin-bottom: 25px;
            padding: 12px 18px;
            border-radius: 8px;
            width: fit-content;
            display: inline-block;
        }
        .error {
            background-color: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }
        .success {
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }
    </style>
</head>
<body>
    <center>
        <h1>Departments Management</h1>

        <% if (errorMessage != null) { %>
            <div class="message error"><%= errorMessage %></div>
        <% } else if (successMessage != null) { %>
            <div class="message success"><%= successMessage %></div>
        <% } %>

        <form action="insertdept.jsp" method="post" autocomplete="off">
            <input type="text" name="dept_name" placeholder="Enter Department Name" required />
            <input type="submit" value="Add Department" />
        </form>

        <table>
            <tr>
                <th>Dept ID</th>
                <th>Department Name</th>
            </tr>
            <%
            try {
                Connection con = DBConnection.getConnection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM departments ORDER BY dept_id");

                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("dept_id") %></td>
                <td><%= rs.getString("dept_name") %></td>
            </tr>
            <%
                }

                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
            %>
            <tr><td colspan="2" style="color: red;">Error loading departments: <%= e.getMessage() %></td></tr>
            <%
            }
            %>
        </table>
    </center>
</body>
</html>
