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
    <meta charset="UTF-8">
    <script>
        function popout() {
            var wnd = window.open("http://www.stackoverflow.com");
            setTimeout(function() {
                wnd.close();
            }, 5000);
            return false;
        }
    </script>
</head>
<body>
<div id="target" onclick="popout()"><img src="images/login.png"/></div>
</body>
</html>