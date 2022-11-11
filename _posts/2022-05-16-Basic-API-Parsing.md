---
layout: post
title: Basic API Parsing in R
date: 2022-05-16 11:00
tags:
  - R_Hacks
---

A really great way to retrieve certain types of data is to request it from an online API.  This is especially true in situations where the source data is refreshed frequently, or when only small numbers of records are needed at any given time.  A good example of this would be address level geocoding, where a single address is submitted to the API and a single pair of coordinates is reurned.  As we'll see, R is eminently suited for this sort of data lookup.

## Where's the Data?

Of course, in order for this to work, you need to have a data source.  Fortunatley for those of us living in the U.S., there are many outstanding data APIs available to us from the federal government.  A couple good examples are the 2 listed below:

* (US Census Geocoder)[https://geocoding.geo.census.gov/]
* (FCC Census data API)[https://geo.fcc.gov/api/census/]

The 1st API we'll look at is the US Census Geocoder. We give it an address and it returns to us geographic coordinates.  Here's an example for an addresslocated in Bellevue, WA - 3305 160th Ave SE, Bellevue, WA 98008.

Request:
```
https://geocoding.geo.census.gov/geocoder/locations/address?street=3305+160th+Ave+SE&city=Bellevue&state=WA&benchmark=2020&format=json
```

Response:
```
{
    "result": {
        "input": {
            "benchmark": {
                "id": "2020",
                "benchmarkName": "Public_AR_Census2020",
                "benchmarkDescription": "Public Address Ranges - Census 2020 Benchmark",
                "isDefault": false
            },
            "address": {
                "street": "3305 160th Ave SE",
                "city": "Bellevue",
                "state": "WA"
            }
        },
        "addressMatches": [
            {
                "matchedAddress": "3305 160TH AVE SE, BELLEVUE, WA, 98008",
                "coordinates": {
                    "x": -122.127556,
                    "y": 47.583504
                },
                "tigerLine": {
                    "tigerLineId": "187062286",
                    "side": "L"
                },
                "addressComponents": {
                    "fromAddress": "3399",
                    "toAddress": "3301",
                    "preQualifier": "",
                    "preDirection": "",
                    "preType": "",
                    "streetName": "160TH",
                    "suffixType": "AVE",
                    "suffixDirection": "SE",
                    "suffixQualifier": "",
                    "city": "BELLEVUE",
                    "state": "WA",
                    "zip": "98008"
                }
            }
        ]
    }
}
```

Second API:
```
https://geo.fcc.gov/api/census/area?lat=47.583504&lon=-122.127556
```

Response:
```
{
    "input": {
        "lat": 47.583504,
        "lon": -122.127556,
        "censusYear": "2020"
    },
    "results": [
        {
            "block_fips": "530330234032001",
            "bbox": [
                -122.136386,
                47.579037,
                -122.121657,
                47.589004
            ],
            "county_fips": "53033",
            "county_name": "King County",
            "state_fips": "53",
            "state_code": "WA",
            "state_name": "Washington",
            "block_pop_2020": 86,
            "amt": "data unavailable",
            "bea": "data unavailable",
            "bta": "data unavailable",
            "cma": "data unavailable",
            "eag": "data unavailable",
            "ivm": "data unavailable",
            "mea": "data unavailable",
            "mta": "data unavailable",
            "pea": "data unavailable",
            "rea": "data unavailable",
            "rpc": "data unavailable",
            "vpc": "data unavailable"
        }
    ]
}

```




