<table border="1" style="width:100%">
    <tr>
        <td style="width: 40%;">Keyword</td><td>Rating</td></tr>
    <g:each var="keyRat" in="${selected}">
        <tr>
            <td style="color: #cc0000">${keyRat.key}</td>
            <td>${keyRat.value}</td>
        </tr>
    </g:each>
</table>
<table border="1" style="width:100%">
    <g:each var="keyRat" in="${others}">
        <tr>
            <td style="width: 40%;">${keyRat.key}</td>
            <td>${keyRat.value}</td>
        </tr>
    </g:each>
</table>