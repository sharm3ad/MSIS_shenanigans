<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimeZoneCalculator.aspx.cs" Inherits="FinalGrpXML.TimeZoneCalculator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.css" />
    <link rel="stylesheet" href="https://ajax.aspnetcdn.com/ajax/bootstrap/3.3.7/css/bootstrap.min.css"
          asp-fallback-href="~/lib/bootstrap/dist/css/bootstrap.min.css"
          asp-fallback-test-class="sr-only" asp-fallback-test-property="position" asp-fallback-test-value="absolute" />
    <link rel="stylesheet" type="text/css" href="Style.css" />
    <script src="~/lib/jquery/dist/jquery.js"></script>
    <script src="~/lib/bootstrap/dist/js/bootstrap.js"></script>
    <script src="~/js/site.js" asp-append-version="true"></script>
    <script src="https://ajax.aspnetcdn.com/ajax/jquery/jquery-3.3.1.min.js"
            asp-fallback-src="~/lib/jquery/dist/jquery.min.js"
            asp-fallback-test="window.jQuery"
            crossorigin="anonymous"
            integrity="sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT">
    </script>
    <script src="https://ajax.aspnetcdn.com/ajax/bootstrap/3.3.7/bootstrap.min.js"
            asp-fallback-src="~/lib/bootstrap/dist/js/bootstrap.min.js"
            asp-fallback-test="window.jQuery && window.jQuery.fn && window.jQuery.fn.modal"
            crossorigin="anonymous"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa">
    </script>
    <script src="~/js/site.min.js" asp-append-version="true"></script>
    <title>TimeZone Finder</title>
</head>
<body>

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
    <br /> <br />
    <h1>Timezone.........Finder!</h1>
    <p> Enter your location to..find out your time zone.</p>
    <br />
    <form id="form1" runat="server">
        <div class="main">
            
                <div class="form-row">
                  <div class="form-group col-md-2">
                      <asp:Label ID="enterLocation" runat="server" Text="Enter location"></asp:Label>
                   </div> 
                   <div class="form-group col-md-2">
                        <asp:TextBox ID="InputText" runat="server"></asp:TextBox>
                    </div>
                   
                   <br />
                </div>
                <br />
                <div class="form-row">
                        <asp:Button ID="searchTimeZone" runat="server" Text="Get Time zone" OnClick="getLatLong" />
                </div>
                <br />
                <div class="form-row">
                    <div class="form-group col-md-2">
                      <asp:Label ID="resultTimeZone" runat="server" Text="Time zone"></asp:Label>
                    </div>
                    <div class="form-group col-md-2">
                        <asp:TextBox ID="result" runat="server"></asp:TextBox>
                    </div>
                    <br /> <br />
                    <div class="form-group col-md-2">
                      <asp:Label ID="resultTimezoneId" runat="server" Text="Time zone ID"></asp:Label>
                    </div>
                    <div class="form-group col-md-2">
                        <asp:TextBox ID="timezoneid" runat="server"></asp:TextBox>
                    </div>
                    <br /> <br />
                    <div class="form-group col-md-2">
                      <asp:Label ID="utcTimezone" runat="server" Text="UTC Difference"></asp:Label>
                    </div>
                    <div class="form-group col-md-2">
                        <asp:TextBox ID="utcTimeZoneDiff" runat="server"></asp:TextBox>
                    </div>
                    <br /> <br />
                    <div class="form-group col-md-2">
                      <asp:Label ID="dateTime" runat="server" Text="Date and Time"></asp:Label>
                    </div>
                    <div class="form-group col-md-2">
                        <asp:TextBox ID="timeZoneDate" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>
    </form>
</body>
</html>
