---
layout: post
title: Simple Map Plots in R
date: 2021-12-5 11:00
tags:
  - R_Hacks
---

Sometime ago, a former coworker told me that they thought using R for GIS was one of the dumbest things they had ever heard of.  I have to imagine they didn't really have any firsthand knowledge of the topic, as my experience tells me R is VERY capable of being used to do GIS tasks.  Plenty of quality GIS work has been done in R with long-standing libraries like [raster](https://cran.r-project.org/web/packages/raster/index.html) and [sp](https://cran.r-project.org/web/packages/sp/index.html).  However, the release of the [sf package](https://cran.r-project.org/web/packages/sf/index.html) a few years ago made R even more powerful and easier to use for GIS.  Using the same underlying libraries as PostGIS; GDAL, GEOS and PROJ - sf now shares a very similar command syntax and data model with a tool that is known as one of the finest GIS applications ever built.  One thing R does better though is to actually provide a visualization interface for simple maps using the base _plot_ command.

Most articles on using R for map visualization focus on using additinal libraries such as [ggplot2](https://r-spatial.org/r/2018/10/25/ggplot2-sf.html) and others to enable sophisticated plotting options.  However, many times this isn't needed.  This post captures a few simple plotting techniques that can be used for rapid visualizations to validate assumptions, or find problems.

## Plot 1:

![simple_poly]({{ site.baseurl }}/images/wa_state.PNG)

