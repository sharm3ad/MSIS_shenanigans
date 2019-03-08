using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace FinalGrpXML
{
    public class TimezoneCalculatorDefinition
    {
        
        public string Status { get; set; }
        public Result[] Results { get; set; }
        public TimeZoneResponseBase TimeZoneResponseData { get; set; }
        public static string timeZoneId { get; set; }
        public static string timeZoneName { get; set; }
        public string status { get; set; }

        public class Data
        {
            //public double lat { get; set; }
            //public double lng { get; set; }
            //public string timeZoneId { get; set; }
            //public string timeZoneName { get; set; }
            //public string status { get; set; }
        }

        public class Location
        {
            //public string latitude { get; set; }
      
       
            //public Data LocationAttributes { get; set; }

            public double lat { get; set; }
            public double lng { get; set; }
            //public Data Distance { get; set; }
        }

        public class Result
        {
            public Geometry Geometry { get; set; }

        }

        public class Geometry
        {
            public Location Location { get; set; }
        }

        public class TimeZoneResponseBase
        {
            public string timeZoneId { get; set; }
            public string timeZoneName { get; set; }
            public string status { get; set; }
        }
    }
}