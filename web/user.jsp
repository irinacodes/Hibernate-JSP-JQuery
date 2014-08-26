
<%@include file="jspf/taglibs.jspf"%>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><fmt:message key="EDIT_USER"/></title>
        <%@include file="jspf/includes.jspf"%>
        <link href="css/jquery.multiselect.css" rel="stylesheet">
        <link href="css/dataTablesjqueryui.css" rel="stylesheet">       
        <script src="js/jquery.multiselect.min.js"></script>
        <script src="js/jquery.validate.js"></script>
        <%@include file="jspf/korisnik.jspf"%>
    </head>

    <body>
        <%@include file="jspf/header.jspf"%> 
        <%@include file="jspf/menu.jspf"%>
        <%@include file="jspf/message.jspf"%>
        <div class="ui-state-active"><fmt:message key="EDIT_USER"/></div>
        <div class="ui-widget-content">
            <form method="POST" action="CommandServlet?cmd=korisnik" id="signup">
                <c:if test="${editable ne null}">
                <input type="hidden" name="id" value="${editable.id}">
                </c:if>
                <table>
                    <tr>
                        <td><label><fmt:message key="USERNAME"/>:</label></td>
                        <td><input type="text" id="username" name="username" value="${editable.username}"></td>
                    </tr>
                    <tr>
                        <td><label><fmt:message key="PASSWORD"/>:</label></td>
                        <td><input type="password" name="pwd" id="password"></td>
                    </tr>
                    <tr>
                        <td><label><fmt:message key="PERSONAL_NAME"/>:</label></td>
                        <td><input type="text" name="ime" id="ime" value="${editable.name}"></td>
                    </tr>
                    <tr>
                        <td><label><fmt:message key="SURNAME"/>:</label></td>
                        <td><input type="text" id="prezime" name="prezime" value="${editable.surname}"></td>
                    </tr>
                    <tr>
                        <td><label><fmt:message key="PHONE"/>:</label></td>
                        <td><input type="text" name="telefon" value="${editable.phone}"></td>
                    </tr>
                    <tr>
                        <td><label><fmt:message key="EMAIL"/>:</label></td>
                        <td><input type="text" id="email" name="email" value="${editable.email}"></td>
                    </tr>


                    <tr>
                        <td><label><fmt:message key="TITLE"/>:</label></td>
                        <td><select name="zvanje" id="zvanje" class="required">
                                <option value=""><fmt:message key="CHOOSE"/></option>
                                <c:forEach var="title" items="${titlelist}">
                                    <option value="${title.id}" <c:if test="${editable ne null and editable.title.id eq title.id}">selected</c:if>>${title.name}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr class="showhide">
                        <td><label><fmt:message key="YEAR_OF_STUDY"/>:</label></td>
                        <td><select name="godstudija" id="godstudija">
                                <option><fmt:message key="CHOOSE"/></option>
                                <option value="1" <c:if test="${editable ne null and editable.demonstrator and editable.yearOfStudy eq 1}">selected</c:if>>I</option>
                                <option value="2" <c:if test="${editable ne null and editable.demonstrator and editable.yearOfStudy eq 2}">selected</c:if>>II</option>
                                <option value="3" <c:if test="${editable ne null and editable.demonstrator and editable.yearOfStudy eq 3}">selected</c:if>>III</option>
                                <option value="4" <c:if test="${editable ne null and editable.demonstrator and editable.yearOfStudy eq 4}">selected</c:if>>IV</option>
                                </select>
                            </td>
                        </tr>
                        <tr class="showhide">
                            <td><label><fmt:message key="DEPARTMENT"/>:</label></td>
                        <td><select name="odsek" multiple id="odsek">
                                <c:forEach var="dept" items="${departmentlist}">
                                    <option value="${dept.id}">               
                                        ${dept.name}
                                    </option>
                                </c:forEach>
                            </select></td>
                    </tr>
                    <tr class="showhide">
                        <td><label><fmt:message key="GPA"/>:</label></td><td><input type="text" name="prosek" id="prosek" value="${editable.gpa}"></td>
                    </tr>
                    <tr>
                        <td><button type="submit" class="ui-state-active"><fmt:message key="SAVE"/></button></td>
                        <td>
                            <c:if test="${editable eq null}">
                                <a style="text-decoration: none" href="${pageContext.servletContext.contextPath}/index.jsp">
                                    <button type="button" class="ui-state-active"><fmt:message key="HOME_PAGE"/></button></a>
                                </c:if>
                        </td>
                    </tr>
                </table>  
            </form>
            <%@include file="jspf/footer.jspf"%>
    </body>
</html>
