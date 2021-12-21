---
layout: post
title: Simple Map Plots in R
date: 2021-12-5 11:00
tags:
  - R_Hacks
---

Most articles written about using R for map visualization focus on using libraries such as [ggplot2](https://r-spatial.org/r/2018/10/25/ggplot2-sf.html) and others to enable sophisticated plotting options.  However, many times this isn't needed as _sf_ (and most other spatial packages) supports basic plotting operations natively.  This post captures a some simple techniques that can be used for rapid visualizations to validate assumptions and find problems.

## Plot 1:

![simple_poly]({{ site.baseurl }}/images/wa_state.PNG)

### Code

```
library(sf)
library(dplyr)

wa_state <- st_read("C:/Users/RAndre1/Documents/Work_Docs/GIS_DATA/wa_state.shp")
wa_cities <- st_read("C:/Users/RAndre1/Documents/Work_Docs/GIS_DATA/sample_wa_cities.shp")

plot(wa_state$geometry)
plot(wa_cities$geometry, add = TRUE, pch=20, col='red')
text(st_coordinates(wa_cities), pos=1, wa_cities$Name, cex=0.75, col = 'red')

st_centroid(wa_state) %>% 
  st_coordinates() %>% 
  text(pos=3, wa_state$Name, cex=1.25)
```

