<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            background: #f0f4ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 50px 0;
            color: #333;
        }
        center {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 40px 50px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        h1 {
            color: #4a4aff;
            margin-bottom: 10px;
            font-weight: 700;
        }
        h3 {
            color: #6666ff;
            margin-top: 0;
            margin-bottom: 40px;
            font-weight: 500;
        }
        h2 {
            color: #3333cc;
            margin-bottom: 25px;
            border-bottom: 2px solid #6666ff;
            padding-bottom: 8px;
            font-weight: 600;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: 0 6px 15px rgba(0,0,0,0.05);
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 15px 20px;
            text-align: left;
            font-size: 16px;
        }
        th {
            background-color: #4a4aff;
            color: white;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        tr:nth-child(even) {
            background-color: #f8f9ff;
        }
        tr:hover {
            background-color: #e6e9ff;
        }
        a {
            color: #4a4aff;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #1a1aff;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <center>
        <h1>Admin Control Panel</h1>
        <h3>Welcome, <%= session.getAttribute("username") %></h3>
        
        <h2>Management Options</h2>
        <table>
            <tr>
                <th>Manage</th>
                <th>Actions</th>
            </tr>
            <tr>
                <td>Cities</td>
                <td>
                    <a href="citylist.jsp">View All</a> | 
                    <a href="addcity.jsp">Add New</a>
                </td>
            </tr>
            <tr>
                <td>Departments</td>
                <td>
                    <a href="departments.jsp">View All</a> | 
                    <a href="adddept.jsp">Add New</a>
                </td>
            </tr>
            <tr>
                <td>Officers</td>
                <td>
                    <a href="officerlist.jsp">View All</a> | 
                    <a href="officerreg.jsp">Register New</a>
                </td>
            </tr>
            <tr>
                <td>Citizens</td>
                <td>
                    <a href="citizenapprove.jsp">Pending Approvals</a> | 
                    <a href="citizenlist.jsp">View All</a>
                </td>
            </tr>
        </table>
    </center>
</body>
</html>
