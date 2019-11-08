using System;

namespace UniversalDashboard.Models
{
    public class EndpointSchedule
    {
        public TimeSpan Every { get; set; }
        public string Cron { get; set; }
        public int Repeat { get; set; }
        public bool Consecutive { get; set; }
    }
}
