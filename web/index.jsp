<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="HOME_PAGE"/></title>
        <%@include file="jspf/includes.jspf"%>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        
        <form method="post" action="CommandServlet?cmd=login">
            <div class="ui-widget">
                <div class="ui-widget-content ui-corner-all">
                    <table>
                        <tr><td><label><fmt:message key="USERNAME"/></label></td><td><input type="text" name="user"></td></tr>
                        <tr><td><label><fmt:message key="PASSWORD"/></label> </td><td><input type="password" name="pwd"></td></tr>
                        <tr>
                            <td><button type="submit" class="ui-state-highlight"> <fmt:message key="LOGIN"/></button></td>             
                            <td><a href="CommandServlet?cmd=editkorisnik">
                                    <button type="button" class="ui-state-active" ><fmt:message key="REGISTER"/></button> 
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
       </form>
        
        <%@include file="jspf/footer.jspf"%> 
    </body>
</html>
