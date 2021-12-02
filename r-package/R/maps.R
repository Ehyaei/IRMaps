#' Iran's Provinces Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irProvinces()
#' ggplot(map) + geom_sf() + theme_map()
irProvinces <- function(){
  return(IRMaps::province)
}

#' Iran's Counties Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irCounties()
#' ggplot(map) + geom_sf() + theme_map()
irCounties <- function(){
  return(IRMaps::county)
}

#' Iran's Districts Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irDistricts()
#' ggplot(map) + geom_sf() + theme_map()
irDistricts <- function(){
  return(IRMaps::district)
}

#' Iran's Rurals Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irRurals()
#' ggplot(map) + geom_sf() + theme_map()
irRurals <- function(){
  return(IRMaps::rural)
}

#' Iran's Cities Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irCities()
#' ggplot(map) + geom_sf() + theme_map()
irCities <- function(){
  return(IRMaps::city)
}

#' Iran's Natural Features Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irFeatures()
#' ggplot(map) + geom_sf() + theme_map()
irFeatures <- function(){
  return(IRMaps::iran_feature)
}

#' Iran's Border Provinces Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irBorderProvinces()
#' ggplot(map) + geom_sf() + theme_map()
irBorderProvinces <- function(){
  return(IRMaps::iran_boundary)
}

#' Iran's Border Map
#'
#' @return sf object map
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irBorders()
#' ggplot(map) + geom_sf() + theme_map()
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
#' @import dplyr
#' @export
#'
#' @examples
#' library(ggplot2)
#' raster_tile <- get_raster_tile(iran_border,provider = "Wikimedia",zoom = 7)
#' ggplot() +
#' geom_raster(data = raster_tile, aes(x, y, fill = hex)) +
#' geom_sf(data = iran_border,color = "blue",alpha = 0.1) +
#' scale_fill_identity() +
#' theme_void()
get_raster_tile <- function(map, provider,zoom){
  tile <- maptiles::get_tiles(x = map, provider = provider,
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
#' @examples
#' library(ggplot2)
#' rural <- irRurals()
#' tehran = rural[rural$name_en == "Tehran", ]
#' dem_tehran = get_elevation_tile(tehran, 12)
#' ggplot(dem_tehran, aes(x, y, fill = elevation))+
#'   geom_raster()+
#'   theme_map()+
#'   fullView()+
#'   scale_fill_map(palette = "Earth")+
#'   coord_fixed()
get_elevation_tile <- function(map,zoom){
  elevation <- elevatr::get_elev_raster(locations = map,
                                  clip = "locations", z = zoom, src="aws")
  elevation <- terra::as.data.frame(elevation, xy = TRUE)
  colnames(elevation)[3] <- "elevation"
  return(elevation[complete.cases(elevation), ])
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
#' library(ggplot2)
#' osm <- get_osm_tile(city[city$name_en == "Qom",])
#' ggplot()+
#'   geom_sf(data = osm$osm_lines) + theme_map()
get_osm_tile <- function(map, key = "highway",
                         value = c("motorway", "primary", "secondary", "tertiary")){
  map <- sf::st_transform(map,"+proj=longlat +datum=WGS84")
  sf::st_bbox(map) %>%
    osmdata::opq() %>%
    osmdata::add_osm_feature(key = key, value = value) %>%
    osmdata::osmdata_sf() %>%
    return() # TODO: check crs
}
