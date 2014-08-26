<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="COURSE_EDIT"/></title>
        <%@include file="jspf/includes.jspf"%>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="COURSE_EDIT"/></div>
        <form method="POST" action="CommandServlet?cmd=predmet">
            <table>
                <c:if test="${editable ne null}">
                    <input type="hidden" name="predmetid" value="${editable.id}">
                </c:if>
                <tr><td><label><fmt:message key="NAME"/>:</label></td><td><input type="text" name="naziv" value="${editable.name}"></td></tr>
                <tr><td><label><fmt:message key="SEMESTER"/>:</label></td><td><input type="text" name="semestar" value="${editable.semester}"></td></tr>
                <tr><td><label><fmt:message key="CODE"/>:</label></td><td><input type="text" name="sifra" value="${editable.code}"></td></tr>
                <tr><td><label><fmt:message key="SCHOOL_YEAR"/>:</label></td><td><input type="text" name="skgod" value="${editable.schoolYear}"></td></tr>
                <tr><td>
                        <button type="submit" class="ui-state-active"><fmt:message key="SAVE"/></button></td>
                    <td>
                <c:if test="${editable ne null}">
                    <a href="CommandServlet?cmd=obrisipredmet&id=${editable.id}" style="text-decoration:none">
                        <button type="button" class="ui-state-highlight"><fmt:message key="DELETE"/></button>
                    </a>
                </c:if>
                </td></tr>
            </table>
        </form>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>
