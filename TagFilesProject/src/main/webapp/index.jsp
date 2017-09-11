<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--Note this is taglib directive but this time using attribute tagdir because of tag file location --%>
<%@ taglib tagdir="/WEB-INF/tags/mydates"  prefix="dates" %>

<%
	/*
	 Initialise example diary entires ( for every month)
	*/
	String[][] diary = new String[31][];
			 diary[5] = new String[]{"Anniversary"};
			 diary[18] = new String[]{"Business meeting"};
			 pageContext.setAttribute("myplans", diary);
%>
<%-- Obtain the year from a request parameter, or 2006 by default --%>
<<c:set var="year" value="${(empty param['year']) ? 2006 : param['year'] }" />
<html>
    <head>
        <title>Calendars for year ${ year }</title>
    </head> 
    <body>
        <h1>Hello World!</h1>
    </body>
    
</html>
