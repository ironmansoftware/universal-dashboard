using UniversalDashboard.Models;
using System;
using System.Management.Automation;

namespace UniversalDashboard.Cmdlets
{
    [Cmdlet(VerbsCommon.New, "UDEndpointSchedule")]
    public class NewEndpointScheduleCommand : PSCmdlet
    {
        [Parameter(ParameterSetName = "EverySecond", Mandatory = true)]
        [Parameter(ParameterSetName = "EveryMinute", Mandatory = true)]
        [Parameter(ParameterSetName = "EveryHour", Mandatory = true)]
        [Parameter(ParameterSetName = "EveryDay", Mandatory = true)]
        public int Every { get; set; }
        [Parameter(ParameterSetName = "EverySecond")]
        [Parameter(ParameterSetName = "EveryMinute")]
        [Parameter(ParameterSetName = "EveryHour")]
        [Parameter(ParameterSetName = "EveryDay")]
        public int Repeat { get; set; }
        [Parameter]
        public SwitchParameter Consecutive { get; set; }
        [Parameter(ParameterSetName = "EverySecond", Mandatory = true)]
        public SwitchParameter Second { get; set; }
        [Parameter(ParameterSetName = "EveryMinute", Mandatory = true)]
        public SwitchParameter Minute { get; set; }
        [Parameter(ParameterSetName = "EveryHour", Mandatory = true)]
        public SwitchParameter Hour { get; set; }
        [Parameter(ParameterSetName = "EveryDay", Mandatory = true)]
        public SwitchParameter Day { get; set; }
        [Parameter(ParameterSetName = "Cron")]
        public string Cron { get; set; }

        protected override void EndProcessing()
        {
            if (ParameterSetName == "Cron")
            {
                WriteObject(new EndpointSchedule
                {
                    Cron = Cron,
                    Consecutive = Consecutive
                });
            }

            if (ParameterSetName == "EverySecond")
            {
                WriteObject(new EndpointSchedule
                {
                    Every = TimeSpan.FromSeconds((double)Every),
                    Repeat = Repeat,
                    Consecutive = Consecutive
                });
            }

            if (ParameterSetName == "EveryMinute")
            {
                WriteObject(new EndpointSchedule
                {
                    Every = TimeSpan.FromMinutes((double)Every),
                    Repeat = Repeat,
                    Consecutive = Consecutive
                });
            }

            if (ParameterSetName == "EveryHour")
            {
                WriteObject(new EndpointSchedule
                {
                    Every = TimeSpan.FromHours((double)Every),
                    Repeat = Repeat,
                    Consecutive = Consecutive
                });
            }

            if (ParameterSetName == "EveryDay")
            {
                WriteObject(new EndpointSchedule
                {
                    Every = TimeSpan.FromDays((double)Every),
                    Repeat = Repeat,
                    Consecutive = Consecutive
                });
            }
        }
    }
}
