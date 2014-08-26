<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="USER_LIST"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jquery.multiselect.css" rel="stylesheet">
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.multiselect.min.js"></script> 
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $("#predmeti").multiselect({
                    header: false,
                    checkAllText: "<fmt:message key="CHOOSE_ALL"/>",
                    uncheckAllText: "<fmt:message key="CANCEL_ALL"/>",
                    selectedText: "<fmt:message key="CHOSEN"/> #",
                    noneSelectedText: "<fmt:message key="CHOOSE"/>"
                });
                $("#zvanja").multiselect({
                    header: false,
                    checkAllText: "<fmt:message key="CHOOSE_ALL"/>",
                    uncheckAllText: "<fmt:message key="CANCEL_ALL"/>",
                    selectedText: "<fmt:message key="CHOSEN"/> #",
                    noneSelectedText: "<fmt:message key="CHOOSE"/>"
                });
                $('#tabelakorisnika').dataTable();
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-widget-header ui-corner-all ui-state-active"><fmt:message key="USER_LIST"/></div>
        <div class="ui-state-highlight ui-corner-all">    
            <c:if test="${korisnik.instructor or korisnik.admin}">
                <form method="POST" action="CommandServlet?cmd=pronadjikorisnika">
                    <table>
                        <tr><th><fmt:message key="SEARCH"/></th><th colspan="5">&nbsp;</th></tr>
                        <tr><td><label><fmt:message key="PERSONAL_NAME"/>:</label></td><td><input type="text" name="demoime"></td>
                            <td><label><fmt:message key="SURNAME"/>:</label></td><td><input type="text" name="demoprezime"></td>
                            <td><label><fmt:message key="COURSE"/>:</label></td>
                            <td> <select multiple name="predmeti" id="predmeti">
                                    <c:forEach var="course" items="${svipredmeti}">
                                        <option value="${course.id}">${course.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <c:if test="${korisnik.admin}">
                                <td><label><fmt:message key="TITLE"/>:</label></td>
                                <td><select multiple name="zvanja" id="zvanja">
                                        <c:forEach var="title" items="${svazvanja}">
                                            <option value="${title.id}">${title.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>  
                            </c:if>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <button type="submit" class="ui-state-active"><fmt:message key="SEARCH"/></button>
                            </td>
                        </tr>
                    </table>
                </form>
            </c:if>
        </div>
        <c:choose>
            <c:when test="${not empty lista}">

                <div class="ui-widget-content ui-corner-all">
                    <table class="display" id="tabelakorisnika">
                        <tr>
                            <th><fmt:message key="USERNAME"/></th>
                            <th><fmt:message key="NAME"/></th>
                            <th><fmt:message key="SURNAME"/></th>                    
                            <th><fmt:message key="EMAIL"/></th>
                            <th><fmt:message key="USER_TYPE"/></th>
                            <th><fmt:message key="COURSES"/></th>
                            <th>&nbsp;</th>
                        </tr>
                        <c:forEach var="user" items="${lista}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${korisnik.admin}">
                                            <a href="CommandServlet?cmd=editkorisnik&id=${user.id}">
                                            </c:when>
                                            <c:when test="${korisnik.instructor}">
                                                <a href="CommandServlet?cmd=demohome&id=${user.id}">
                                                </c:when>
                                            </c:choose>
                                            ${user.username}
                                            <c:if test="${korisnik.admin or korisnik.instructor}">
                                            </a>
                                        </c:if>
                                </td>
                                <td>${user.name}</td>
                                <td>${user.surname}</td>
                                <td>${user.email}</td>
                                <td>${user.title.name}</td>
                                <td>
                                    <c:forEach var="course" items="${user.courses}">
                                        ${course.name}<br>
                                    </c:forEach>
                                </td>
                                <td>
                                    <c:if test="${korisnik.admin}">
                                        <c:choose>
                                            <c:when test="${not user.active}"> 
                                                <a href="CommandServlet?cmd=aktivirajkorisnika&id=${user.id}" style="text-decoration:none">
                                                    <button class="ui-state-active"><fmt:message key="ACTIVATE"/></button>
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="CommandServlet?cmd=deaktivirajkorisnika&id=${user.id}" style="text-decoration:none">
                                                    <button class="ui-state-active"><fmt:message key="DELETE"/></button>
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${not korisnik.demonstrator}">
                            <tr><td colspan="7">
                                    <a href="CommandServlet?cmd=editkorisnik" style="text-decoration:none">
                                        <button class="ui-state-active"><fmt:message key="NEW_USER"/></button>
                                    </a>
                                </td></tr>
                            </c:if>
                    </table> 
                </div>
            </c:when>
            <c:otherwise>
                <h4><fmt:message key="NO_DATA"/></h4>
            </c:otherwise>
        </c:choose>

        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>
