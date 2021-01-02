# Zip code chloropleth map plot script

This directory contains a script that can be used in plotting chloropleth maps on the zip code level. I have only included Finland in this version since there is really not much sense in observing larger areas on this granularity. In short, the maps are constructed using geojson data and a little data manipulation before plotting with ggplot2. Below is an example of a simple map of Finland's zip code areas highlighting only borders.

![Suomi_zips](https://user-images.githubusercontent.com/69734538/103465259-8f29e580-4d42-11eb-9a5b-798a5c8cc6c2.jpeg)

It is also possible to plot a chosen indicator, meaning any data on zip code level, using the chloropleth map script. Below is an example of the mean aggregated household income (source: Statistics Finland, 2018) plotted for the Uusimaa region subset. It is possible to choose any of the finnish NUTS 3 regions by just changing one line of code.

![Uusimaa_income](https://user-images.githubusercontent.com/69734538/103465439-1af04180-4d44-11eb-984c-d2014d979fed.jpeg)

In addition to choosing a region, it is also possible to choose a particular city or municipality with same simple modification as with the NUTS 3 region. Below is an example of the household income indicator for the Finnish capital Helsinki.

![Helsinki_income](https://user-images.githubusercontent.com/69734538/103465474-70c4e980-4d44-11eb-96b0-cfec67037932.jpeg)

I will continue on developing the template to make it even easier to use. So far, I've done some pretty grinding data manipulation in the functions. After all, the script seems to work well. 
