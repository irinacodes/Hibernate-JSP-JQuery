<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="DEPARTMENT_LIST"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $('#tabelaodseka').dataTable();
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <div class="ui-state-active"><fmt:message key="DEPARTMENT_LIST"/></div>
        
            <div class="ui-widget-content ui-corner-all">
                <table class="display" id="tabelaodseka">
                    <tr>
                        <th><fmt:message key="NAME"/></th>
                    </tr>
                    <c:if test="${not empty lista}">
                    <c:forEach var="department" items="${lista}">
                        <tr>
                            <td>
                                <c:if test="${korisnik.admin}">  
                                    <a href="CommandServlet?cmd=editodsek&id=${department.id}">
                                    </c:if>
                                    ${department.name}
                                    <c:if test="${korisnik.admin}">  
                                    </a>
                                </c:if></td>
                        </tr>
                    </c:forEach>
                    </c:if>
                    <tr><td colspan="2">
                            <c:if test="${korisnik.admin}">  
                                <a href="CommandServlet?cmd=editodsek" style="text-decoration:none">
                                    <button class="ui-state-active"><fmt:message key="NEW"/>&nbsp;<fmt:message key="DEPARTMENT"/></button></a>
                                </c:if>
                        </td></tr>
                </table>
            
        </div>

        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>

