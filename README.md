
<!-- README.md is generated from README.Rmd. Please edit that file -->

<a href={https://github.com/Ehyaei/IRMaps}><img src="r-package/man/figures/IRMaps.svg" alt="tiling logo" align="right" width="160" style="padding: 0 15px; float: right;"/>

# IRMaps

[![](https://img.shields.io/badge/devel%20version-0.1.0-orange.svg)](https://github.com/Ehyaei/IRMaps)
[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![](https://img.shields.io/github/last-commit/Ehyaei/IRMaps.svg)](https://github.com/Ehyaei/IRMaps/commits/main)

The goal of `IRMaps` is to prepare geographical maps and divisions of
Iran.

## Installation

You can install the development version of IRMaps from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Ehyaei/IRMaps",subdir = "r-package")
```

## Available Maps

The following maps in the form of sf object, are included in the
package.

-   Province (استان)
-   Country (شهرستان)
-   District (بخش)
-   City (شهر)
-   Rural District (دهستان)
-   Geographical Features (عوارض جغرافیایی)

``` r
library(IRMaps)
library(ggplot2)
library(dplyr)

provinces <- irProvinces()
counties <- irCounties()
districts <- irDistricts()
rurals <- irRurals()

map_Plotter <- function(map){
  ggplot(map)+
  geom_sf(aes(fill = area), size = 0.1, color = "white") +
  scale_fill_map(palette = "TealRode")+
  theme_map()+
  theme(legend.position = "none")+
  fullView()
}
gridExtra::grid.arrange(
  map_Plotter(provinces), map_Plotter(counties),
  map_Plotter(districts),map_Plotter(rurals),
                        nrow = 2)
```

<img src="r-package/man/figures/README-iran_maps-1.svg" width="100%" />

``` r
data_map <- merge(provinces, IRMaps::iran_population, by.x = "name_en", by.y = "Province") 
ggplot(data_map,aes(fill = RuralareasMale/RuralareasFemale))+
  geom_sf(color = "white",size = 0.1)+
  scale_fill_map(palette = "TealRode")+
  labs(fill = "Gender Ratio")+
  theme_map()+
  fullView()
```

<img src="r-package/man/figures/README-heatmap-1.svg" width="100%" />

``` r
raster_tile <- get_raster_tile(iran_border, provider = "Esri.WorldImagery",zoom = 7)
ggplot() +
  geom_raster(data = raster_tile, aes(x, y, fill = hex)) +
  scale_fill_identity() +
  theme_map()+
  fullView()
```

<img src="r-package/man/figures/README-WorldImagery-1.svg" width="100%" />

## Cooperation Request

If you have a map of Iran or demographic data, please let us know so we
can add it to the package.

## Attribution

The following packages have been used in creating IRMaps. Many thanks to
their creators.

-   Simon Garnier’s [viridis](https://github.com/sjmgarnier/viridis)
-   riatelab’s [maptiles](https://github.com/riatelab/maptiles)
-   Jeffrey W Hollister’s [elevatr](https://github.com/jhollist/elevatr)
-   rOpenSci’s [osmdata](https://github.com/ropensci/osmdata)
