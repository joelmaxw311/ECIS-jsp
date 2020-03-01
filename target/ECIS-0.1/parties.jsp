<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /* Build the SQL query */
    String testQuery = "SELECT * FROM PoliticalParty";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Political Parties</title>
    </head>
    <body>
        <h1>Political Parties</h1>
        <% /* Execute the query and display a table with results: */ %>
        <% session.setAttribute("query", testQuery); /* pass testQuery to query.jspf */ %>
        <%@ include file="WEB-INF/jspf/query.jspf" %>
    </body>
</html>
