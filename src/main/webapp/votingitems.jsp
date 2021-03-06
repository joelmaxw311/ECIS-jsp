<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
/* get search keywords and build an SQL query */
String param = request.getParameter("keywords");
String profileForm = "CONCAT("
        + "'<form class=\"form-inline\" method=\"post\" action=\"votingitem.jsp\">"
        + "<input type=\"hidden\" name=\"votingitemid\" value=\"', VotingItem.Id, '\" />"
        + "<button type=\"submit\" name=\"view\" class=\"btn btn-primary\">view</button>"
        + "</form>')";
String searchQuery = "SELECT " + profileForm + " AS Votes, Title, Description FROM VotingItem";
boolean haveKW = param != null && !param.isEmpty(); // are keywords given?
if (haveKW) {
    String[] criteria = { "title", "description" };
    List<String> criteriaConditions = new ArrayList();
    for (String k : param.split(", ")) {
        List<String> conditions = new ArrayList();
        for (String ok : k.split(" + ")) {
            List<String> orConditions = new ArrayList();
            for (String col : criteria) {
                String condition = col + " LIKE '%" + ok.trim() + "%'";
                orConditions.add(condition);
            }
            conditions.add("( " + String.join(" OR ", orConditions) + " )");
        }
        criteriaConditions.add("( " + String.join(" AND ", conditions) + " )");
    }
    searchQuery += " WHERE " + String.join(" OR ", criteriaConditions);
}
searchQuery = "SELECT `Votes`, `Title`, `Description` FROM ( " + searchQuery + " ) Filtered";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Browse Voting Items</title>
    <%@ include file="WEB-INF/head.html" %>
</head>
<body>    
    <p><small><a href="index.jsp">Home</a></small></p>
    <h1>Voting Items</h1>
    <form class="form-inline" method="post" action="votingitems.jsp">
        <input type="text" name="keywords" class="form-control" 
               placeholder="keywords, search phrases + sentences" value="<%=param%>" >
        <button type="submit" name="save" class="btn btn-primary">Search</button>
    </form>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", searchQuery); /* pass searchQuery to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
</body>
</html>
