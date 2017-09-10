<%--This directive tag nearly same like page directive, has same attribute for example import
which we import Calanedar class because we will need it to work with dates --%>
<%@ tag import="java.util.Calendar" %>

<%-- we then import a couple of other tag libraries,JSTL Core and Formatting, which we use later
in the tag file. We do this with two taglib directives --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- Note these directives could be configured in the TLD instead, but here we use the container's
implicit TLD. We then configure all the attributes for this tag file, using attribute directive for each: --%>

<%-- an Integer specifying the year we want to display (e.g 2017) --%>
<%@ attribute name="year" require="true" type="java.lang.Integer"  description="Year of calendar" %>

<%-- an Integer specifying the month to be display; January has index 1, December is 12 --%>
<%@ attribute name="month" required="true" type="java.lang.Integer" description="Month of calendar"%>

<%--a String[][].The first dimension is the day of the month;i.e:diary.length should equal the number of the days
in specified month.For example like February some times have 28 or 29 days. The second dimension is an array of all
the entries for a particular day. So, diary[5] is a String[] of all entries for the 5th day of the month --%>
<%@ attribute name="diary" required="true" type="java.lang.String[][]" description="String[] entries for each day"%>

<%-- the starting day of the week, as to be displayed in the calendar. Use 1 for Sunday, 2 for Monday,...,7 for Saturday 
THIS IS OPTIONAL!!!--%>
<%@ attribute name="startofweek" required="false" type="java.lang.Integer" description="Start day of week (Sunday=1,
...,Saturday=7)"%>

<%-- For each day in the month, the tag make the diary String[] for that day available. This exported variable
has the name of the value of this varEntries attribute.--%>
<%@ attribute name="varEntries" required="true" rtexprvalue="false" description="Name for each day's exported entries"%>

<%--This is the name of the exported variable, in which the tag stores the current day number of the month
( starting at 1, with maximum possible value of 31). --%>
<%@ attribute name="varDay" required="true" rtexprvalue="false" description="Name for the day's exported number"%>
