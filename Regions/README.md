# NUTS 3 regions chloropleth map plot script

This script uses geojson data constructed from the coordinates of Europe's and Nordic countries' NUTS 3 regions (counties). It is possible to plot a given indicator or just the borders of the regions with a one line of code.

Below is an example of Nordic countries' population density (source: countries' statistical bureaus' data portals, 2018) plotted on NUTS 3 level.

![NUTS3_density_Nordics](https://user-images.githubusercontent.com/69734538/103465710-17aa8500-4d47-11eb-9c46-124009526874.jpeg)

I've also manually constructed (partially incomplete) data set of European countries' NUTS 3 regions' homicide statistics. The data is misleading as it depicts just absolute number of murders in a give region and I haven't normalized it against population. The development of the data set is ongoing and requires a lot of digging in many foreign languages. It is demonstrated here for illustrative purposes only.

![Murders_NUTS3_Europe](https://user-images.githubusercontent.com/69734538/103465796-addeab00-4d47-11eb-9fed-38600455191b.jpeg)

Data plotted on this granularity is often used in econometric studies that provides a rationale for developing this script.
