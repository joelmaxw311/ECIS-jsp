<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
{
/* get search keywords and build an SQL query */
String paramName = "keywords";
String param = request.getParameter(paramName);
String heading = "Candidates";
String[] criteria = { "firstName", "middleName", "lastName", "City", "State.name", "State.id", "CONCAT(City, ' ', State.name)" };

/* Execute the query and display a table with results: */
session.setAttribute("paramName", paramName); /* pass to candidates.jspf */
session.setAttribute("heading", heading); /* pass to candidates.jspf */
session.setAttribute("searchParam", param); /* pass to candidates.jspf */
session.setAttribute("criteriaColumns", criteria); /* pass to candidates.jspf */
}
%>
<%@ include file="WEB-INF/jspf/candidates.jspf" %>
