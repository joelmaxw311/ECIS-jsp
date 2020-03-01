<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
MySqlConnection server;
MySqlConnection.Database db = null;
String dbName = "ECIS";
String host = "css475groupproject.coqyi6uxbprc.us-east-1.rds.amazonaws.com";
int port = 3306;
String param = request.getParameter("keywords");
String[] keywords = param == null ? new String[0] : param.split(" ");
String searchQuery = "SELECT * FROM Candidate";
boolean haveKW = keywords != null && keywords.length > 0; // are keywords given?
if (haveKW) {
    String[] criteria = { "firstName", "middleName", "lastName" };
    List<String> conditions = new ArrayList();
    for (String col : criteria) {
        for (String k : keywords) {
            String condition = col + " LIKE '%" + k + "%'";
            conditions.add(condition);
        }
    }
    searchQuery += " WHERE " + String.join(" OR ", conditions);
}
if (keywords == null) {
    keywords = new String[0];
}

server = new MySqlConnection(host, port);
ResultSet resultSet = null;
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Find a Candidate</title>
    </head>
    <body>
    
<h1>Candidates</h1>
<form class="form-inline" method="post" action="candidates.jsp">
    <input type="text" name="keywords" class="form-control" placeholder="keywords" value=<% out.print("\"" + String.join(" ", keywords) + "\""); %> >
<button type="submit" name="save" class="btn btn-primary">Search</button>
</form>
<table border="1">
<tr>
    <th>Id</th>
    <th colspan="3">Name</th>
</tr>
<%
try{
    // Connect to database as read-only user (only SELECT permission)
    db = server.connect(dbName, "public", "password");
    // Execute query (testQuery) on database (db)
    resultSet = db.query(searchQuery);
    while(resultSet.next()) {
%>
<tr>
    <td><%=resultSet.getString("ID") %></td>
    <td><%=resultSet.getString("FirstName") %></td>
    <td><%=Objects.toString(resultSet.getString("MiddleName"),"") %></td>
    <td><%=resultSet.getString("LastName") %></td>
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
