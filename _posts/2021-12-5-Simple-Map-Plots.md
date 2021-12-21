---
layout: post
title: Simple Map Plots in R
date: 2021-12-5 11:00
tags:
  - R_Hacks
---

Sometime ago, a person I used to work with told me that they thought using R for GIS was one of the dumbest things they had ever heard of.  I'd like to think this was done just to get a rise out of me, but regardless of why they said it, the comment stuck with me.  I have to imagine that they didn't really have any firsthand knowledge of the topic, since my experience tells me that R is very capable of being used to do GIS tasks.  With the realease of the [sf package](https://cran.r-project.org/web/packages/sf/index.html) a few years ago, R is just as capable as PostGIS for GIS, especially as they both use the same underlying libraries; GDAL, GEOS and PROJ. One thing R does better though is to actually provide a visualization interface for simple maps using the base _plot_ command with sf objects.  This post captures a few simple plotting techniques that are useful for rapid visualizations.

## Plot 1:

![simple_poly]({{ site.baseurl }}/images/wa_state.PNG)

