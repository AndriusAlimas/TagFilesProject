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
<c:set var="year" value="${(empty param['year']) ? 2006 : param['year'] }" />
<html>
    <head>
        <title>Calendars for year ${ year }</title>
        <%-- we making style for table and table cell --%>
        <style>
        	table {border-collapse: collapse; border: solid black 0.5pt;}
        	table td {width: 12pt; height: 12pt; border: solid black 0.5pt;}
        </style>       
    </head> 
    
    <body>
       <!-- HTML form for changing year/start day -->
       <form method="GET" action="">
       		<input type="text" maxlength="4" name="year" value="${year}" />
       		<select name="weekbegins">
       			<option value="1">Sunday</option>
       			<option value="2">Monday</option>
       			<option value="3">Tuesday</option>
       			<option value="4">Wednesday</option>
       			<option value="5">Thursday</option>
       			<option value="6">Friday</option>
       			<option value="7">Saturday</option>
       		</select>
       		<input type="submit" />
       </form>
       
       <%--Show the 12 months --%>
       <c:forEach begin="1" end="12" var="thisMonth">
       	<dates:calendar year="${year}"  month="${thisMonth}"  diary="${myplans}" varDay="todayNum"
       	 varEntries="dayEntries" startofweek="${(empty param['weekbegins']) ? 1 : param['weekbegins'] }">
       	 
       	 <%--Note that splitting the <span> opening element is BAD document syntax, but valid for a page --%>
       	 <span 
       	 <c:if test="${ !(empty dayEntries) }">
       	  style="background-color:yellow;"
       	 </c:if>
       	 >
       	 <a href="?year=${param['year'] }&month=${thisMonth}">
       	 		${todayNum }
       	 </a>
       	 </span>
       	 
      </dates:calendar>
     </c:forEach>
      
      <%-- The main calendar --%>
    <dates:calendarx year="${ param['year'] }" month="${ param['month'] }" diary="${ myplans }" 
    varDay="todayNum" varEntries="dayEntries">
  		<h3>${ todayNum }</h3>
  <c:if test="${ !(empty dayEntries) }">
    <c:forEach items="${ dayEntries }" var="thisEntry">
      ${ thisEntry },
    </c:forEach>
  </c:if>
  </dates:calendarx>

    </body>
</html>
