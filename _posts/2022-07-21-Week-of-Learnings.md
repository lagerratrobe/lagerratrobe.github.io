---
layout: post
title: Week of Learnings
date: 2022-7-21 11:00
tags:
  - tech
---

Phew, what a week so far!  Was on a call with a customer earlier in the week who had questions about how to do  certain worklflows using RStudio Connect.  I wasn't super comfortable with the answers we gave them and decided I wanted to do some testing to figure out a couple different solutions. I wanted the data in the tests to be useful (to me) in the fuure, so I decided to start pushing personal weather station readings into an S3 bucket.  I wanted these to be pulled on an hourly basis, so figured I would use my always-on Tritium NAS to run an R script that fetched data and pushed it to AWS.  All fine and dandy, but here are a couple things that I learned.

### Missing Gateway Problem
First off, I hit a really weird problem that prevented me from accessing github.com (and AWS, I later discovered).  Turns out the reason was that when I set the Tritium on a static IP, I incorrectly set the Gateway to "0.0.0.0".  So my /etc/network/interfaces looked like this:

```
# Network is managed by Network manager
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet static
      address 192.168.1.181
      netmask 255.255.255.0
      gateway 0.0.0.0
```

This was incorrect, but the manifestation of the problem was weird.  I could run "apt install" commands and ping "www.google.com", but other commands would give "Network unreachable" or "no route to host" errors.  Solution was easy, simply add the router's IP back in as the gateway in /etc/network/interfaces.

```
# Network is managed by Network manager
auto lo
iface lo inet loopback

# The primary network interface
allow-hotplug eth0
iface eth0 inet static
      address 192.168.1.181
      netmask 255.255.255.0
      gateway 192.168.1.1  <---
```

### Bad crontab Syntax

I mean, does anyone get crontabs right the 1st time?  In my case, the learning was that this sort of command syntax isn't liked.

```
0 * * * * Rscript /home/foo/UpdateWeather.R
```
Even though that works from the commandline, CRON wouldn't execute it.  What worked better was to add a shebang line in the script, `#! /usr/local/bin/Rscript`, and then call on the just the script itself in the crontab. Probably this could have been fixed by just putting the entire command in quotes, Rscript /home/foo/UpdateWeather.R", but I prefer this syntax anyhow.
```
0 * * * * /home/randre/Code/UpdateWeatherS3.R
```
This seems to be working fine now.

### Logging is Good

So it turns out that cron's logging in /var/log/syslog is kinda crappy.  It records when a user makes edits to their crontab, but not when the jobs actually executes.  You can change this behavior, but I found it expedient to just tack this on the very bottom of my script.  It's not good coding, by any means, but I can quickly verify that the job ran at least.

```
system("echo `date` >> /home/randre/Code/weather_update.log")
```
This logs the date and time the script ran and looks like this.

```
$ cat weather_update.log 
Thu 21 Jul 2022 10:00:11 AM PDT
Thu 21 Jul 2022 11:00:09 AM PDT
```

