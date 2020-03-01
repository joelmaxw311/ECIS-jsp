<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ECIS</title>
    </head>
    <body>
        <h1>Election Candidate Information</h1>
        <div class="container">
            <form class="form-inline" method="post" action="parties.jsp">
                <button type="submit" name="save" class="btn btn-primary">View Political Parties</button>
            </form>
            <br>
            <form class="form-inline" method="post" action="candidates.jsp">
                <input type="text" name="keywords" class="form-control" placeholder="(leave blank for no filter)" >
                <button type="submit" name="save" class="btn btn-primary">Search Candidates</button>
            </form>
        </div>
    </body>
</html>
