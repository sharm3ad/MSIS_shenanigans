using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using Newtonsoft.Json;
using System.Text;
using Newtonsoft.Json.Linq;

namespace FinalGrpXML
{
    public partial class TimeZoneCalculator : System.Web.UI.Page
    {
        //Attributes for geoCode API
        private const string baseGeoCodeUrl = "https://maps.googleapis.com/maps/api/geocode/json?";
        private const string geoCodeApiKey = "&key=AIzaSyBw4I9JusM4i8mMe1Q1JNeD5wLbYnufS-c";
        private const string address = "address=";

        //Attributes for TimeZone API
        //To get timestamp
        public static String GetTimestamp(DateTime value)
        {
            return value.ToString("yyyyMMddHHmmss");
        }
        //String timeStampValue = GetTimestamp(DateTime.Now);
        Int32 unixTimestamp = (Int32)(DateTime.UtcNow.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
        private const string baseTimezoneUrl = "https://maps.googleapis.com/maps/api/timezone/json?";
        private const string timeZoneApiKey = "&key=AIzaSyAjX7j16vSCe2gStqIDVl7Rp8XOijyhxtE";
        private const string locationParameter = "location=";
        private const string timestamp = "&timestamp=";





        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void getLatLong(object sender, EventArgs e)
        {
            var location = InputText.Text;

            using (var webClient = new WebClient())
            {
                double latitude = 0.0D;
                double longitude = 0.0D;
                string latlong = "";
                int rawOffsetValue = 0;
                int minutes = 0;
                int hours = 0;
                string geoCodeurl = baseGeoCodeUrl + address + location + geoCodeApiKey;
                String geoCodeData = webClient.DownloadString(geoCodeurl);
                TimeZoneInfo tzi;
                DateTime currentDate, targetTime;
                TimezoneCalculatorDefinition geoCodeResponse = JsonConvert.DeserializeObject<TimezoneCalculatorDefinition>(geoCodeData);
                //StringBuilder sb1 = new StringBuilder();

                latitude = geoCodeResponse.Results[0].Geometry.Location.lat;
                //StringBuilder sb2 = new StringBuilder();
                longitude = geoCodeResponse.Results[0].Geometry.Location.lng;

                 latlong = latitude.ToString("0.########") + ","+ longitude.ToString("0.########");

                string timeZoneUrl = baseTimezoneUrl + locationParameter + latlong + timestamp + unixTimestamp.ToString() + timeZoneApiKey;
                string timeZoneData = webClient.DownloadString(timeZoneUrl);
                JObject jsonData = JObject.Parse(timeZoneData);
                result.Text = jsonData.GetValue("timeZoneName").ToString();
                timezoneid.Text = jsonData.GetValue("timeZoneId").ToString();
                JToken rawOffsetToken = (jsonData.GetValue("rawOffset"));
                rawOffsetValue = rawOffsetToken.ToObject<int>();
                minutes = (rawOffsetValue / 60);
                hours = minutes / 60;
                //Setting UI field to UTC time difference
                if(hours > 0)
                {
                    utcTimeZoneDiff.Text = "UTC +" + hours.ToString();
                }
                else
                {
                    utcTimeZoneDiff.Text = "UTC " + hours.ToString();
                }
                
                //converting current time to populated location's timezone. Here tzi takes return timezone from google's timezone api
                tzi = TimeZoneInfo.FindSystemTimeZoneById(jsonData.GetValue("timeZoneName").ToString());

                currentDate = DateTime.Now;
                targetTime = TimeZoneInfo.ConvertTime(currentDate, tzi);
                //setting ui field to date time of given locations time zone
                timeZoneDate.Text = targetTime.ToString();


            }
        }

    }
}