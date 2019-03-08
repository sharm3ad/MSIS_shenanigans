using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using Newtonsoft.Json;
using System.Text;

namespace FinalGrpXML
{
    public partial class Index : System.Web.UI.Page
    {
        private const string baseUrl = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial";
        private const string apiKey = "&key=AIzaSyBDhgGU5Eneu4_hhreQscx8HDTtKs7h9ds";
        private const string origin = "&origins=";
        private const string destination = "&destinations=";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            var orig = travelfrom.Value;
            var dest = travelto.Value;
            StringBuilder sb = new StringBuilder();
            StringBuilder sb2 = new StringBuilder();
            using (var webClient = new WebClient())
            {
                string url = baseUrl + origin + orig + destination + dest + apiKey;
                String rawData = webClient.DownloadString(url);
                DistanceResponse response = JsonConvert.DeserializeObject<DistanceResponse>(rawData);
                string status = response.Status;
                string elementStatus = response.Rows[0].Elements[0].Status;
                if (status == "OK" && elementStatus == "OK")
                {
                    sb.Append("Distance: ");
                    sb2.Append("Time: ");
                    sb.Append(response.Rows[0].Elements[0].Distance.Text);
                    sb2.Append(response.Rows[0].Elements[0].Duration.Text);   
                }
                else
                {
                    sb.Append("Distance by road cannot be calculated");
                    sb2.Append("");
                }
                distanceLabel.Text = sb.ToString();
                durationLabel.Text = sb2.ToString();
            }
        }
    }
}