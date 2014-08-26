<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="CALL_DEMO"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jquery.multiselect.css" rel="stylesheet">
        <script src="js/jquery.multiselect.min.js"></script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="CALL_DEMO"/></div>
        <div class="ui-widget-content">
            <h5><fmt:message key="EXERCISE"/>:&nbsp;${vezba.name}</h5>
            <h5><fmt:message key="COURSE"/>:&nbsp;${vezba.course.name}</h5>
            <c:choose>
                <c:when test="${not empty demo}">
                    <table class="jtable">
                        <tr>
                            <th><fmt:message key="DEMONSTRATOR"/></th>
                            <th><fmt:message key="ACTIVITY"/></th>
                            <th></th>
                        </tr>
                        <c:forEach var="demonstrator" items="${demo}">
                            <form method="post" action="CommandServlet?cmd=prijava&id=${vezba.id}">
                                <input type="hidden" name="korisnik" value="${demonstrator.id}">
                                <script>
                                    $(function() {
                                        $("#aktivnost${demonstrator.id}").multiselect({
                                            multiple: false,
                                            header: false,
                                            noneSelectedText: "izaberi",
                                            selectedList: 1
                                        });
                                    });
                                </script>
                                <tr>
                                    <td>${demonstrator.name}&nbsp;${demonstrator.surname}</td>
                                    <td>
                                        <select name="aktivnost" id="aktivnost${demonstrator.id}">
                                            <option value="0"><fmt:message key="CHOOSE"/></option>
                                            <c:forEach var="activity" items="${aktivnosti}">
                                                <option value="${activity.id}">${activity.name}</option>
                                            </c:forEach>
                                            <option></option>
                                        </select>
                                    </td>
                                    <td><button type="submit" class="ui-state-active"><fmt:message key="CALL"/></button></td>
                            </form>
                            </tr>

                        </c:forEach>              
                    </table>
                </c:when>
                <c:otherwise>
                    <h4><fmt:message key="NO_DEMO"/></h4>
                </c:otherwise>
            </c:choose>
        </div>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>
