#' Add map meta data to points
#'
#' @param data data.frame contains lng and lat columns
#' @param map sf polygons objects contain
#' @param feature string vector contains list of feature that must be added to data
#'
#' @return data.frame
#' @export
#'
#' @examples
#' point2Info(mountains,province,features= c("name"))
#' df <- data.frame(lng = c(51.42,59.55), lat = c(35.69,36.29))
#' point2Info(df, province, features = "name")
point2Info <- function(data, map, features = "province_code"){

  # convert data.frame to spatial
  spatialPoints =  sf::st_as_sf(data, coords = c("lng","lat"), crs = 4326)

  # extract index if polygons
  geoIndex = sf::st_intersects(spatialPoints,map)
  geoIndex = unlist(lapply(geoIndex, FUN = function(x){ifelse(is.null(x[1]),NA,x[1])}))

  # add features
  for(f in features){
    data[[f]] = map[[f]][geoIndex]
  }

  return(data)
}
