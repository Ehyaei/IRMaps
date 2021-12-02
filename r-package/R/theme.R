#' Theme for Plotting Maps
#'
#' This theme remove axis lines, major and minor line to see the maps better.
#' @return ggplot2 theme
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irProvinces()
#' ggplot(map)+
#'   geom_sf(aes(fill = area), size = 0.1, color = "white") +
#'   theme_map()
theme_map = function(base_size = 12){
  theme_void(base_size = base_size)+
    theme(
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.title = element_text(size = rel(.7), vjust = 0.85, hjust = 0, face = "bold"),
      legend.margin = margin(0),
      legend.text = element_text(size = rel(.5)),
      legend.key.height = grid::unit(rel(0.3), "cm"),
      legend.key.width = grid::unit(rel(2), "cm"),
      axis.title = element_blank()
    )
}
#' Bottom Legend Theme
#'
#' This theme sete legend in bottom and set map design.
#' @return ggplot2 theme
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irProvinces()
#' ggplot(map)+
#'   geom_sf(aes(fill = area), size = 0.1, color = "white") +
#'   bottom_legend()
bottom_legend = function(){
  theme(
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.title = element_text(size = rel(.7), vjust = 1, hjust = 0, face = "bold"),
    legend.margin = margin(0),
    legend.text = element_text(size = rel(.5)),
    legend.key.height = grid::unit(rel(0.5), "cm"),
    legend.key.width = grid::unit(rel(2), "cm"),
    axis.title = element_blank()
  )
}


#' Remove axis margin for Full View
#'
#' Add this as a layer to a ggplot object,in
#' order to remove axis margins.
#' @return
#' @export
#'
#' @examples
#' library(ggplot2)
#' map <- irProvinces()
#' ggplot(map)+
#'   geom_sf(aes(fill = area), size = 0.1, color = "white") +
#'   fullView()
fullView <- function() {
  c(
    ggplot2::scale_x_continuous(expand = c(0, 0)),
    ggplot2::scale_y_continuous(expand = c(0, 0))
  )
}
