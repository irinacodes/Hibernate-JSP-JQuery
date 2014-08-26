<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="COURSE_ASSIGNMENT"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jquery.multiselect.css" rel="stylesheet">       
        <script src="js/jquery.multiselect.min.js"></script>
        <script>
            $(function() {
                $("#predmeti").multiselect({
                    header: false,
                    checkAllText: "<fmt:message key="CHOOSE_ALL"/>",
                    uncheckAllText: "<fmt:message key="CANCEL_ALL"/>",
                    selectedText: "<fmt:message key="CHOSEN"/> #",
                    noneSelectedText: "<fmt:message key="CHOOSE"/>"


                });
                $("#korisnik").multiselect({
                    multiple: false,
                    header: false,
                    noneSelectedText: "<fmt:message key="CHOOSE"/>",
                    selectedList: 1
                });
            });
        </script>
    </head>
    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="COURSE_ASSIGNMENT"/></div>
        <div class="ui-widget-content ui-corner-all">

            <form method="POST" action="CommandServlet?cmd=korisnikpredmet">
                <table>
                    <c:if test="${korisnik.admin}">
                        <tr><td> <label><fmt:message key="INSTRUCTOR"/>:</label></td><td>
                                <select name="id" id="korisnik">
                                    <option selected><fmt:message key="CHOOSE"/></option>
                                    <c:forEach var="instructor" items="${nastavnici}">
                                        <c:if test="${instructor.active}"> 
                                            <option value="${instructor.id}">${instructor.name}&nbsp;${instructor.surname}</option>
                                        </c:if>
                                    </c:forEach> 
                                </select>
                            </c:if>
                        </td></tr> 
                    <tr><td>
                            <label><fmt:message key="COURSES"/>:</label></td><td>
                            <select name="predmeti" multiple id="predmeti"> 
                                <c:forEach var="course" items="${predmeti}">   
                                    <option value="${course.id}">${course.name}</option>
                                </c:forEach>
                            </select>
                        </td></tr> 
                    <tr><td colspan="2">
                            <button type="submit" class="ui-button-text-only ui-state-active"><fmt:message key="SAVE"/></button>
                        </td></tr>
                </table>
            </form>

        </div>
        <%@include file="jspf/footer.jspf"%>
    </body>
</html>

