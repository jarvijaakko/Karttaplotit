## Nordic NUTS 3 regions
## Jaakko Järvinen
## 16.8.2020

rm(list=ls()) & dev.off() & cat("\014")
library(stringr)
library(geojsonio)
library(ggplot2)
library(sjmisc)

# Reading the whole Europe in NUTS 3 regions
spdf <- geojson_read("data/nuts_rg_60m_2013_lvl_3.geojson", what = "sp")

## Finding the indices for the Nordic countries from the GeoJSON dataset
Nordics <- spdf@data$NUTS_ID[]
Nordics = as.character(Nordics)

# Type here countries you want to include in the map
source("country_chooser.R")
country_list <- c('FI', 'SE', 'NO', 'DK')
sel_ind <- country_chooser(country_list)
spdf_Nordics <- spdf[sel_ind,]

jee <-fortify(spdf_Nordics, region = "NUTS_ID")
jee$id <- factor(jee$id)

################################################
# Inputting indicator values for each province #
indicator_df <- read.csv2("data/Maakunnat_data_tiheys.csv", header = T, stringsAsFactors = F, sep = ',')
names(indicator_df) = c('id', 'Indicator', 'Name')
plot.data <- merge(jee, indicator_df, by = 'id')
################################################

# Plot
# Valitse argumentiksi joko 'data' tai 'rajat' sen mukaan minkälaisen kartan haluat
source("plot_function.R")
plot_function('data')
