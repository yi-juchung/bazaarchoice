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
    <link rel="stylesheet" href="../css/index.css" type="text/css">
    <script>
        function popout() {
            var w = 400;
            var h = 200;
            var left = (screen.width/2)-(w/2);
            var top = (screen.height/2)-(h/2);
            var wnd = window.open("${g.createLink(controller: 'main', action: 'loading')}", "Facebook Login", 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+top+', left='+left);
            setTimeout(function() {
                wnd.close();
                var tar = document.getElementById("target");
                var img = tar.firstElementChild;
                img.setAttribute("src","images/search.png");
                tar.setAttribute("onclick","location.href='${g.createLink(controller: 'main', action: 'search')}';")
            }, 3000);
            return false;
        }
    </script>
</head>
<body>
<img src="images/bazaarchoice.jpg" />
<div id="target" onclick="popout()"><img src="images/login.png"/></div>
</body>
</html>