<%@include file="jspf/taglibs.jspf"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="EXERCISE_LIST"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $('#tabelavezbi').dataTable();
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%> 
        <div class="ui-state-active"><fmt:message key="EXERCISE_LIST"/></div>
        <div class="ui-widget-content ui-corner-all">
            <c:set var="editable" value="${korisnik.instructor and not korisnik.admin}"/>
            <c:choose>
                <c:when test="${not empty lista}">
                    <table class="display" id="tabelavezbi">
                        <tr>
                            <th><fmt:message key="PERSONAL_NAME"/></th>
                            <th><fmt:message key="COURSE"/></th>
                            <th><fmt:message key="DATE"/></th>
                            <th><fmt:message key="FROM"/></th>
                            <th><fmt:message key="TO"/></th>
                            <th><fmt:message key="LABORATORY"/></th>
                            <th><fmt:message key="DEMONSTRATORS"/></th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                            <th>&nbsp;</th>
                        </tr>
                        <c:forEach var="vezba" items="${lista}">
                            <tr>
                                <td>
                                    <c:if test="${editable and not vezba.locked}">

                                        <a href="CommandServlet?cmd=editlabvezba&id=${vezba.id}">
                                        </c:if>
                                        ${vezba.name}
                                        <c:if test="${editable and not vezba.locked}">
                                        </a>
                                    </c:if>
                                    &nbsp;
                                </td>
                                <td>${vezba.course.name}</td>
                                <td><fmt:formatDate pattern="dd.MM.yyyy" value="${vezba.date}"/></td>
                                <td><fmt:formatDate type="time" pattern="HH:mm" value="${vezba.timeFrom}"/></td>
                                <td><fmt:formatDate type="time" pattern="HH:mm" value="${vezba.timeTo}"/></td>
                                <td>${vezba.laboratory}</td>
                                <td>
                                    <c:forEach var="demonstrator" items="${vezba.enrolledDemonstrators}">
                                    ${demonstrator.name}&nbsp;${demonstrator.surname}<br>
                                    </c:forEach>
                                </td>
                                <c:choose>
                                    <c:when test="${editable and not vezba.locked}"> 
                                        <td>
                                            <a style="text-decoration: none" href="CommandServlet?cmd=obrisilabvezbu&id=${vezba.id}">
                                                <button class="ui-state-active"><fmt:message key="DELETE"/></button>
                                            </a>
                                        </td>                    
                                        <td>
                                            <a style="text-decoration: none" href="CommandServlet?cmd=zakljucajlabvezbu&id=${vezba.id}">
                                                <button class="ui-state-active"><fmt:message key="LOCK"/></button>
                                            </a>
                                        </td>
                                    </c:when>
                                    <c:when test="${korisnik.demonstrator}"> 
                                        <td>
                                            <a style="text-decoration: none" href="CommandServlet?cmd=potvrdiprijavu&id=${vezba.id}">
                                                <button class="ui-state-active"><fmt:message key="ACCEPT"/></button>
                                            </a>
                                        </td>
                                        <td>
                                            <a style="text-decoration: none" href="CommandServlet?cmd=odbijprijavu&id=${vezba.id}">
                                                <button class="ui-state-active"><fmt:message key="REFUSE"/></button>
                                            </a>
                                        </td>      
                                    </c:when>
                                    <c:otherwise>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </c:otherwise>
                                </c:choose>

                                <td>
                                    <c:if test="${editable and not vezba.locked}">
                                        <a style="text-decoration: none" href="CommandServlet?cmd=pozovidemo&id=${vezba.id}">
                                            <button class="ui-state-active"><fmt:message key="CALL_DEMO"/></button>
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:otherwise>
                    <h3><fmt:message key="NO_ENROLL"/></h3>
                </c:otherwise>
            </c:choose>
        </div>
        <c:if test="${editable}">
            <div class="ui-widget-content ui-corner-all">
                <a style="text-decoration: none" href="CommandServlet?cmd=editlabvezba">
                    <button class="ui-state-active"><fmt:message key="NEW_EXERCISE"/></button>
                </a>
            </div>
        </c:if>
        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>
