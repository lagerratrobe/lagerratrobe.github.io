---
layout: post
title: Basic API Parsing in R
date: 2022-05-16 11:00
tags:
  - R_Hacks
  - tech
---

An extrememly common and efficient way to retrieve certain types of data is to request it from an online API.  This is especially true in situations where the source data is refreshed frequently, or when only small numbers of records are needed at any given time.  A good example of this would be address level geocoding, where a single address is submitted to the API and a single pair of coordinates is reurned.  As we'll see, R is eminently suited for this sort of operation.

## Where's the Data?

In the last 10 years, or so, the U.S. government has made great strides in making public data available through APIs.  Below are 2 good examples:

* [US Census Geocoder](https://geocoding.geo.census.gov/)
* [FCC Census data API](https://geo.fcc.gov/api/census/)

The 1st API is the US Census Geocoder. It takes an address as input and returns to us geographic coordinates.  Here's an example for an address located in Bellevue, WA.

> 3305 160th Ave SE, Bellevue, WA 98008.

__Request:__
```
https://geocoding.geo.census.gov/geocoder/locations/address?street=3305+160th+Ave+SE&city=Bellevue&state=WA&benchmark=2020&format=json
```

__Response:__
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

The 2nd API takes in a geographic coordinate and returns US Census block level information such as population and the _block_fips_ identifier code.  The _block_fips_ can be used to access additional demographic information about the area using tools such as [TidyCensus](https://walker-data.com/tidycensus/)

__Request:__
```
https://geo.fcc.gov/api/census/area?lat=47.583504&lon=-122.127556
```

__Response:__
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

## Get the Data!

Now that we know where, and how, to get some data, it's time to build an R function that will allow us to quickly and easily use these APIs.  We want a function into which we can pass our input data into, which then queries the API, evaluates the results and returns to us the information that we're interested in.  

If we look at the structure of a request to the census.gov geocoding API, we can see that it is structured in a very specific way.  We can break that request URL into 2 parts, the base URL and the request itself.

__Base URL:__

> `https://geocoding.geo.census.gov/geocoder/locations/address?`

__Request Parameters:__

> `street=3305+160th+Ave+SE&city=Bellevue&state=WA&benchmark=2020&format=json`

The request parameters are further broken down into parts which are separated by an ampersand, "&", symbol.  If we want to better understand how the API works, we can look at the [documentation](https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html/).  Doing so will tell what is expected in each parameter of the request.  It will also tell us that the API can work in a a single record mode, or in a batch mode.  Batch mode is outside the scope of this article, but might be fun to try, if you're interested.  Coming back to our parameters though, we can see the following:

```
street=3305+160th+Ave+SE&
city=Bellevue&
state=WA&
benchmark=2020&
format=json
```

This is pretty self-explanatory, but it's probably worth the effort of reading the docs if you intend to use this api.  Briefly though, in the way we're using it, we have split the street address from the City and State, replaced spaces with "+" symbols and, the anal-retentive will have noticed, we omitted the zipcode from the request.  Omitting the zip is possible because the docs state, 

> "_Not all parts need to be specified_".  

The "benchmark" parameter is specifying what version of data we want queried, in this case 2020 Census data and the "format" parameter is saying that we want the results returned to us in JSON.

### R Code


