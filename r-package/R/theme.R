#' Theme for Plot Heatmaps
#'
#' @return ggplot2 theme
#' @export
#'
#' @examples
#' library(ggplot2)
#' # Dummy data
#' x <- LETTERS[1:20]
#' y <- paste0("var", seq(1,20))
#' data <- expand.grid(X=x, Y=y)
#' data$Z <- runif(400, 0, 5)
#' # Heatmap
#' ggplot(data, aes(X, Y, fill= Z)) +
#'   geom_tile()+
#'   theme_map()

theme_map = function(base_size = 12){
  theme_void(base_size = base_size)+
    theme(
      legend.position = "bottom",
      legend.direction = "horizontal",
      legend.title = element_text(size = rel(1), vjust = 1, hjust = 0, face = "bold"),
      legend.margin = margin(0),
      legend.text = element_text(size = rel(.7)),
      legend.key.height = grid::unit(rel(0.5), "cm"),
      legend.key.width = grid::unit(rel(2), "cm"),
      axis.title = element_blank()
    )
}
#' Bottom Legend Theme
#'
#' @return ggplot2 theme
#' @export
#'
#' @examples
#' library(ggplot2)
#' # Dummy data
#' x <- LETTERS[1:20]
#' y <- paste0("var", seq(1,20))
#' data <- expand.grid(X=x, Y=y)
#' data$Z <- runif(400, 0, 5)
#' # Heatmap
#' ggplot(data, aes(X, Y, fill= Z)) +
#'   geom_tile()+
#'   theme_map()
bottom_legend = function(){
  theme(
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.title = element_text(size = rel(1), vjust = 1, hjust = 0, face = "bold"),
    legend.margin = margin(0),
    legend.text = element_text(size = rel(.7)),
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
fullView <- function() {
  c(
    ggplot2::scale_x_continuous(expand = c(0, 0)),
    ggplot2::scale_y_continuous(expand = c(0, 0))
  )
}
