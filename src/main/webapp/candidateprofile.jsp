<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Objects"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="css475.dropstudents.ecis.MySqlConnection"%>
<%
/* get search keywords and build an SQL query */
String param = request.getParameter("candidateid");
String basicQuery = "SELECT CONCAT(FirstName) 'First Name', CONCAT(MiddleName) 'Middle Name', CONCAT(LastName) 'Last Name', "
		+ "IFNULL(PoliticalParty.Name, 'No Party Affiliation') as Party, City, CONCAT(StateId) AS 'State' "
		+ "FROM Candidate "
		+ "JOIN Location ON (Candidate.LocationId = Location.Id) "
		+ "LEFT JOIN PoliticalParty ON (Candidate.PartyId = PoliticalParty.Id)";
basicQuery += " WHERE Candidate.ID = " + param;
String contactQuery = "SELECT Phone, Email, Website "
		+ "FROM Candidate";
contactQuery += " WHERE Candidate.ID = " + param;
String votingQuery = "SELECT Title, Description, Choice "
		+ "FROM VotingItem "
		+ "	JOIN VotingRecord ON (VotingRecord.BillId = VotingItem.Id) "
		+ " JOIN Candidate ON (VotingRecord.CandidateId = Candidate.Id) "
		+ " JOIN Vote ON (VotingRecord.VoteId = Vote.ID)";
votingQuery += " WHERE Candidate.ID = " + param;
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
    <h1>Candidate Basic Info</h1>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", basicQuery); /* pass query to query.jspf */ %>
	<%@ include file="WEB-INF/jspf/query.jspf" %>
    <h1>Contact Info</h1>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", contactQuery); /* pass query to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
	<h2>Voting History</h2>
    <% /* Execute the query and display a table with results: */ %>
    <% session.setAttribute("query", votingQuery); /* pass query to query.jspf */ %>
    <%@ include file="WEB-INF/jspf/query.jspf" %>
</body>
</html>
