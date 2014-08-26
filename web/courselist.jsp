<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="COURSE_LIST"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $('#tabelapredmeta').dataTable();
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%> 
        <div class="ui-state-active"><fmt:message key="COURSE_LIST"/></div>
        <c:if test="${not empty lista}">
            <div class="ui-widget-content ui-corner-all">
                <table class="display" id="tabelapredmeta">
                    <tr>
                        <th><fmt:message key="NAME"/></th>
                        <th><fmt:message key="SEMESTER"/></th>
                        <th><fmt:message key="CODE"/></th>
                        <th><fmt:message key="SCHOOL_YEAR"/></th>
                    </tr>
                    <c:forEach var="course" items="${lista}">
                        <tr>
                            <td><c:if test="${korisnik.admin}">
                                    <a href="CommandServlet?cmd=editpredmet&id=${course.id}">
                                    </c:if>${course.name}
                                    <c:if test="korisnik.admin">
                                    </a>
                                </c:if></td>
                            <td>${course.semester}</td>
                            <td>${course.code}</td>
                            <td>${course.schoolYear}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
            <c:if test="${korisnik.admin}">
                <a href="CommandServlet?cmd=editpredmet" style="text-decoration:none">
                    <button class="ui-state-active"><fmt:message key="ADD"/>&nbsp;<fmt:message key="COURSE"/></button>
                </a>
            </div>
        </c:if>
        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>
