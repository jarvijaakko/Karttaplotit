#########################
## Finnish municipalities
## Made by: Jaakko Järvinen
## Date: 19.03.2020

rm(list=(ls()))
dev.off()
cat("\014")
#setwd('/home/vesis/Documents/Karttaplotit/Municipalities')

# Libraries
library(ggplot2)
library(rgeos)
library(rgdal)
library(maptools)
library(gpclib)

# Reading the data containing all municipalities (311 municipalities in Finland)
spdf <- readOGR("data/Kuntarajat_2017.geojson")

# Saving the municipality names from the GeoJSON dataset
Muni_names <- as.character(spdf@data$Name)

# Forming a data frame containing only the essential information about the regions
jee <- fortify(spdf, region = "Name")
jee$id <- factor(jee$id)

####################################################
# Inputting indicator values for each municipality #
indicator_df <- read.csv2("data/Municipality_data.csv", header = T, stringsAsFactors = F)
names(indicator_df) = c('id', 'Indicator')    
plot.data <- merge(jee, indicator_df, by = 'id')
plot.data$Indicator = as.factor(plot.data$Indicator)
####################################################

# Plot municipalities (with mock indicator)
muni_plot <- ggplot(data = plot.data, aes(x = long, y = lat, fill = Indicator, col = Indicator, group = group)) + 
  geom_polygon(color = 'grey', size = 0.1, alpha = 0.9) + 
  theme_void() + 
  coord_map() +
  # scale_color_manual(values = c("red", "grey", "blue")) + 
  # scale_fill_manual(values = c("red", "grey", "blue")) + 
  viridis::scale_fill_viridis(option = 'viridis', discrete = T, direction = -1) +
  # guides(fill=guide_legend(nrow=3, reverse = T)) + 
  theme(legend.position = "bottom", plot.title = element_text(hjust = 0.5)) +
  theme(legend.box.background = element_blank(),
        legend.spacing = unit(2, 'cm')
        )
muni_plot
