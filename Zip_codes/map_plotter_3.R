map_plotter_3 <- function(plot.data){
  plot_final <<- ggplot(data = plot.data, aes(x = long, y = lat, group = group, fill = Indicator)) +
    geom_polygon(color = 'black', size = 0.1, alpha = 0.9) +
    theme_void() +
    coord_map() +
    # scale_color_manual(values = c("red", "blue")) +
    # scale_fill_manual(values = c("red", "blue")) +
    viridis::scale_fill_viridis(option = 'viridis', discrete = F, direction = -1) +
    # ggtitle("Asukkaiden mediaanitulot 2017 postinumeroalueittain, Helsinki") +
    guides(fill=guide_legend(nrow=1, reverse = F)) +
    theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5))
  # theme(legend.key = element_blank(),
      # legend.box.background = element_blank(),
      # legend.spacing = unit(2, 'cm'),
      # legend.text = element_blank())
}
