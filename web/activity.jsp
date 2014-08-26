<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="ACTIVITY_TYPE"/></title>
        <%@include file="jspf/includes.jspf"%>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="ACTIVITY_EDIT"/></div>
        <div class="ui-widget-content ui-corner-all">
        <form method="POST" action="CommandServlet?cmd=aktivnost">
            <table>
               <input type="hidden" name="aktivnostid" value="${editable.id}">
               <tr>
                   <td><label><fmt:message key="TYPE"/></label></td>
                   <td><input type="text" name="naziv" value="${editable.name}"></td>
               </tr>
            <tr>
                <td><label><fmt:message key="COEFFICIENT"/></label></td>
                <td><input type="text" name="koeficijent" value="${editable.coefficient}"</td>
            </tr>
            <tr>
                <td>
                <button type="submit" class="ui-state-active"><fmt:message key="SAVE"/></button>
            </td>
            <td>
             <a href="CommandServlet?cmd=obrisiaktivnost&id=${editable.id}" style="text-decoration:none">
                 <button type="button" class="ui-state-highlight"><fmt:message key="DELETE"/></button>&nbsp;
            </td>
            </tr>
            </table>
        </form>
        </div>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>
