% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/maps.R
\name{irDistricts}
\alias{irDistricts}
\title{Iran's Districts Map}
\usage{
irDistricts()
}
\value{
sf object map
}
\description{
Iran's Districts Map
}
\examples{
library(ggplot2)
map <- irDistricts()
ggplot(map) + geom_sf() + theme_map()
}
