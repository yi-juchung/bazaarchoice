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
<fieldset class="form" style="width: 300px;">
    <g:form controller="main" action="getKeyword" method="GET">
        <div class="fieldcontain">
            <label for="query"><h1>Search for word:</h1></label>
            <g:textField size="80px" name="query" value="${params.query}"/>
        </div>
    </g:form>
</fieldset>
</body>
</html>