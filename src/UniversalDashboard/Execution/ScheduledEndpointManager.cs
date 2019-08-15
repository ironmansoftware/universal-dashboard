using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Hosting;
using Quartz;
using Quartz.Impl;
using System.Collections.Specialized;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using UniversalDashboard.Interfaces;

namespace UniversalDashboard.Execution
{
    public class ScheduledEndpointManager : IHostedService
    {
        private IScheduler _scheduler;
        private readonly IExecutionService _executionService;
        private readonly IMemoryCache _memoryCache;
        private readonly IDashboardService _dashboardService;

        public ScheduledEndpointManager(IExecutionService executionService, IMemoryCache memoryCache, IDashboardService dashboardService)
        {
            _memoryCache = memoryCache;
            _executionService = executionService;
            _dashboardService = dashboardService;
        }

        public async Task StartAsync(CancellationToken cancellationToken)
        {
            var endpoints = _dashboardService.EndpointService.GetScheduledEndpoints();

            var props = new NameValueCollection
            {
                { "quartz.serializer.type", "binary" },
                { "quartz.threadPool.threadCount", "100" }
            };
            var factory = new StdSchedulerFactory(props);

            _scheduler = await factory.GetScheduler();
            await _scheduler.Start();

            foreach (var endpoint in endpoints.Where(m => m.Schedule != null))
            {
                var dataMap = new JobDataMap();
                var job = JobBuilder.Create<ScheduledEndpointJob>()
                .UsingJobData(dataMap)
                .Build();

                if (endpoint.Schedule.Consecutive)
                {
                    dataMap.Add(nameof(ScheduledEndpointJobConsecutive.Endpoint), endpoint);
                    dataMap.Add(nameof(ScheduledEndpointJobConsecutive.ExecutionService), _executionService);
                    dataMap.Add(nameof(ScheduledEndpointJobConsecutive.MemoryCache), _memoryCache);
                    job = JobBuilder.Create<ScheduledEndpointJobConsecutive>()
                    .UsingJobData(dataMap)
                    .Build();
                }
                else
                {
                    dataMap.Add(nameof(ScheduledEndpointJob.Endpoint), endpoint);
                    dataMap.Add(nameof(ScheduledEndpointJob.ExecutionService), _executionService);
                    dataMap.Add(nameof(ScheduledEndpointJob.MemoryCache), _memoryCache);
                    job = JobBuilder.Create<ScheduledEndpointJob>()
                    .UsingJobData(dataMap)
                    .Build();
                }


                ITrigger trigger = null;
                if (endpoint.Schedule.Cron != null)
                {
                    if (endpoint.Schedule.Consecutive)
                    {
                        trigger = TriggerBuilder.Create()
                             .StartNow()
                             .WithSchedule(CronScheduleBuilder.CronSchedule(endpoint.Schedule.Cron)
                             .WithMisfireHandlingInstructionIgnoreMisfires())
                             .Build();
                    }
                    else
                    {
                        trigger = TriggerBuilder.Create()
                             .StartNow()
                             .WithSchedule(CronScheduleBuilder.CronSchedule(endpoint.Schedule.Cron))
                             .Build();
                    }
                }
                else
                {
                    if (endpoint.Schedule.Repeat > 0)
                    {
                        if (job.ConcurrentExecutionDisallowed)
                        {
                            trigger = TriggerBuilder.Create()
                                .StartNow()
                                .WithSimpleSchedule(x => x
                                    .WithIntervalInSeconds((int)endpoint.Schedule.Every.TotalSeconds)
                                    .WithRepeatCount(endpoint.Schedule.Repeat)
                                    .WithMisfireHandlingInstructionIgnoreMisfires())
                                .Build();
                        }
                        else
                        {
                            trigger = TriggerBuilder.Create()
                                .StartNow()
                                .WithSimpleSchedule(x => x
                                    .WithIntervalInSeconds((int)endpoint.Schedule.Every.TotalSeconds)
                                    .WithRepeatCount(endpoint.Schedule.Repeat))
                                .Build();
                        }
                    }
                    else
                    {
                        if (job.ConcurrentExecutionDisallowed)
                        {
                            trigger = TriggerBuilder.Create()
                                .StartNow()
                                .WithSimpleSchedule(x => x
                                    .WithIntervalInSeconds((int)endpoint.Schedule.Every.TotalSeconds)
                                    .RepeatForever()
                                    .WithMisfireHandlingInstructionIgnoreMisfires())
                                .Build();
                        }
                        else
                        {
                            trigger = TriggerBuilder.Create()
                                .StartNow()
                                .WithSimpleSchedule(x => x
                                    .WithIntervalInSeconds((int)endpoint.Schedule.Every.TotalSeconds)
                                    .RepeatForever())
                                .Build();
                        }

                    }
                }
                await _scheduler.ScheduleJob(job, trigger);
            }
        }

        public async Task StopAsync(CancellationToken cancellationToken)
        {
            if (_scheduler != null)
                await _scheduler.Shutdown(false);
        }
    }
}
