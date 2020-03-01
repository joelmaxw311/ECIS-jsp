<%@page import="java.sql.ResultSet"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
MySqlConnection server;
MySqlConnection.Database db = null;
String dbName = "ECIS";
String host = "css475groupproject.coqyi6uxbprc.us-east-1.rds.amazonaws.com";
int port = 3306;
String testQuery = "SELECT * FROM PoliticalParty";

server = new MySqlConnection(host, port);
ResultSet resultSet = null;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Political Parties</title>
    </head>
    <body>
    
        <h1>Political Parties</h1>
<table border="1">
<tr>
    <th>Id</th>
    <th>Name</th>
</tr>
<%
try{
    // Connect to database as read-only user (only SELECT permission)
    db = server.connect(dbName, "public", "password");
    // Execute query (testQuery) on database (db)
    resultSet = db.query(testQuery);
    while(resultSet.next()) {
%>
<tr>
    <td><%=resultSet.getString("ID") %></td>
    <td><%=resultSet.getString("Name") %></td>
</tr>
<%
    } // end while block
    db.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>
</table>
    
    </body>
</html>
