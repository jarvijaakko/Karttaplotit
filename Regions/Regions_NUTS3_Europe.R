## European NUTS 3 regions
## Jaakko Järvinen
## 16.8.2020
rm(list=ls()) & dev.off() & cat("\014")
library(stringr)
library(geojsonio)
library(ggplot2)
library(sjmisc)

# Whole Europe NUTS 3
spdf <- geojson_read("data/nuts_rg_60m_2013_lvl_3.geojson", what = "sp")
# plot(spdf, lwd = 1)
# summary(spdf)

## Finding the indices for European countries from the GeoJSON dataset
Europe <- spdf@data$NUTS_ID[]
Europe = as.character(Europe)

# Type here countries you want to include in the map (subset of Europe)
source("country_chooser_eur.R")
country_list <- c('UK')
sel_ind <- country_chooser_eur(country_list)
spdf_Europe <- spdf[sel_ind,]

# Execute the following line if you want to include all European countries
spdf_Europe <- spdf

jee <- fortify(spdf_Europe, region = "NUTS_ID")
jee$id <- factor(jee$id)
plot.data <- jee

###################################################
# Inputting indicator values for each province #
indicator_df <- read.csv2("data/NUTS3_v2.csv", header = T, stringsAsFactors = F, sep = ',')
indicator_df = indicator_df[,1:3]
names(indicator_df) = c('id', 'Indicator', 'Name')
plot.data <- merge(jee, indicator_df, by = 'id')
plot.data <- plot.data[order(plot.data$id, plot.data$order),]
####################################################

# Making some modifications considering the overseas territories
plot.data <- subset(plot.data, long > -30 & lat > 30)

# Plot
# Valitse argumentiksi joko 'data' tai 'rajat' sen mukaan minkälaisen kartan haluat
source("plot_function.R")
plot_function('data')
