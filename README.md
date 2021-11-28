
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

The reference of the maps of the country divisions is [National
Cartographic Center](https://www.ncc.gov.ir/en/) and its last update is
2018. The following maps in the form of sf object, are included in the
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
provinces <- irProvinces()
ggplot(provinces)+
  geom_sf()+
  theme_map()+
  fullView()
```

<img src="man/figures/README-example-1.svg" width="100%" />

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
merge(provinces, IRMaps::iran_population, by.x = "name_en", by.y = "Province") %>% 
  ggplot()+
  geom_sf(aes(fill = TotalMale/TotalFemale),color = "white")+
  scale_fill_map(palette = "Earth",direction = -1)+
  theme_map()+
  fullView()
```

<img src="man/figures/README-unnamed-chunk-2-1.svg" width="100%" />
