<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="EDIT_DEPT"/></title>
        <%@include file="jspf/includes.jspf"%>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="EDIT_DEPT"/></div>
        <form method="POST" action="CommandServlet?cmd=odsek">
            <input type="hidden" name="odsekid" value="${editable.id}">
            <div class="ui-widget-content ui-corner-all">
                <table>
                    <tr><td><label><fmt:message key="NAME"/>:</label></td>
                        <td><input type="text" name="naziv" value="${editable.name}"></td></tr>
                    <tr><td>
                            <button type="submit" class="ui-state-active"><fmt:message key="SAVE"/></button>
                            </div></td><td>
                            <c:if test="${editable ne null}">
                                <a href="CommandServlet?cmd=obrisiodsek&id=${editable.id}" style="text-decoration:none">
                                    <button type="button" class="ui-state-highlight"><fmt:message key="DELETE"/></button>
                                </a>
                            </c:if>&nbsp;
                        </td></tr>
                </table>
            </div>
        </form>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>
