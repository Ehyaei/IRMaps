% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/palette.R
\name{map_raw_palettes}
\alias{map_raw_palettes}
\title{Access palette colors}
\usage{
map_raw_palettes(palette)
}
\arguments{
\item{palette}{the name of palette}
}
\value{
vector of hex colors
}
\description{
Access palette colors
}
\examples{
cols <- map_raw_palettes("BYR")
cols
scales::show_col(cols)
}
