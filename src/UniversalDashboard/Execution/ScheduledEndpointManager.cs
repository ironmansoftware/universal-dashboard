using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Hosting;
using Quartz;
using Quartz.Impl;
using Quartz.Impl.Matchers;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using UniversalDashboard.Interfaces;
using UniversalDashboard.Services;

namespace UniversalDashboard.Execution
{
    public class ScheduledEndpointManager : IHostedService
    {
        private static IScheduler _scheduler;
        private readonly IExecutionService _executionService;
        private readonly IMemoryCache _memoryCache;
        private readonly IDashboardService _dashboardService;
        public readonly Guid Id = Guid.NewGuid();

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

            if (_scheduler != null)
            {
                await _scheduler.Shutdown(false);
                _scheduler = null;
            }

            _scheduler = await factory.GetScheduler();
            await _scheduler.Start();

            foreach (var endpoint in endpoints.Where(m => m.Schedule != null))
            {
                var dataMap = new JobDataMap();
                IJobDetail job;

                dataMap.Add(nameof(ScheduledEndpointJob.Endpoint), endpoint);
                dataMap.Add(nameof(ScheduledEndpointJob.ExecutionService), _executionService);
                dataMap.Add(nameof(ScheduledEndpointJob.MemoryCache), _memoryCache);

                if (endpoint.Schedule.Consecutive)
                {
                    job = JobBuilder.Create<ScheduledEndpointJobConsecutive>()
                    .UsingJobData(dataMap)
                    .Build();
                }
                else
                {
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

            if (_dashboardService.Dashboard != null)
            {
                var dataMap = new JobDataMap();
                dataMap.Add(nameof(SessionTimeoutJob.IdleTimeout), _dashboardService.Dashboard.IdleTimeout);

                var job = JobBuilder.Create<SessionTimeoutJob>()
                .UsingJobData(dataMap)
                .Build();

                var trigger = TriggerBuilder.Create()
                                .StartNow()
                                .WithSimpleSchedule(x => x
                                    .WithIntervalInSeconds((int)_dashboardService.Dashboard.IdleTimeout.TotalSeconds)
                                    .RepeatForever())
                                .Build();

                await _scheduler.ScheduleJob(job, trigger);
            }

        }

        public async Task StopAsync(CancellationToken cancellationToken)
        {
            if (_scheduler != null)
                await _scheduler.Shutdown(false);
        }

        public async Task<IEnumerable<object>> GetUpcomingJobs() 
        {
            var list = new List<object>();
            var jobGroups = await _scheduler.GetJobGroupNames();

            foreach (string group in jobGroups)
            {
                var groupMatcher = GroupMatcher<JobKey>.GroupContains(group);
                var jobKeys = await _scheduler.GetJobKeys(groupMatcher);
                foreach (var jobKey in jobKeys)
                {
                    var detail = await _scheduler.GetJobDetail(jobKey);
                    var triggers = await _scheduler.GetTriggersOfJob(jobKey);

                    list.Add(new {
                        Detail = detail,         
                        Triggers = triggers
                    });
                }
            }

            return list;
        }
    }
}
