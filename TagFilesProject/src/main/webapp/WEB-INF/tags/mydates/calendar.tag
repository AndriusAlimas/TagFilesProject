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

<%--Then we declare the exported variables for this tag ;these have the names given by the varEntries and varDay
attributes, and export String[] and Integer objects respectively --%>
<%@ variable name-from-attribute="varEntries" alias="entries" variable-class="java.lang.String[]" scope="NESTED"
description="Entries for the particular date"%>
<%@ variable name-from-attribute="varDay" alias="daynum" variable-class="java.lang.Integer" scope="NESTED"
description="Day of the month (1 up to 31)"%>

<%-- Scriplet initialisation code: JSP scripting elements are valid as content in tag files, 
     but not in the bodies of the actions they represent! --%>
     <% 
     /* Obtain the year and month as ints from the page-scoped attributes */
     int year = ((Integer)jspContext.getAttribute("year")).intValue();
     int month = ((Integer)jspContext.getAttribute("month")).intValue();
     
     Calendar cal = Calendar.getInstance();
     /* Set year and month (0 based) - default day to 1st of the month */
     cal.set(year,month-1,1);
     /* Store this in the page-scope to allow EL to access it */
     jspContext.setAttribute("calendar", cal);
     // We obtain the maximum day in this specific month - a value between 28 and 30. We store this in the maxday attribute, and 
     // also in a local variable of the same name:
    int maxday = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
    jspContext.setAttribute("maxday", maxday);
    
    /* NOTE: Although we probably shouldn't rely on this, DAY_OF_WEEK takes the value 1 for Sunday,
    2 for Monday ... up to 7 for Saturday. We will use this later */
    int startday = cal.get(Calendar.DAY_OF_WEEK);
    jspContext.setAttribute("startday", startday);
    		
    /* Convert textual 'startofweek' value into number */
    Integer startofweekobj = (Integer)jspContext.getAttribute("startofweek");
    // if attribute wasn't declared ( remember OPTIONAL), we give it default value of 1 (Sunday)
    int startofweek = (startofweekobj == null ? 1 : startofweekobj.intValue());
    jspContext.setAttribute("startofweek", startofweek);
    
    /* The 'startcondition' is an offset; it represents the index of the cell 
    just before the first cell to be filled. */
    int startcondition = (startday - startofweek) % 7;
    // if minus:
    	if(startcondition < 0){
    		startcondition += 7;
    	}
    /* The startcondition attribute stores the (1-BASED) index of the cell just before the cell at which the 1st of the 
    month will be dispplayed.This is also the number of cells skipped (left empty) in the first row
    
    */
     jspContext.setAttribute("startcondition",startcondition);
     %>
