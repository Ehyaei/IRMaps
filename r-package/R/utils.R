map_ploter <- function(map){
  ggplot(data = map)+
    geom_sf()+
    theme_void()
}
