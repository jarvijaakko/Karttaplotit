plot_function <- function(selection){
  if(selection == 'data'){
    # Plotti, jossa maakunnat v?ritetty valitulla indikaattorilla
      plot.data$Indicator = as.numeric(plot.data$Indicator)
    Indicator_plot <- ggplot(data = plot.data, aes(x = long, y = lat, group = group, fill = Indicator)) + 
      geom_polygon(color = 'black', size = 0.1, alpha = 0.5) + 
      theme_void() + 
      coord_map() + 
      scale_fill_continuous(low = 'green', high = 'red', na.value = NA)
      # viridis::scale_fill_viridis(option = 'viridis', discrete = F, direction = -1) +
      # ggtitle('Suomen maakunnat') + 
      theme(legend.position = "bottom", legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.key.width = unit(2,'cm'))
    Indicator_plot
  }
  else{
    # Plotti, jossa pelk?t maakuntien rajat
    NUTS_plot <- ggplot(data = plot.data, aes(x = long, y = lat, group = group)) + 
      geom_polygon(color = 'white', size = 0.3, alpha = 0.5) + 
      theme_void() + 
      coord_map() + 
      viridis::scale_fill_viridis(option = 'viridis', discrete = F) +
      # ggtitle('NUTS 3 regions of the Nordic Countries') + 
      theme(legend.position = "bottom", legend.title = element_blank(), plot.title = element_text(hjust = 0.5), legend.key.width = unit(2,'cm'))
    NUTS_plot
  }
}