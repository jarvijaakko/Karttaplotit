map_plotter_2 <- function(jee_final_subset){
  plot_final <<- ggplot(data = jee_final_subset, aes(x = long, y = lat, group = group, fill = "red")) +
    geom_polygon(color = 'black', size = 0.1, alpha = 0.9) +
    theme_void() +
    coord_map() +
    guides(fill=guide_legend(nrow=3, reverse = T)) +
    theme(legend.position = "none", legend.title = element_blank(), plot.title = element_text(hjust = 0.5)) +
    theme(legend.key = element_blank(),
          legend.box.background = element_blank(),
          legend.spacing = unit(2, 'cm'),
          legend.text = element_blank())
}
