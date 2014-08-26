<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="jspf/taglibs.jspf"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="HOME_PAGE"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jqueryui.tables.css" rel="stylesheet">
        <script src="js/jquery.dataTables.js"></script>
        <script>
            $(function() {
                $('#tabelaDemonstratora').dataTable();
                $('#tabelaVezbi').dataTable();
            });
        </script>
    </head>
    <body>

        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="DEMO_HOME_PAGE"/></div>
        <c:set var="user" value="${logged}"/>
            <c:choose>
                <c:when test="${user ne null}">
                    <c:set var="logged" value="${user}"/>
                </c:when>
                <c:otherwise>
                    <c:set var="logged" value="${korisnik}"/>   
                </c:otherwise>
            </c:choose>

            <div class="ui-widget-content ui-corner-all">       
                <table class="display" id="tabelaDemonstratora">
                    <tr>
                        <th><fmt:message key="USERNAME"/></th>
                        <th><fmt:message key="NAME"/></th>
                        <th><fmt:message key="YEAR_OF_STUDY"/></th>
                        <th><fmt:message key="GPA"/></th>
                        <th><fmt:message key="DEPARTMENTS"/></th>
                        <th><fmt:message key="COURSES"/></th>
                    </tr>
                    <tr>
                        <td>
                            <c:if test="${editable}">
                                <a href="CommandServlet?cmd=editkorisnik&id=${logged.id}">
                                </c:if>
                                ${logged.username}
                                <c:if test="${editable}">
                                </a>
                            </c:if> </td>
                        <td>${logged.name}&nbsp;${logged.surname}</td>
                        <td>${logged.yearOfStudy}</td>
                        <td>${logged.gpa}</td>
                        <td>
                            <c:forEach var="department" items="${logged.departments}">
                                ${department.name}<br>
                            </c:forEach>
                        </td>
                        <td>
                            <c:forEach var="course" items="${logged.courses}">
                                ${course.name}<br>
                            </c:forEach>
                        </td>
                    </tr>           
                </table>
                <c:choose>      
                    <c:when test="${not empty mapavezbiaktivnosti}">
                        <h4><fmt:message key="PREV_ACTIVITIES"/></h4>
                        <table class="display" id="tabelaVezbi">
                            <tr>
                                <th><fmt:message key="EXERCISE"/></th>
                                <th><fmt:message key="COURSE"/></th>
                                <th><fmt:message key="DATE"/></th>
                                <th><fmt:message key="FROM"/></th>
                                <th><fmt:message key="TO"/></th>
                                <th><fmt:message key="STATUS"/></th>
                                <th><fmt:message key="ACTIVITY_TYPE"/></th>
                                <th><fmt:message key="EARNINGS"/></tr>
                            </tr>

                            <c:forEach var="entry" items="${mapavezbiaktivnosti}"> 
                                <tr>
                                    <td>${entry.key.name}</td>
                                    <td>${entry.key.course.name}</td>
                                    <td><fmt:formatDate pattern="dd.MM.yyyy" value="${entry.key.date}"/></td>
                                    <td><fmt:formatDate pattern="HH:mm" value="${entry.key.timeFrom}"/></td>
                                    <td><fmt:formatDate pattern="HH:mm" value="${entry.key.timeTo}"/></td>
                                    <td><c:choose>
                                            <c:when test="${entry.key.locked}"><fmt:message key="LOCKED"/></c:when>
                                            <c:otherwise>u toku</c:otherwise>
                                        </c:choose></td>
                                    <td>${entry.value.name}</td>
                                    <td>
                                        <c:if test="${entry.key.locked}">
                                            ${entry.value.coefficient * 1000}
                                        </c:if>&nbsp;
                                    </td>
                                </tr>
                            </c:forEach>                         
                        </table>
                    </c:when>
                    <c:otherwise>
                        <h4><fmt:message key="NO_ACTIVITIES"/></h4>
                    </c:otherwise>
                </c:choose>
            </div>
            <%@include file="jspf/footer.jspf"%> 
        </body>
    </html>
