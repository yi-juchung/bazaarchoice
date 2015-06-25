<%--
  Created by IntelliJ IDEA.
  User: yi-ju.chung
  Date: 6/24/15
  Time: 5:04 PM
--%>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<head>
    <title>Bazaarchoice Dashboard</title>
</head>
<body>

<fieldset class="form">
    <g:form controller="main" action="map" method="GET">
        <g:each var="item" in="${relatedWords}">
            <tr>
                <td>
                    <input type="checkbox" name=${item} value="checked"
                           style="margin-left:auto; margin-right:auto;">
                </td>
                <td><h1>${item}</h1></td>
            </tr>

        </g:each>
        <g:submitButton name="Submit"/>
    </g:form>
</fieldset>
</body>
</html>