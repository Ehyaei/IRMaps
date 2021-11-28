#' Access palette colors
#'
#' @param palette
#'
#' @return
#' @export
#'
map_raw_palettes <- function(palette){

  palettes <-  list(
  BYR =        c("#000072","#0D528D","#277973","#419973","#8BB895","#D7E37D","#FFFF33", "#FFB200","#FF6B01","#FF3D00","#FF3D00","#6E090D","#000000"),
  Teal =       c("#d1eeea","#a8dbd9","#85c4c9","#68abb8","#4f90a6","#3b738f","#2a5674"),
  Sunset =     c("#f3e79b","#fac484","#f8a07e","#eb7f86","#ce6693","#a059a0","#5c53a5"),
  Emrld =      c("#d3f2a3", "#97e196", "#6cc08b", "#4c9b82", "#217a79", "#105965", "#074050"),
  Fall =       c("#3d5941","#778868","#b5b991","#f6edbd","#edbb8a","#de8a5a","#ca562c"),
  Earth =      c("#A16928", "#bd925a", "#d6bd8d", "#edeac2", "#b5c8b8", "#79a7ac", "#2887a1"),
  TealRode =   c("#009392","#72aaa1","#b1c7b3","#f1eac8","#e5b9ad","#d98994","#d0587e"),
  Prism =      c("#5F4690", "#1D6996", "#38A6A5", "#0F8554", "#73AF48", "#EDAD08", "#E17C05", "#CC503E", "#94346E","#6F4070", "#994E95", "#666666")
)
  # usethis::use_data(palettes,overwrite = TRUE)
 palette <- match.arg(palette, names(palettes))
 palettes[[palette]]
}

#' Title
#'
#' @param n the number of generated colours for the palette.
#' @param alpha the opacity of the generated colours.
#' @param begin,end The interval within the palette to sample colours from.
#' Defaults to `0` and `1` respectively
#' @param direction Either `1` or `-1`. If `-1` the palette will be reversed
#' @param palette The name of the palette to sample from. See
#' [map_palette_names()] for a list of possible names.
#'
#' @references
#' [scico](https://github.com/thomasp85/scico)
#' @importFrom grDevices rgb colorRamp
#' @return
#' @export
#'
#' @examples
#' map_palettes(15, begin = 0.3, end = 0.6, palette = 'Earth')
map_palettes <- function(n, alpha = NULL, begin = 0, end = 1, direction = 1, palette = "BYR") {
  if (begin < 0 | begin > 1 | end < 0 | end > 1) {
    stop("begin and end must be in [0,1]")
  }

  if (abs(direction) != 1) {
    stop("direction must be 1 or -1")
  }

  if (direction == -1) {
    tmp <- begin
    begin <- end
    end <- tmp
  }

  map_cols <- map_raw_palettes(palette)
  fn_cols <- colorRamp(map_cols, space = "Lab", interpolate = "spline")
  cols <- fn_cols(seq(begin, end, length.out = n))
  if (is.null(alpha)) {
    rgb(cols[, 1], cols[, 2], cols[, 3], maxColorValue = 255)
  } else {
    rgb(cols[, 1], cols[, 2], cols[, 3], alpha = alpha * 255, maxColorValue = 255)
  }
}


#' Access  palette names
#'
#' These functions gives access to the data underlying the palettes
#'
#' @keywords internal
#' @export
#'
map_palette_names <- function() return(names(IRMaps::palettes))

#' Show the different map palettes
#'
#' This is a simple function to show a gradient of the different palettes
#' available in the `map` package
#'
#' @param palettes One or more palette names to show
#'
#' @references
#' \href{https://github.com/thomasp85/scico}{scico}
#' @importFrom grDevices n2mfrow
#' @importFrom graphics image par
#' @export
#'
#' @examples
#' map_palettes_show()
map_palettes_show <- function(palettes = map_palette_names()) {
  dims <- n2mfrow(length(palettes))
  oldpar <- par(mfrow = dims, mai = par('mai')/5)
  on.exit(par(oldpar))

  for (i in palettes) {
    image(matrix(1:100, ncol = 1), col = map_palettes(100, palette = i), main = i, axes = FALSE)
  }
}
