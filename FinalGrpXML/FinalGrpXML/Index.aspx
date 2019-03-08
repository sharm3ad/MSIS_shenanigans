<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="FinalGrpXML.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Distance between two locations</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="help.css"/>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body style="background-color:black">
    <!--Nav bar-->
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container" style="float:left; padding-left:20px;">
            <div class="navbar-header">
                <a class="navbar-brand" href="#" style="padding-left:0; font-size: 30px; color:white;">Travel Guide</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav" style="font-size: large;">
                    <li><a href="Index.aspx">Home</a></li>
                    <li><a href="Index.aspx">Distance Calculator</a></li>
                    <li><a href="TimeZoneCalculator.aspx">Timezone Finder</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div id="outer">
        <div id="googleMap"></div>
        <script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyCFutZHNkEaH3hDxbX4ocZvJ9vgRq4b0jg" type="text/javascript"></script>

        <script>

            var source, destination;
            var directionsDisplay;
            var directionsService = new google.maps.DirectionsService();

            // initialise the location of the map on Chichester in England (ref lat and lng)
            var map = new google.maps.Map(document.getElementById('googleMap'), {
                center: { lat: 39.1031, lng: -84.5120 },
                zoom: 13,
                mapTypeId: 'roadmap'
            });

            google.maps.event.addDomListener(window, 'load', function () {
                new google.maps.places.SearchBox(document.getElementById('travelfrom'));
                new google.maps.places.SearchBox(document.getElementById('travelto'));
                directionsDisplay = new google.maps.DirectionsRenderer({ 'draggable': true });
            });

            function GetRoute() {

                directionsDisplay.setMap(map);

                source = document.getElementById("travelfrom").value;
                destination = document.getElementById("travelto").value;

                var request = {
                    origin: source,
                    destination: destination,
                    travelMode: google.maps.TravelMode.DRIVING
                };
                if (source === "" || destination === "") {
                    alert("Enter both from and to to get the route");
                }
                directionsService.route(request, function (response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(response);
                    }
                });

                //*********DISTANCE AND DURATION**********************//
                var service = new google.maps.DistanceMatrixService();
                service.getDistanceMatrix({
                    origins: [source],
                    destinations: [destination],
                    travelMode: google.maps.TravelMode.DRIVING,
                    unitSystem: google.maps.UnitSystem.METRIC,
                    avoidHighways: false,
                    avoidTolls: false
                }, function (response, status) {

                    if (status == google.maps.DistanceMatrixStatus.OK && response.rows[0].elements[0].status != "ZERO_RESULTS") {
                        var distance = response.rows[0].elements[0].distance.text;
                        var duration = response.rows[0].elements[0].duration.value;
                        var dvDistance = document.getElementById("dvDistance");
                        duration = parseFloat(duration / 60).toFixed(2);
                        dvDistance.innerHTML = "";
                        dvDistance.innerHTML += "<br />" + "Distance: " + distance + "<br />";
                        dvDistance.innerHTML += "Time: " + duration + " min";

                    } else {
                        alert("Unable to find the distance via road.");
                    }
                });
            }

        </script>
        <div class="main" style="background-color:black">
            <form runat="server">
                <div class="col-md-12">
                    <h2 class="subtitle">Distance between two locations</h2>
                    <h3 class="subtitle">(This service calculates only the distance by road)</h3>
                    <br />
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="travelfrom">From Location</label>
                            <input type="text" class="form-control" id="travelfrom" placeholder="From Location" runat="server"/>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="travelto">To Location</label>
                            <input type="text" class="form-control" id="travelto" placeholder="To Location" runat="server"/>
                        </div>
                    </div>
                    <br />
                    <div class="form-actions">
                        <asp:Button ID="searchButton" runat="server" class="btn btn-primary" Text="Get Route" OnClick="searchButton_Click" />
                    </div>
                    <br />
                    <div id="dvDistance"> 
                        <asp:Label ID="distanceLabel" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="durationLabel" runat="server"></asp:Label>
                    </div>
                </div>
            </form>
        </div>
       
    </div>

</body>

</html>



