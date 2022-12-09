---
layout: post
title: Thinking Spatially in A Non-Spatial Context
date: 2022-12-9 11:00
tags:
  - R_Hacks
  - GIS
---
  
It's always surprising to me - and gratifying - when I see how simple concepts in GIS are still of great utility.  There's no lack of complicated _Spatial Data Science_, with sophisticated ML modeling and complex raster processing and analysis, taking place.  Sometimes though, all we really need to know is, "how far away is Point A from Point B?", and funnily enough - we often still struggle to answer this simple question.

![simple_index]({{ site.baseurl }}/images/wa_class_1_to_3_hospitals.png)

Take the image above, where the black points represent Level 1 - 3 Trauma Centers (TC) located in Washington State.

  * How many TC are within 60 miles of each city?  
  * What is the closest Level 1 or Level 2 TC to each city? 
  * How far away is the closest TC to each city?

It's these types of questions that still drive many decisions in both business and in our personal lives.  In this post, I'm going to dig into why it can still be a challenge to answer these questions efficiently and flexibly, as well as present a solution which I feel is often overlooked.
