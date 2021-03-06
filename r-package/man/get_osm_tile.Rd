% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/maps.R
\name{get_osm_tile}
\alias{get_osm_tile}
\title{Get OSM Vector Tiles}
\usage{
get_osm_tile(
  map,
  key = "highway",
  value = c("motorway", "primary", "secondary", "tertiary")
)
}
\arguments{
\item{map}{sp or sf object as input}

\item{key}{OSM feature key; To see list of features run osmdata::available_features()}

\item{value}{value for feature key; can be negated like as value = "!this", and can also be a vector, value = c ("primary", "secondary").
To see related values to specific key use osmdata::available_tags("highway").}
}
\value{
opq object
}
\description{
Get OSM Vector Tiles
}
\examples{
library(ggplot2)
osm <- get_osm_tile(city[city$name_en == "Qom",])
ggplot()+
  geom_sf(data = osm$osm_lines) + theme_map()
}
