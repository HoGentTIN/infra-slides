---
title: "Monitoring"
subtitle: "Infrastructure Automation<br/>HOGENT applied computer science"
author: Bert Van Vreckem & Thomas Aelbrecht
date: 2022-2023
---

# Monitoring

## Learning goals

- Understanding the concept of monitoring, observability
- Setting up a monitoring dashboard with Prometheus

## What is monitoring?

Keep track of systems running in production

- Problem detection
- Troubleshooting
- Reporting and improvement

Part of *Reliability Engineering*

## What to monitor?

Anything that matters for your business! -> monitoring targets

- Demand
- Workload
    - Availability, performance, faults/errors
- Resources (technical metrics)
    - e.g. CPU, connection pool capacity, ...
- Business metrics

## Early monitoring solutions: Alerting

- Nagios, Icinga, Zmon, Sensu, ...
- Regularly execute checks (scripts)
- Nonzero exit status? Generate alert!

![](assets/Nagios.png)

## Early monitoring solutions: Graphing

- E.g. Graphite, mrtg
- Backed by time series database filled with metrics
- Separate tool for data collection (e.g. collectd, statsd)

![](assets/Graphite.png)

## #monitoringsucks

- Trending in 2011
- Cloud (r)evolution
    - Scaling up, automation
    - Servers as pets -> servers as cattle
- Many tools, not suited for new needs
    - Not scaleable
    - Manual approach to system administration
    - Too many alerts

## Characteristics

- Graphing/alerting are separate
- Manual approach to system administration
- No specific tools for log mgmt (tail, grep, awk!)

## Monitoring in a DevOps world

- Self service: 
- Dynamic
- 