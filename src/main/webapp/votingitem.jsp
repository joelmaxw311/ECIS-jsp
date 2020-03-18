<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
/* get search keywords and build an SQL query */
String param = request.getParameter("votingitemid");
String candidateForm = "CONCAT("
        + "'<form class=\"form-inline\" method=\"post\" action=\"candidateprofile.jsp\">"
        + "<input type=\"hidden\" name=\"candidateid\" value=\"', Candidate.Id, '\" />"
        + "<button type=\"submit\" name=\"view\" class=\"btn btn-primary\">view</button>"
        + "</form>')";
String basicQuery = "SELECT Title, Description "
		+ "FROM VotingItem ";
basicQuery += " WHERE VotingItem.ID = " + param;
String contactQuery = "SELECT "
            + candidateForm + " AS Profile,"
            + " CONCAT(FirstName, IFNULL(CONCAT(' ', MiddleName, ' '), ' '), LastName) AS Name,"
            + " Choice "
        + " FROM VotingItem"
            + " JOIN VotingRecord ON (VotingRecord.BillId = VotingItem.Id)"
            + " JOIN Candidate ON (VotingRecord.CandidateId = Candidate.Id)"
            + " JOIN Vote ON (VotingRecord.VoteId = Vote.Id)";
contactQuery += " WHERE VotingItem.ID = " + param;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Candidate Profile</title>
    <%@ include file="WEB-INF/head.html" %>
</head>
<body>   
    <p><small><a href="index.jsp">Home</a></small></p>
    <h1>Voting Item</h1>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", basicQuery); /* pass query to query.jspf */ %>
	<%@ include file="WEB-INF/jspf/query.jspf" %>
    <h1>Candidate Votes</h1>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", contactQuery); /* pass query to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
</body>
</html>
