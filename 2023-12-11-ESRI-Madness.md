---
layout: post
title: ESRI Madness
date: 2023-12-11 11:00
tags:
  - gis
---

I read about a cool new data set in the ArcUser ESRI rag, a new "Watershed Boundary Dataset".  I go to the link in the article, "https://shorturl.at.oBF36" and land on the arcgis.com page.  I click on the Data tab and I see that the data is broken up into 22 features, but there is no download option.  I go back to the original page and I see there is a "URL" link at the lower right.  I go there and I get some metadata about the data set.  I still can't see any of the data,   but there's a "Sources" link though.  I follow it and there is another link to a feature server, "HU02_WBD (FeatureServer)".  I follow that and I get to a page that says "Token Required".  At this point, I've wasted 15 minutes of my life that I won't get back so I try something else.  

I then do a Google search for "USGS Watershed Boundary Dataset".  I go to https://www.usgs.gov/national-hydrography/watershed-boundary-dataset  I follow the link to "WBD Data downloads and services", https://www.usgs.gov/national-hydrography/access-national-hydrography-products.

I see the following:

> The Watershed Boundary Dataset (WBD) is available in shapefile and file geodatabase formats

- Download the WBD by 2-digit Hydrologic Unit (HU2) - dataset generated only when edits are performed
- Download the WBD by the Entire Nation - monthly

I choose "Entire Nation" and am presented what I *think* is an option to download either a Geodatabase, "GDB", or a geopackage *maybe?* "GPKG".  I choose the GDB option because it is smaller.  https://prd-tnm.s3.amazonaws.com/index.html?prefix=StagedProducts/Hydrography/WBD/National/GDB/

(I note that it's an S3 bucket)

5 min after Google search, I have data on my hardrive.  This is why I'm not a fan of using ESRI services to get my public data.
