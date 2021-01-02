assigning_indicator <- function(indikaattori){
# Changing first the format of zip codes to contain five numbers

indikaattori[nchar(indikaattori[,1]) == 3,1] <- paste0("00", indikaattori[nchar(indikaattori[,1]) == 3,1])
indikaattori[nchar(indikaattori[,1]) == 4,1] <- paste0("0", indikaattori[nchar(indikaattori[,1]) == 4,1])
indikaattori[indikaattori$Income == 0,2] <- NA

if(koko != 1){
plot.data <- jee_final_subset
plot.data$zip <- rep(NA, length(jee_final_subset[,1]))
plot.data$Indicator <- rep(NA, length(jee_final_subset[,1]))
j <- 1

for(i in unique(plot.data$id)){
  index_temp <- which(plot.data$id == i)
  plot.data$zip[index_temp] <- Zips[j]
  j = j + 1
}
for(i in unique(plot.data$zip)){
  index_temp <- which(plot.data$zip == i)
  if(is_empty(indikaattori[indikaattori$Zip == i,2]) == F){
    plot.data$Indicator[index_temp] <- indikaattori[indikaattori$Zip == i,2]
  }
  else{
    plot.data$Indicator[index_temp] <- NA
  }
}
return(plot.data)
}

if(koko == 1){
  plot.data <<- jee_final
  plot.data$zip <<- rep(NA, length(jee_final[,1]))
  plot.data$Indicator <<- rep(NA, length(jee_final[,1]))
  j <- 1
  
  for(i in unique(plot.data$id)){
    index_temp <- which(plot.data$id == i)
    plot.data$zip[index_temp] <<- Zips[j]
    j = j + 1
  }
  for(i in unique(plot.data$zip)){
    index_temp <- which(plot.data$zip == i)
    if(is_empty(indikaattori[indikaattori$Zip == i,2]) == F){
      plot.data$Indicator[index_temp] <<- indikaattori[indikaattori$Zip == i,2]
    }
    else{
      plot.data$Indicator[index_temp] <<- NA
    }
}
}
}
