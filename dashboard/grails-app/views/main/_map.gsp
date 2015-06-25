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
</head>

<body>
<div id="map" style="width: 1000px; height: 1200px;"></div>
<script>
    var lps = '{\n    \"Results\": [\n        {\n            \"name\": \"Pet Food Express\",\n            \"addr\": \"1975 Market St,San Francisco, CA 94103\",\n            \"lat\": 37.7692339,\n            \"lng\": -122.4261944,\n            \"overallRatings\": 3.38,\n            \"personalizedRatings\": 4.7,\n            \"score\": 1,\n            \"opt\": 1,\n            \"coupon\": \"icon-coupon-code.jpg\"\n        },\n        {\n            \"name\": \"The Animal House\",\n            \"addr\": \"157 Fillmore St,San Francisco, CA 94117\",\n            \"lat\": 37.7710452,\n            \"lng\": -122.4304231,\n            \"overallRatings\": 4.8,\n            \"personalizedRatings\": 3.23,\n            \"score\": 2,\n            \"opt\": 1,\n            \"apay\": \"apay.png\",\n            \"coupon\": \"icon-coupon-code-2.png\"\n        },\n        {\n            \"name\": \"Jeffrey Natural Pet Foods\",\n            \"addr\": \"284 Noe St, San Francisco, CA 94114\",\n            \"lat\": 37.7645598,\n            \"lng\": -122.4333995,\n            \"overallRatings\": 4.2,\n            \"personalizedRatings\": 3.5,\n            \"score\": 3,\n            \"opt\": 0\n        },\n        {\n            \"name\": \"Bella Bean Couture\",\n            \"addr\": \"120 Hickory St, San Francisco, CA 94102\",\n            \"lat\": 37.775771,\n            \"lng\": -122.421506,\n            \"overallRatings\": 3.7,\n            \"personalizedRatings\": 3.6,\n            \"score\": 4,\n            \"opt\": 0\n        },\n        {\n            \"name\": \"Petco Animal Supplies\",\n            \"addr\": \"2300 16th St, San Francisco, CA 94103\",\n            \"lat\": 37.767010,\n            \"lng\": -122.409420,\n            \"overallRatings\": 4.0,\n            \"personalizedRatings\": 3.1,\n            \"score\": 5,\n            \"apay\": \"apay.png\",\n            \"opt\": 1\n        }\n    ]\n}';
    var locations = JSON.parse(lps);
    var selected = '${selected}';
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

    var details = new Array();
    var some = new Array();
    var reviewsurl = new Array();

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
        markers[i] = marker;

        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                some[i] = '<div id="content">' +
                        '<h1 id="firstHeading" style="color: #255b17">' + locations.Results[i].name + '</h1>' +
                        '<h3 id="firstHeading">' + 'Address :  </h3>' +
                        '<h3 style="color: #444444">' + locations.Results[i].addr + '</h3>' +
                        '<div id="bodyContent">' +
                        '<h3><b>Overall Star ratings : </b><div style="color: #cc0000">' + locations.Results[i].overallRatings + '</div></h1>' +
                        '<h3><b>Personalized Star ratings : </b><div style="color: #cc0000">' + locations.Results[i].personalizedRatings + '</div></h1>' +
                        '</div>';

                var ending = '</div>';
                if (locations.Results[i].coupon != undefined) {
                    some[i] = some[i] +
                                    '<div><img style="width: 250px; height: 120px;" src="../images/'+locations.Results[i].coupon+'" /></div>';
                }

                if (locations.Results[i].apay != undefined) {
                    some[i] = some[i] +
                            '<div><img src="../images/'+locations.Results[i].apay+'" /></div>';
                }

                some[i] += ending;
                some[i] += "<div><a onclick=\"expand("+i+");\">+ Expand</a></div>";
                details[i] = "<div>";
                details[i] = "<iframe src=\"${g.createLink(controller: 'main', action: 'keyRatings')}?client="+i+"\&selected="+selected+"\" ></iframe>";
                details[i] += "<a onclick=\"showreviews("+i+");\"><h3 style='color: #48802c;'>Show Reviews</h3></a>";
                details[i] += "<a onclick=\"collapse("+i+");\">- Collapse</a></div>";

                reviewsurl[i] = "${g.createLink(controller: 'main', action: 'getClientReview')}?client="+i;
                infowindow.setContent(some[i]);
                infowindow.open(map, marker);
            }
        })(marker, i));

        iconCounter++;
    }

    function expand(i){
        infowindow.close();
        infowindow.setContent(some[i]+details[i]);
        infowindow.open(map, markers[i]);
    }

    function collapse(i){
        infowindow.setContent(some[i]);
    }

    function showreviews(i){
        window.open(reviewsurl[i], "Reviews", "height=600,width=300");
    }
</script>
</body>
</html>