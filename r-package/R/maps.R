#' Iran's Provinces Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irProvinces()
#' ggplot(map) + geom_sf()
irProvinces <- function(){
  return(IRMaps::province)
}

#' Iran's Counties Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irCounties()
#' ggplot(map) + geom_sf()
irCounties <- function(){
  return(IRMaps::county)
}

#' Iran's Districts Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irDistricts()
#' ggplot(map) + geom_sf()
irDistricts <- function(){
  return(IRMaps::district)
}

#' Iran's Rurals Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irRurals()
#' ggplot(map) + geom_sf()
irRurals <- function(){
  return(IRMaps::rural)
}

#' Iran's Cities Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irCities()
#' ggplot(map) + geom_sf()
irCities <- function(){
  return(IRMaps::city)
}

#' Iran's Natural Features Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irFeatures()
#' ggplot(map) + geom_sf()
irFeatures <- function(){
  return(IRMaps::iran_feature)
}

#' Iran's Border Provinces Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irBorderProvinces()
#' ggplot(map) + geom_sf()
irBorderProvinces <- function(){
  return(IRMaps::iran_boundary)
}

#' Iran's Border Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot)
#' map <- irBorders()
#' ggplot(map) + geom_sf()
irBorders <- function(){
  return(IRMaps::iran_border)
}


#' Get Map Tiles
#'
#' @param map an sf, sfc, bbox object.
#' @param provider 	the tile server from which to get the map. Providers contains:
#' "OpenStreetMap", "OpenStreetMap.MapnikBW", "OpenStreetMap.HOT", "Stamen.Toner",
#' "Stamen.TonerBackground", "Stamen.TonerLite", "Stamen.Watercolor", "Stamen.Terrain",
#' "Stamen.TerrainBackground", "Esri.WorldStreetMap", "Esri.DeLorme", "Esri.WorldTopoMap",
#' "Esri.WorldImagery", "Esri.WorldTerrain", "Esri.WorldShadedRelief", "Esri.OceanBasemap",
#' "Esri.NatGeoWorldMap", "Esri.WorldGrayCanvas", "CartoDB.Positron", "CartoDB.PositronNoLabels",
#' "CartoDB.DarkMatter", "CartoDB.Voyager", "CartoDB.VoyagerNoLabels", "OpenTopoMap", "HikeBike", "Wikimedia"
#
#' @param zoom 	the map zoom level between 1 to 20.
#'
#' @return data.frame with x,y and hex column
#' @export
#'
#' @examples
#' library(ggplot2)
#' raster_tile <- get_raster_tile(iran_border,provider = "Wikimedia",zoom = 7)
#' ggplot() +
#' geom_raster(data = ir_raster,aes(x, y, fill = hex)) +
#' geom_sf(data = iran_border,color = "blue",alpha = 0.1) +
#' scale_fill_identity() +
#' theme_void()
get_raster_tile <- function(map, provider,zoom){
  tile <- maptiles::get_tiles(x = map, provider = "OpenStreetMap.HOT",
                         crop = TRUE,
                         zoom = zoom, verbose = FALSE)

  tile %>%
    terra::as.data.frame(xy = TRUE) %>%
    as_tibble() %>%
    mutate(hex = grDevices::rgb(red, green, blue, maxColorValue = 255)) %>%
    select(x,y,hex) %>% return()
}


#' Get Elevation Map
#'
#' @param map Either a data.frame of x (long) and y (lat), an sp, sf, or raster object as input.
#' @param zoom The map zoom level between 1 to 20.
#'
#' @return
#' @export
#'
get_elevation_tile <- function(map,zoom){
  elevation <- elevatr::get_elev_raster(locations = map,
                                  clip = "locations", z = zoom, src="aws")
  elevation <- terra::as.data.frame(elevation, xy = TRUE)
  colnames(elevation)[3] <- "elevation"
  return(elevation[complete.cases(ir_elevation), ])
}

#' Get OSM Vector Tiles
#'
#' @param map sp or sf object as input
#' @param key OSM feature key; To see list of features run osmdata::available_features()
#' @param value value for feature key; can be negated like as value = "!this", and can also be a vector, value = c ("primary", "secondary").
#' To see related values to specific key use osmdata::available_tags("highway").
#'
#' @return opq object
#' @export
#'
#' @examples
#' osm <- get_osm_tile(city[city$name_en == "Qom",])
#' ggplot()+
#'   geom_sf(data = osm$osm_lines)
get_osm_tile <- function(map, key = "highway",
                         value = c("motorway", "primary", "secondary", "tertiary")){
  map <- sf::st_transform(map,"+proj=longlat +datum=WGS84")
  sf::st_bbox(map) %>%
    osmdata::opq() %>%
    osmdata::add_osm_feature(key = key, value = value) %>%
    osmdata::osmdata_sf() %>%
    return()
}



