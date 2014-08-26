<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="ACTIVITY_TYPE"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $('#tabelatipova').dataTable();
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%> 
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="ACTIVITY_TYPE"/></div>
        <div class="ui-widget-content ui-corner-all">
            <c:set var="editable" value="${korisnik.admin}"/>
            
                <table class="display" id="tabelatipova">
                    <tr>
                        <th><fmt:message key="DESCRIPTION"/></th>
                        <th><fmt:message key="COEFFICIENT"/></th>
                    </tr>
                    <c:if test="${not empty lista}">
                    <c:forEach var="activity" items="${lista}">
                        <tr>
                            <td><c:if test="${editable}">
                                    <a href="CommandServlet?cmd=editaktivnost&id=${activity.id}">
                                    </c:if>
                                    <c:out value="${activity.name}" /> 
                                    <c:if test="${editable}">
                                    </a>
                                </c:if>
                            </td>
                            <td><c:out value="${activity.coefficient}"/></td>
                        </tr>
                    </c:forEach>
                    </c:if>
                    <tr><td colspan="2">
                            <c:if test="${editable}">      
                                <a href="CommandServlet?cmd=editaktivnost" style="text-decoration:none">
                                    <button class="ui-state-active"><fmt:message key="NEW"/> <fmt:message key="TYPE"/></button></a>
                                </c:if>
                        </td></tr>
                </table>
            

            <%@include file="jspf/footer.jspf"%> 
    </body>
</html>

