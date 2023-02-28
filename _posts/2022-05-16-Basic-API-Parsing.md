---
layout: post
title: Basic API Parsing in R
date: 2022-05-16 11:00
tags:
  - R_Hacks
  - tech
---

A common and efficient way to retrieve certain types of data is to request it from an online API.  This is especially true in situations when the source data is refreshed frequently, or where only small numbers of records are needed at any given time.  A good example of this would be address level geocoding, where a single address is submitted to an API and a single pair of coordinates is returned.  As we'll see, R is eminently suited for this sort of operation.

## Where's the Data?

A couple great examples of public data sets which are available through APIs are these.

* [US Census Geocoder](https://geocoding.geo.census.gov/)
* [FCC Census data API](https://geo.fcc.gov/api/census/)

The 1st API is the US Census Geocoder. It takes an address as input and returns geographic coordinates (and some other data as well).  Here's an example for an address located in Bellevue, WA.

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

If we look at the structure of a request to the census.gov geocoding API, we can see that it is structured in a very specific way.  We can break that request URL into 2 parts, the base URL and the request itself, which are separated by a "?".

__Base URL:__

> `https://geocoding.geo.census.gov/geocoder/locations/address?`

__Request Parameters:__

> `street=3305+160th+Ave+SE&city=Bellevue&state=WA&benchmark=2020&format=json`

The Request Parameters are further broken down into parts which are separated by either "+" or "&" symbols.  The "+" symbols are used to replace spaces, the "&" is used to actually separate the parameter values from one another.  

Looking at our original address and then comparing it to the Request Parameters - which we split at the "&" into a new line for each parameter" - we can see the following:

```
# Address
3305 160th Ave SE, Bellevue, WA 98008
```

__Vs.__

```
# Request Params
street=3305+160th+Ave+SE&
city=Bellevue&
state=WA&
benchmark=2020&
format=json
```

This is pretty self-explanatory, but in the way we're using the API, we have split our original full address into, _Street_ address, _City_ and _State_ fields and replaced the spaces with "+" symbols.  Also, as the anal-retentive will have noticed, we have omitted the ZipCode from the original Full Address in our request. Omitting the zip is possible because the docs state, 

> "_Not all parts need to be specified_".  

This is one main uses of a geocoding API, to flesh out the parts of an address that we don't know.  Although we didn't supply the ZipCode as part of our request, the API still returned one as part of its response.  

The "benchmark" parameter is used to specify what version of underlying data we want the API to query.  In this case, it's 2020 Census data. And the "format" parameter is saying that we want the results returned to us in JSON.

_(If we want to better understand how the API works, we can look at the [documentation](https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html/).  Doing so will tell what is expected in each parameter of the request, as well as other functional options for the API)_

### R Code

There are plenty of comments in the code below, but here is a summary of what it does.  

1. The `getGeocodeCoords()` function takes _street_, _city_ and _state_ as input parameters
2. All spaces in the input data are replaced with "+" symbols and a _requestURL_ is built
3. `httr` package is used to submit the _requestURL_ as a "GET" request
4. Response is checked and if it succeeded...
5. Response is converted by `httr` from JSON into a deeply nested list 
6. Geographic coordinates are extracted from the list and returned

__Code Execution:__

```
getGeocodeCoords(street = "3305 160th Ave SE", city = "Bellevue", state = "WA")`
```
__Response:__

```
> foo$x
[1] -122.1276

> foo$y
[1] 47.58351
```

__R Code:__
```
getGeocodeCoords <- function (
    street = NULL,
    city = NULL,
    state = NULL
) {
  library(httr)
  library(stringr)
  
  baseURL <- "https://geocoding.geo.census.gov/geocoder/locations/address?"
  
  # Function to replace spaces with "+" symbol
  spaceReplace <- function(df) {stringr::str_replace_all(df, "[ ]", "+")}
  
  # Build the request string
  request <- spaceReplace(paste0("street=", street, 
                                 "&city=", city, 
                                 "&state=", state, 
                                 "&benchmark=2020", 
                                 "&format=json"))
  
  # Tack the base address and request string together 
  requestURL <- paste0(baseURL, request)
  
  # Make the actual request as a "GET" command
  response <- httr::GET(requestURL)
  
  # Status tells us if the request was successful, etc
  status <- httr::http_status(response)
  
  # Check that the request succeeded before proceeding further
  if (status$message == "Success: (200) OK") {
    # Parse the response
    response_data <- httr::content(response)
   
    # Extract the coordinates from the response
    coordinates <- response_data$result$addressMatches[[1]]$coordinates
   
    return(coordinates)
  } else {
    # Do something meaningful 
    sprintf("There was an error getting this request: \n", requestURL )
  }
}
```
