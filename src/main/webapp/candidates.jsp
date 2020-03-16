<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
/* get search keywords and build an SQL query */
String param = request.getParameter("keywords");
String searchQuery = "SELECT CONCAT('<a href=\"candidateprofile.jsp?candidateid=', Candidate.Id, '\">view</a>') AS Profile, FirstName AS `First Name`, MiddleName AS `Middle Name`, LastName AS `Last Name`, CONCAT(City, ', ', State.Name) AS `Location` "
		+ "FROM Candidate "
		+ "JOIN Location ON (Candidate.LocationId = Location.Id) "
                + "JOIN State ON (State.Id = Location.StateId) ";
boolean haveKW = param != null && !param.isEmpty(); // are keywords given?
if (haveKW) {
    String[] criteria = { "firstName", "middleName", "lastName", "State.id", "State.name" };
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
searchQuery = "SELECT `Profile`, CONCAT(`First Name`, IFNULL(CONCAT(' ', `Middle Name`, ' '), ' '), `Last Name`) AS Name, `Location` FROM ( " + searchQuery + " ) Filtered";
System.out.println(searchQuery);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Find a Candidate</title>
    <%@ include file="WEB-INF/head.html" %>
</head>
<body>
    <p><small><a href="index.jsp">Home</a></small></p>
    <h1>Candidates</h1>
    <form class="form-inline" method="post" action="candidates.jsp">
        <input type="text" name="keywords" class="form-control" 
               placeholder="keywords, search phrases + sentences" value="<%=param%>" >
        <button type="submit" name="save" class="btn btn-primary">Search</button>
    </form>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", searchQuery); /* pass searchQuery to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
</body>
</html>
