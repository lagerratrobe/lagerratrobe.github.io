---
layout: post
title: AWS Unfuzziness
date: 2022-8-10 14:00
tags:
  - tech
---

Well, I suppose it's high time for a Rant, don't you think?  Given the amount of time that I have wasted on AWS account management in the past month, I thought I'd write about how little enthusiasm I have for that platform right now.

### Context
I wanted to step outside my usual box and use an S3 bucket to store public weather data that I'm scraping out of wunderground.com.  Utimately I want to create some Shiny apps that use this data and I wanted it to be publicly available and easy to access.  So I setup a quick and dirty R scraper on a Raspberry Pi that pulls hourly weather obs from a small set of stations around the country and writes it into an S3 bucket as an RDS file.

### Public Access "Bad"
The 1st problem I hit was that Amazon didn't like that I had made my S3 bucket object publicly acessible.  I wanted it to be only writable by me, but readable by "All".  I set the permissions for that and tested that it worked and shutdown for the day.  The next morning I had an open ticket from AWS Support telling me that I needed to lock down my account.  They didn't give me any specifics, but I also saw that my bucket object was no longer accessible by URL link anymore.

That saga ended after I set the entire bucket (not just the object) to have the permissions I wanted.  The need for this was described in a pretty opaque way, but after some trial and error, it *seemed* to work.

### Account Login Hell
This morning I went to pull the RDS file and saw that it hasn't been written to in a couple days.  I ran the update script manually and say that it was getting an error saying that the auth credentials are bad.  Now these are a key and secret combo that are passed in by the S3 connection library and hadn't changed since I set the bucket up.  So I tried to login to the AWS Management Console and received a message saying that my account had been supended.

After creating 3 issue tickets explaining that, "no, I have not forgotten my acct password" and being told, "for security reasons we cannot tell you why the account was suspended", I think I have come up with a solution.

### Don't Use AWS
For what I'm trying to do, it's clear AWS is overkill and unnecessary.  I will find another way to make this work and in fact, if I *could* login to my AWS account, the 1st thing I would do is close it.  However, this has been a good learning lesson for me though.

1. Don't rely solely on AWS (or probably *ANY* cloud based storage) to safeguard your data.  I've lost 1 month's worth of hourly weather data because I didn't write out a local copy of the data every time I updated it.  That was dumb on my part.
2. Provisioning and administration of AWS accounts is just as much a task (maybe more even) than accessing and using the S3 objects in code.  I should have known this already after some EC2 work I did 10 years ago, but I had forgotten.
3. Amazon can piss off.  Really, there are better things for me to do that fight this any further.