<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
/* get search keywords and build an SQL query */
String param = request.getParameter("keywords");
String[] keywords = param == null ? new String[0] : param.split(" ");
String searchQuery = "SELECT Id, FirstName, MiddleName, LastName FROM Candidate";
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
%>
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
        <input type="text" name="keywords" class="form-control" 
               placeholder="keywords" value="<%=String.join(" ", keywords)%>" >
        <button type="submit" name="save" class="btn btn-primary">Search</button>
    </form>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", searchQuery); /* pass searchQuery to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
    
    <h2>Locations</h2>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", "SELECT * FROM Location"); /* pass testQuery to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
</body>
</html>
