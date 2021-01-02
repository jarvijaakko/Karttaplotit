#########################
## Countries of the world
## Made by: Jaakko Järvinen
## Date: 19.03.2020

rm(list=(ls()))
dev.off()
cat("\014")

# Libraries
library(sp)
library(stringr)
library(geojsonio)
library(ggplot2)

# Reading the data and plotting the whole world
spdf <- geojson_read("data/custom.geo.json", what = "sp")

## Finding the indices for the country/area names from the GeoJSON dataset
Country_names <- spdf@data$name
Country_names = as.character(Country_names)

Area_names <- spdf@data$continent
Area_names = as.character(Area_names)

# Preliminary plot of the world map
# plot(spdf)

# Here you can search the indices for a given country name 
# Country_ind = which(str_detect(Area_names, "Africa") == T)        ## Changed from str_pos to str_detect on 29.1.2020
# spdf_ind <- spdf[Country_ind,]
# plot(spdf_ind)
# Region_names <- Country_names[Country_ind]

jee <-ggplot2::fortify(spdf, region = "admin")
jee$fsa <- factor(jee$id)
jee$id <- NULL

## Indicator (discrete)
indicator_df <- data.frame(rep("", length(spdf$admin)))
indicator_df[,2] = spdf$admin

spdf_vector <- rep(NA, 245)
spdf_vector[which(as.character(spdf$name) == "United States")] <- "USA"
spdf_vector[which(as.character(spdf$name) == "China")] <- "China"
spdf_vector[which(is.na(spdf_vector) == T)] <- "Other"
indicator_df[,1] = spdf_vector

names(indicator_df) = c('Indicator', 'fsa')

## SPDF
plot.data = merge(jee, indicator_df, by = 'fsa')
plot.data$Indicator = as.factor(plot.data$Indicator)

labels <- c("", "USA", "China")

country_plot <- ggplot(data = plot.data, aes(x = long, y = lat, fill = Indicator, col = Indicator, group = group)) +
  geom_polygon(color = 'white', size = 0.1, alpha = 0.9) +
  theme_void() +
  coord_map() +
  scale_color_manual(values = c("red", "grey", "green")) +
  scale_fill_manual(values = c("red", "grey", "green")) +
  #viridis::scale_fill_viridis(option = 'viridis', discrete = T) +
  guides(fill=guide_legend(nrow=3, reverse = T)) +
  theme(legend.position = "bottom", legend.title = element_blank(), plot.title = element_text(hjust = 0.5)) +
  theme(legend.key = element_rect(colour = NA, fill = NA),
        legend.box.background = element_blank(),
        legend.spacing = unit(2, 'cm'),
        legend.text = element_text(size = 18))
country_plot

## Indicator (continuous)
# indicator_df <- data.frame(rep("", length(spdf$admin)))
# indicator_df <- read.csv2("data/World_data.csv", header = T, stringsAsFactors = F)
# 
# names(indicator_df) = c('fsa', 'Indicator')

## SPDF
# plot.data = merge(jee, indicator_df, by = 'fsa')
# plot.data$Indicator = as.factor(plot.data$Indicator)
# 
# country_plot <- ggplot(data = plot.data, aes(x = long, y = lat, fill = Indicator, col = Indicator, group = group)) + 
#   geom_polygon(color = 'white', size = 0.1, alpha = 0.9) + 
#   theme_void() + 
#   coord_map() +
#   # scale_color_manual(values = c("red", "grey", "green")) + 
#   # scale_fill_manual(values = c("red", "grey", "green")) + 
#   viridis::scale_fill_viridis(option = 'viridis', discrete = T, direction = -1) +
#   guides(fill=guide_legend(nrow=3, reverse = T)) + 
#   theme(legend.position = "bottom", legend.title = element_blank(), plot.title = element_text(hjust = 0.5)) +
#   theme(legend.key = element_rect(colour = NA, fill = NA),
#         legend.box.background = element_blank(),
#         legend.spacing = unit(2, 'cm'),
#         legend.text = element_text(size = 18))
# country_plot