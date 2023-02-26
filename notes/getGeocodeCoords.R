# getTbuildReport()

getTbuildReport <- function (
    list_id = 12542 # Hardcodeed to get the demo-data report for all stores
) {
  library(jsonlite)
  library(httr)
  
  baseURL <- "https://builder.rreis.com/api/list/"
  
  requestURL <- paste0(baseURL, list_id, "?")
  # Curl request looks like this:
  # curl -X GET \
  #   --header "X-TBApiToken: wMheRsWvrvY3DEMv4NuUWb9KFsqFcebW" \
  #   --header "Accept: application/vnd.tbuilder.v1+json" \
  #   "https://builder.rreis.com/api/list/12542?pageNumber=2"
  
  # Base function that makes request. Use this function later with paged URLs
  getURL <- function(URL) {
    
    GET(url = URL,
        add_headers(`X-TBApiToken` = 'u4FBuCbwCUhdAuzeyaF6vYVWu-zj7jFx'),
        add_headers(`Accept` = 'application/vnd.tbuilder.v1+json'),
        content_type('application/json'))
    
  }
  # Get the actual data
  response <- getURL(requestURL)
  
  # Status info here, tells us if the request was successful, etc
  status <- http_status(response)
  
  # ---- Get Page 1 --------------------------------------------------------------
  store_records <- data.frame()
  # Check that the request was ok before proceeding further
  if (status$message == "Success: (200) OK") {
    
    #Convert to JSON
    response_json <- content(response, "text", encoding = "UTF-8")
    
    # Convert JSON into list object that we can separate and parse
    response_data <- fromJSON(response_json,
                              simplifyVector = TRUE,
                              flatten = FALSE)
    
    # Starting Data Frame to hold all of the records.  Additional data should be added here
    store_records <- rbind(store_records, response_data$results)
    print("Fetched Page 1")
    
    # Figure out the total number of pages in the report
    page_info <- response_data$page
    total_records <- page_info$total
    page_size <- page_info$resultCount
    total_pages <- ceiling( total_records / page_size ) # use 'ceiling' because answer is 29.66
    
    if (total_pages == 1) {
      # Return records if we already got them all
      record_count <- nrow(store_records)
      print(sprintf("Returning %d of %d records", record_count, total_records))
      return(store_records)
      
    } else {
      # Make a request for each page in the set and add the results to store_records
      for(i in 2:total_pages){
        page_URL <- paste0(requestURL,
                           "pageNumber=",
                           i)
        new_page <- getURL(page_URL)
        new_page_response <- content(new_page, "text", encoding = "UTF-8")
        new_page_data <- fromJSON(new_page_response, simplifyVector = TRUE, flatten = FALSE)
        new_page_records <- new_page_data$results
        store_records <- rbind(store_records, new_page_records)
        print(sprintf("Fetched Page %d", i))
      }
      
      record_count <- nrow(store_records)
      print(sprintf("Returning %d of %d records", record_count, total_records))
      return(store_records)
    }
  } else {
    
    # Give the status response for the request, which should contain the error.
    stop(status$message)
    
  }
} # end of function
