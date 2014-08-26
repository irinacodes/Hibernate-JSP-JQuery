<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="PWD_CHANGE"/></title>
        <%@include file="jspf/includes.jspf"%>
        <%@include file="jspf/register.jspf"%> 
        <script src="js/jquery.validate.js"></script>
    </head>
    <body> 
        <%@include file="jspf/header.jspf"%>
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="PWD_CHANGE"/></div>
        <div class="ui-widget-content ui-corner-all">
        <form method="post" action="CommandServlet?cmd=lozinka" id="reg">
            <table>
                <tr><td>
                <label><fmt:message key="USERNAME"/>:</label></td><td><input type="text" name="user" value="${korisnik.username}" disabled="true"></td></tr>
                <tr><td>
                <label><fmt:message key="OLD"/>&nbsp;<fmt:message key="PASSWORD"/>:</label></td><td> <input type="password" name="pwd" id="pwd"></td></tr>
                <tr><td>
                <label><fmt:message key="NEW_PASSWORD"/>:</label></td><td> <input type="password" name="newpwd" id="newpwd"></td></tr>
                <tr><td>
                <label><fmt:message key="PWD_CONFIRM"/>:</label></td><td><input type="password" name="newpwdconfirm" id="newpwdconfirm"></td></tr>
                <tr><td colspan="2">
                <button type="submit" class="ui-state-active"><fmt:message key="CHANGE"/></button> 
                </td></tr>
            </table>
        </form>
        </div>
        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>
