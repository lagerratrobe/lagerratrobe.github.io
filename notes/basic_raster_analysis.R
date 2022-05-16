# ---- Create a simple data set with some WA city points -----------------------
library(sf)
library(dplyr)
library(raster)

sea <- c("Seattle",47.609722,-122.333056)
spk <- c("Spokane",47.658889,-117.425)
sql <- c("Sequim",48.078056,-123.101389)
pyl <- c("Puyallup",47.175833,-122.293611)
plm <- c("Pullman",46.733333,-117.166667)

city_df <- do.call("rbind", list(sea,spk,sql,pyl,plm)) %>% data.frame()
names(city_df) <- c("name", "latitude", "longitude")

city_df$latitude <- as.numeric(city_df$latitude)
city_df$longitude <- as.numeric(city_df$longitude)

# Convert to sf spatial object  
city_sf <- st_as_sf(city_df, coords = c("longitude", "latitude"), crs = 4326)

# ---- Create a simple 9-pixel (3x3) georeferenced raster ----------------------
simple_matrix <- matrix(seq(1,9),
                        nrow = 3,
                        ncol = 3,
                        byrow = TRUE)

simple_raster <- raster(simple_matrix)

# [Assign] extent     : 0, 1, 0, 1  (xmin, xmax, ymin, ymax)
extent(simple_raster) <- c(-123.125,-117.125,44.0, 50.0)

# [Assign] crs        : +proj=longlat +datum=WGS84 
projection(simple_raster) <- CRS("+proj=longlat +datum=WGS84")

# ---- Plot the city points on top of the raster -------------------------------
plot(simple_raster)
plot(city_sf$geometry, add=TRUE)
text(st_coordinates(city_sf), pos=1, city_sf$name, cex=0.75)


# ---- Extract the raster cell_number, row and column for each city point ------
city_sf$cell_number <- raster::extract(simple_raster, city_sf)

city_sf$column <- colFromX(simple_raster, st_coordinates(city_sf)[,1])
city_sf$row <- rowFromY(simple_raster, st_coordinates(city_sf)[,2])

city_sf

