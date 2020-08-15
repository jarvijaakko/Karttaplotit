subset_valitsin <- function(kaupunki, alue){
  if(is_empty(kaupunki) == F){
    koko <<- 0
    kuntanro_spdf <- as.numeric(unique(Municipalities[Municipalities$Municipality_name == kaupunki, 4]))
    kuntanro_spdf2 <- as.numeric(unique(Municipalities[Municipalities$Municipality_name == kaupunki, 4]))
      spdf_subset <<- spdf[spdf@data$kuntanro == kuntanro_spdf,]
      spdf2_subset <<- spdf2[spdf2$kuntanro == kuntanro_spdf2,]
        Zip_subset <- append(as.character(spdf_subset$posti_alue), as.character(spdf2_subset$posti_alue))
        Zips <<- Zips[Zips %in% Zip_subset]
  }
  else if(is_empty(alue) == F){
    koko <<- 0
    kuntanro_spdf <- as.numeric(unique(Municipalities[Municipalities$NUTS3_name == alue, 4]))
    kuntanro_spdf2 <- as.numeric(unique(Municipalities[Municipalities$NUTS3_name == alue, 4]))
      spdf_subset <<- spdf[spdf@data$kuntanro %in% kuntanro_spdf,]
      spdf2_subset <<- spdf2[spdf2$kuntanro %in% kuntanro_spdf2,]
        Zip_subset <- append(as.character(spdf_subset$posti_alue), as.character(spdf2_subset$posti_alue))
        Zips <<- Zips[Zips %in% Zip_subset]
  }
  else{
    koko <<- 1
    print("Koko Suomi")
  }
}