<%@page import="utils.DBConnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Approve Citizens</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #333;
            margin: 0;
            padding: 40px 0;
        }
        h2 {
            text-align: center;
            color: #fff;
            margin-bottom: 40px;
            text-shadow: 1px 1px 3px rgba(0,0,0,0.3);
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 90%;
            max-width: 900px;
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.25);
        }
        th, td {
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            font-size: 16px;
        }
        th {
            background: #5a4fcf;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        form {
            margin: 0;
        }
        input[type="submit"] {
            background-color: #6c63ff;
            border: none;
            padding: 8px 16px;
            color: white;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
        }
        input[type="submit"]:hover {
            background-color: #5145cd;
        }
        @media (max-width: 600px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }
            th {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tr {
                margin-bottom: 25px;
                background: white;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                border-radius: 8px;
                padding: 15px;
            }
            td {
                border: none;
                position: relative;
                padding-left: 50%;
                font-size: 14px;
            }
            td:before {
                position: absolute;
                top: 14px;
                left: 14px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                font-weight: 600;
                color: #555;
            }
            td:nth-of-type(1):before { content: "Name"; }
            td:nth-of-type(2):before { content: "City"; }
            td:nth-of-type(3):before { content: "Area"; }
            td:nth-of-type(4):before { content: "Email"; }
            td:nth-of-type(5):before { content: "Approve"; }
        }
    </style>
</head>
<body>
    <h2>Pending Citizen Approvals</h2>
    <table>
        <tr>
            <th>Name</th><th>City</th><th>Area</th><th>Email</th><th>Approve</th>
        </tr>
    <%
        try (Connection con = DBConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(
                 "SELECT c.citizenid, c.name, ci.cityname, c.area, c.email FROM smartcitizen c JOIN smartcities ci ON c.cityid = ci.cityid WHERE c.approved = 0")) {
            while (rs.next()) {
    %>
        <tr>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("cityname") %></td>
            <td><%= rs.getString("area") %></td>
            <td><%= rs.getString("email") %></td>
            <td>
                <form action="approveprocess.jsp" method="post">
                    <input type="hidden" name="citizenid" value="<%= rs.getString("citizenid") %>" />
                    <input type="submit" value="Approve" />
                </form>
            </td>
        </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='5' style='color:red; text-align:center;'>Error: " + e.getMessage() + "</td></tr>");
        }
    %>
    </table>
</body>
</html>
