<%@include file="jspf/taglibs.jspf"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="EDIT_EXERCISE"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jquery.ui.timepicker.css" rel="stylesheet">
        <link href="css/jquery.multiselect.css" rel="stylesheet">	
        <script src="js/jquery.ui.timepicker.js"></script>
        <script src="js/jquery.multiselect.min.js"></script>
        <script src="js/jquery.ui.datepicker-sr-SR.js"></script>
    <script>        
        $().ready(function(){
            $("#predmet").multiselect({
                multiple: false,
                header: false,
                noneSelectedText: "<fmt:message key="CHOOSE"/>",
                selectedList: 1
             });
             
             $("#datum").datepicker();
        
             $("#vremeod").timepicker({
                 hourText: '<fmt:message key="HOURS"/>',
                 minuteText: '<fmt:message key="MINUTES"/>',
                 showPeriodLabels: false
             });
             $("#vremedo").timepicker({
                 hourText: '<fmt:message key="HOURS"/>',
                 minuteText: '<fmt:message key="MINUTES"/>',
                 showPeriodLabels: false
             });
             
});
    </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="EDIT_EXERCISE"/></div>
        <form method="POST" action="CommandServlet?cmd=labvezba">
            <c:set var="predmeti" value="${korisnik.courses}"/> 
            <input type="hidden" name="vezbaid" value="${editable.id}">
            <div class="ui-widget-content">
             <table>
            <tr><td><label><fmt:message key="NAME"/>:</label></td><td><input type="text" name="naziv" value="${editable.name}"></td></tr>
            <tr><td><label><fmt:message key="DATE"/>:</label></td><td><input type="text" name="datum" id="datum" 
              value="<fmt:formatDate pattern="dd.MM.yyyy" value="${editable.date}"/>"></td></tr>
            <tr><td><label><fmt:message key="FROM"/>:</label></td><td><input type="text" name="vremeod" id="vremeod" value="<fmt:formatDate pattern="HH:mm" value="${editable.timeFrom}"/>"></td></tr>
            <tr><td><label><fmt:message key="TO"/>:</label></td><td><input type="text" name="vremedo" id="vremedo" value="<fmt:formatDate pattern="HH:mm" value="${editable.timeTo}"/>"></td></tr>
            <tr><td><label><fmt:message key="LABORATORY"/>:</label></td><td><input type="text" name="lab" value="${editable.laboratory}"></td></tr>
            <tr><td><label><fmt:message key="DEMO_NO"/>:</label></td>
            <td><input type="text" name="maxdemo" value="${editable.maxDemonstratorNo}"></td></tr>
            <tr><td><label><fmt:message key="COURSE"/>:</label></td><td>
            <select name="predmetid" id="predmet">
                <option><fmt:message key="CHOOSE"/></option>
               <c:forEach var="predmet" items="${predmeti}">
                   <c:choose>
                   <c:when test="${editable ne null and editable.course.id eq predmet.id}">
                       <c:set var="selected" value="selected"/>
                   </c:when>
                       <c:otherwise>
                          <c:set var="selected" value=""/> 
                       </c:otherwise>
                   </c:choose>
                <option value="${predmet.id}" ${selected}>${predmet.name}</option>     
               </c:forEach>
            </select></td></tr>
               <tr><td colspan="2"> <button type="submit" class="ui-state-active"><fmt:message key="SAVE"/></button></td></tr>
                </table>
            </div>  
        </form>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>