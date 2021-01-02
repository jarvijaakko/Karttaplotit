country_chooser_eur <- function(country_list){
  indices <- NA
    for(i in country_list){
      sel_ind <- which(!is.na(str_match(Europe, i)))
      indices <- append(indices, sel_ind)
    } 
indices = indices[2:length(indices)]
return(indices)
}