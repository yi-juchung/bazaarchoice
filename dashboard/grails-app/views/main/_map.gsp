<%--
  Created by IntelliJ IDEA.
  User: yi-ju.chung
  Date: 6/24/15
  Time: 7:08 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>BVChoice</title>
    <script src="http://maps.google.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
        function open() {

        }
    </script>
</head>

<body>
<div id="map" style="width: 1000px; height: 1200px;"></div>
<script>
    var lps = '{\n    \"Results\": [\n        {\n            \"name\": \"Pet Food Express\",\n            \"addr\": \"1975 Market St,San Francisco, CA 94103\",\n            \"lat\": 37.7692339,\n            \"lng\": -122.4261944,\n            \"overallRatings\": 3.38,\n            \"personalizedRatings\": 4.7,\n            \"score\": 1,\n            \"opt\": 1\n        },\n        {\n            \"name\": \"The Animal House\",\n            \"addr\": \"157 Fillmore St,San Francisco, CA 94117\",\n            \"lat\": 37.7710452,\n            \"lng\": -122.4304231,\n            \"overallRatings\": 4.8,\n            \"personalizedRatings\": 3.23,\n            \"score\": 2,\n            \"opt\": 1\n        },\n        {\n            \"name\": \"Jeffrey Natural Pet Foods\",\n            \"addr\": \"284 Noe St, San Francisco, CA 94114\",\n            \"lat\": 37.7645598,\n            \"lng\": -122.4333995,\n            \"overallRatings\": 4.2,\n            \"personalizedRatings\": 3.5,\n            \"score\": 3,\n            \"opt\": 0\n        }\n    ]\n}';
    var locations = JSON.parse(lps);
    var iconURLPrefix = 'http://maps.google.com/mapfiles/ms/icons/';

    var icons = [
        iconURLPrefix + 'red-dot.png',
        iconURLPrefix + 'green-dot.png',
        iconURLPrefix + 'blue-dot.png',
        iconURLPrefix + 'orange-dot.png',
        iconURLPrefix + 'purple-dot.png',
        iconURLPrefix + 'pink-dot.png',
        iconURLPrefix + 'yellow-dot.png'
    ];
    var iconsLength = icons.length;

    var map = new google.maps.Map(document.getElementById('map'), {
        center: new google.maps.LatLng(37.767182, -122.429553),
        disableDefaultUI: true,
        zoom: 15
    });
    var infowindow = new google.maps.InfoWindow({
        maxWidth: 600
    });

    var markers = new Array();

    var iconCounter = 0;

    google.maps.event.addDomListener(window, 'resize', function() {
        map.setCenter(center);
    });

    for (var i = 0; i < locations.Results.length; i++) {
        var image = {
            url: icons[locations.Results[i].score],
            size: new google.maps.Size(80,80),
            origin: new google.maps.Point(0,0),
            scaledSize: new google.maps.Size(80, 80),
            anchor: new google.maps.Point(0, 32)
        };


        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations.Results[i].lat, locations.Results[i].lng),
            map: map,
            icon: image
        });
        markers.push(marker);

        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                var contentString = '<div id="content">' +
                        '<h1 id="firstHeading" class="firstHeading">' + 'Store Name : ' + locations.Results[i].name + '</h1>' +
                        '<h1 id="firstHeading" class="firstHeading">' + 'Store Address :  </h1>' +
                        '<h3>' + locations.Results[i].addr + '</h3>' +
                        '<div id="bodyContent">' +
                        '<h1><b>Overall Star ratings : </b>' + locations.Results[i].overallRatings + '</h1>' +
                        '<h1><b>Personalized Star ratings : </b>' + locations.Results[i].personalizedRatings + '</h1>' +
                        '</div>' +
                        '</div>';
                infowindow.setContent(contentString);
                infowindow.open(map, marker);
            }
        })(marker, i));

        iconCounter++;
        if(iconCounter >= iconsLength) {
            iconCounter = 0;
        }
    }
</script>
</body>
</html>