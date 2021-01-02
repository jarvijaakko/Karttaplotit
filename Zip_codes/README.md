# Zip code chloropleth plot script

This directory contains a script that can be used in plotting chloropleth maps on the zip code level. I have only included Finland in this version since there is really not much sense in observing larger areas on this granularity. In short, the maps are constructed using geojson data and a little data manipulation before plotting with ggplot2. Below is an example of a simple map of Finland's zip code areas highlighting only borders.

![Suomi_zips](https://user-images.githubusercontent.com/69734538/103465259-8f29e580-4d42-11eb-9a5b-798a5c8cc6c2.jpeg)

It is also possible to plot a chosen indicator, meaning any data on zip code level, using the chloropleth map script. Below is an example of the mean aggregated household income (Statistics Finland) plotted for the Uusimaa region subset. 

