#########################
## Finnish zip codes
## Made by: Jaakko Järvinen
## Date: 19.03.2020

rm(list=(ls()))
dev.off()
cat("\014")

############Valintaruutu################
kaupunki <- "Helsinki"
alue <- ""
indikaattori <- "Income.csv"

## Valitse maakunta (alue) näistä:
# "Uusimaa"           "Kanta-Häme"        "Pirkanmaa"         "Päijät-Häme"       "Keski-Suomi"       "Kymenlaakso"       "Etelä-Savo"       
# "Varsinais-Suomi"   "Ahvenanmaa"        "Satakunta"         "Etelä-Karjala"     "Pohjois-Karjala"   "Etelä-Pohjanmaa"   "Pohjanmaa"        
# "Keski-Pohjanmaa"   "Pohjois-Pohjanmaa" "Pohjois-Savo"      "Kainuu"            "Lappi"
########################################

# Zip_codes(kaupunki = "Helsinki", alue = "", indikaattori = "Income.csv")

# Zip_codes <- function(kaupunki, alue, indikaattori){
# Needed libraries (make sure you have these installed!)
library(sjmisc)
library(ggplot2)
library(viridis)
library(rgdal)
library(gridExtra)
library(ggpubr)
library(sf)
library(mapproj)

## This script consists of 5 parts:
# 1.) Manipulate data
# 2.) Select subset
# 3.) Create subset
# 4.) Assign data across the zip code regions
# 5.) Plot the final maps


## 1.) Data manipulation ##
# Reading a possible indicator into a data frame
if(indikaattori == ""){
  indikaattori <- indikaattori
}
if(indikaattori != ""){
  indikaattori <- read.csv2(paste0('data/', indikaattori), header = T, stringsAsFactors = F)
}
## Lue indikaattori muodossa: Rivit: 3026 riviä (yksi joka postinumeroalueelle), Sarakkeet: [Zip, Income] 

## Downloading a pre-defined list of municipality names from an external csv file
Municipalities <- read.csv2("data/Kunnat_Suomi.csv", header = T, stringsAsFactors = F)

## Reading the data for all zip code areas that consist of only one geographical region
# Reading the regions of geometry type polygon
spdf <- readOGR(dsn = "data/Postinumeroalueet_2016.geojson", require_geomType = "wkbPolygon")

## Reading the data for all zip code areas that consist of more than one geographical region (e.g. islands, consolidations of municipalities..)
spdf2 <- sf::st_read("data/Postinumeroalueet_2016.geojson")

# Checking the indices that have GEOMETRYCOLLECTION as geometry type
# This means a list of polygons that can't be plotted as is (one polygon) but as separate polygons
index <- NA
for(i in 1:length(spdf2$geometry)){
  if(class(spdf2$geometry[i])[1] == "sfc_GEOMETRYCOLLECTION"){
    index[i] <- i
  }
  else{
    
  }
}
index <- na.omit(index)

# Changing the spdf2 to contain only the regions having GEOMETRYCOLLECTION as geometry type
spdf2 <- spdf2[index,]

## Now we have two subsets of the data for all zip code areas:
# 1.) spdf: Zip code areas consisting of single regions
# 2.) spdf2: Zip code areas consisting of multiple regions

# Postinumerot samassa järjestyksessä kuin spdf ja spdf2 -seteissä
Zip_codes <- as.character(spdf@data$posti_alue)
Zip_codes2 <- as.character(spdf2$posti_alue)
Zips <- append(Zip_codes, Zip_codes2)


## 2.) Choosing the appropriate subset to be used in plotting ##
# Choosing the appropriate subsets
source("Valitsin.R")
subset_valitsin(kaupunki, alue)


## 3.) Forming data frames containing only the essential information about the regions ##
## Forming first the data frames containing only the essential information (Zip set 1 (spdf) - single regions)
jee <<- ggplot2::fortify(spdf, name = "name")
if(koko != 1){
  jee_subset <- ggplot2::fortify(spdf_subset, name = "name")
}

## Forming then data frames containing only the essential information (Zip set 2 (spdf2) - multiple regions)
# First, the jee2_dev
source("jee2_dev_creator.R")
# Here, jee_final is the final dataset used in plotting for the whole Finland 
if(kaupunki == "" & alue == ""){
  jee2_dev <- jee2_dev_creator(spdf2, jee)
  jee_final <- rbind(jee, jee2_dev)
}

# Second, the jee2_dev_subset
source("jee2_dev_subset_creator.R")
# Here, jee_final_subset is the final dataset used in plotting for the chosen subset
if(kaupunki != "" | alue != ""){
  if(is_empty(spdf2_subset) == T){
    jee_final_subset <- jee_subset
  }
  if(exists("spdf2_subset") == T){
    if(is_empty(spdf2_subset) == F){
      jee2_dev_subset <- jee2_dev_subset_creator(spdf2_subset, jee_subset)
      jee_final_subset <- rbind(jee_subset, jee2_dev_subset)
    }
  }
}
## Now we have one of these datasets depending what we have chosen in the beginning:
# 1.) jee_final: Whole Finland's zip code areas
# 2.) jee_final_subset: Zip code areas of some selected area or city

## 4.) Additionally, we can read in some data and plot it across the zip code areas. After all, this is why we have done the whole excercise.
source("assigning_indicator.R")

if(is_empty(indikaattori) == F){
  plot.data <- assigning_indicator(indikaattori = indikaattori)
}

## 5.) Here, we plot the final zip code map ##
source("map_plotter.R")
source("map_plotter_2.R")
source("map_plotter_3.R")

if(exists("jee_final") == T & exists("jee_final_subset") == F & exists("plot.data") == F){
  map_plotter(jee_final)
}
if(exists("jee_final") == F & exists("jee_final_subset") == T & exists("plot.data") == F){
  map_plotter_2(jee_final_subset)
}
if(exists("plot.data") == T){
  map_plotter_3(plot.data)
}
# The final plot is saved as plot_final to make it easier to include multiple plots in the same figure
# This can be done e.g. by using grid.arrange() or ggarrange()
plot_final
# }