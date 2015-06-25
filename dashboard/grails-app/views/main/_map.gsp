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
    var lps = '{\n    \"Results\": [\n        {\n            \"name\": \"Pet Food Express\",\n            \"addr\": \"1975 Market St,San Francisco, CA 94103\",\n            \"lat\": 37.7692339,\n            \"lng\": -122.4261944,\n            \"overallRatings\": 3.38,\n            \"personalizedRatings\": 4.7,\n            \"score\": 1,\n            \"opt\": 1,\n            \"coupon\": \"icon-coupon-code.jpg\"\n        },\n        {\n            \"name\": \"The Animal House\",\n            \"addr\": \"157 Fillmore St,San Francisco, CA 94117\",\n            \"lat\": 37.7710452,\n            \"lng\": -122.4304231,\n            \"overallRatings\": 4.8,\n            \"personalizedRatings\": 3.23,\n            \"score\": 2,\n            \"opt\": 1,\n            \"coupon\": \"icon-coupon-code-2.jpg\"\n        },\n        {\n            \"name\": \"Jeffrey Natural Pet Foods\",\n            \"addr\": \"284 Noe St, San Francisco, CA 94114\",\n            \"lat\": 37.7645598,\n            \"lng\": -122.4333995,\n            \"overallRatings\": 4.2,\n            \"personalizedRatings\": 3.5,\n            \"score\": 3,\n            \"opt\": 0\n        },\n        {\n            \"name\": \"Bella Bean Couture\",\n            \"addr\": \"120 Hickory St, San Francisco, CA 94102\",\n            \"lat\": 37.775771,\n            \"lng\": -122.421506,\n            \"overallRatings\": 3.7,\n            \"personalizedRatings\": 3.6,\n            \"score\": 4,\n            \"opt\": 0\n        },\n        {\n            \"name\": \"Petco Animal Supplies\",\n            \"addr\": \"2300 16th St, San Francisco, CA 94103\",\n            \"lat\": 37.767010,\n            \"lng\": -122.409420,\n            \"overallRatings\": 4.0,\n            \"personalizedRatings\": 3.1,\n            \"score\": 5,\n            \"opt\": 1\n        }\n    ]\n}';
    var locations = JSON.parse(lps);

    var optOutIcons = [
        "${g.resource(dir: 'images/markers', file: 'o1.png')}",
        "${g.resource(dir: 'images/markers', file: 'o2.png')}",
        "${g.resource(dir: 'images/markers', file: 'o3.png')}",
        "${g.resource(dir: 'images/markers', file: 'o4.png')}",
        "${g.resource(dir: 'images/markers', file: 'o5.png')}"
    ];
    var optInIcons = [
        "${g.resource(dir: 'images/markers', file: 'b1.png')}",
        "${g.resource(dir: 'images/markers', file: 'b2.png')}",
        "${g.resource(dir: 'images/markers', file: 'b3.png')}",
        "${g.resource(dir: 'images/markers', file: 'b4.png')}",
        "${g.resource(dir: 'images/markers', file: 'b5.png')}"
    ];

    var map = new google.maps.Map(document.getElementById('map'), {
        center: new google.maps.LatLng(37.770945, -122.418894),
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
        var imageUrl;
        if (locations.Results[i].opt == 1) {
            imageUrl = optInIcons[locations.Results[i].score-1];
        } else {
            imageUrl = optOutIcons[locations.Results[i].score-1];
        }

        var image = {
            url: imageUrl,
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
                        '</div>';

                var ending = '</div>';
                if (locations.Results[i].coupon != undefined) {
                    contentString = contentString +
                                    '<div><img src="../images/'+locations.Results[i].coupon+'" /></div>';
                }
                contentString = contentString + ending;
                infowindow.setContent(contentString);
                infowindow.open(map, marker);
            }
        })(marker, i));

        iconCounter++;
    }
</script>
</body>
</html>