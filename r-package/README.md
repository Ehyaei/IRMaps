
<!-- README.md is generated from README.Rmd. Please edit that file -->

# IRMaps

<!-- badges: start -->
<!-- badges: end -->

The goal of IRMaps is to prepare geographical maps and divisions of
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
ggplot(provinces)+
  geom_sf()+
  theme_map()+
  fullView()
```

<img src="man/figures/README-example-1.svg" width="100%" />

``` r
data_map <- merge(provinces, IRMaps::iran_population, by.x = "name_en", by.y = "Province") 
ggplot(data_map,aes(fill = RuralareasMale/RuralareasFemale))+
  geom_sf(color = "white",size = 0.1)+
  scale_fill_map(palette = "TealRode")+
  theme_map()+
  fullView()
```

<img src="man/figures/README-unnamed-chunk-2-1.svg" width="100%" />

``` r
raster_tile <- get_raster_tile(iran_border,provider = "Wikimedia",zoom = 6)

ggplot() +
  geom_raster(data = raster_tile, aes(x, y, fill = hex)) +
  geom_sf(data = iran_border,color = "blue",alpha = 0.1) +
  scale_fill_identity() +
  theme_map()+
  fullView()
```

<img src="man/figures/README-unnamed-chunk-3-1.svg" width="100%" />
