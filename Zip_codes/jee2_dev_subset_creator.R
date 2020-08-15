jee2_dev_subset_creator <- function(spdf_subset, jee_subset){
  jou_2 <- matrix(ncol = 2)
  pituus_2 <- NA
  koordinaatit_2 <- list()
  jee_names <- c("long", "lat", "order", "hole", "piece", "id", "group") 

  for(i in 1:length(spdf2_subset$geometry)){
    temp_list <- unlist(spdf2_subset$geometry[i])
    koordinaatit_2[[i]] <- temp_list
    temp_matrix <- matrix(nrow = length(temp_list)/2, ncol = 2)
    temp_matrix[,1] <- temp_list[temp_list<50]
    temp_matrix[,2] <- temp_list[temp_list>50]
    pituus_2[i] <- length(temp_matrix[,1])
    jou_2 <- rbind(jou_2, temp_matrix)
  }
  jou_2 <- jou_2[2:length(jou_2[,1]),]

  jee2_dev_subset <- data.frame(matrix(c(rep(NA,length(jou_2[,1]))), ncol = 7, nrow = length(jou_2[,1])))
  names(jee2_dev_subset) <- jee_names

  jee2_dev_subset$long <- jou_2[,1]
  jee2_dev_subset$lat <- jou_2[,2]
  jee2_dev_subset$hole <- rep(TRUE, length(jou_2[,1]))
  jee2_dev_subset$piece <- rep(1, length(jou_2[,1]))

  # Sarakkeet jee2_dev_subset$id & jee2_dev_subset$order
  a <- 1
  b <- 1
  for(i in pituus_2){
    jee2_dev_subset$id[a:(a+i-1)] <- b + as.numeric(jee_subset$id[length(jee_subset$id)])
    jee2_dev_subset$order[a:(a+i-1)] <- (1:i)
    a <- a + i
    b <- b + 1
  }
  
  # Sarake jee2_dev_subset$group
  faktorit_2 <- list()
  for(i in 1:length(koordinaatit_2)){
    desimaali <- 1
    for(j in 1:length(koordinaatit_2[[i]])){
      if(j == length(koordinaatit_2[[i]])){
        if(is_empty(faktorit_2) == T){
          pit <- 0
          faktorit_2[[i]] <- c(rep(paste0(unique(jee2_dev_subset$id)[i], ".", desimaali), (j-pit*2)/2))#(length(koordinaatit[[i]])-length(faktorit)))))
        }
        else{
          pit <- length(faktorit_2[[i]])
          faktorit_2[[i]] <- append(faktorit_2[[i]], c(rep(paste0(unique(jee2_dev_subset$id)[i], ".", desimaali), (j-pit*2)/2)))#(length(koordinaatit[[i]])-length(faktorit)))))
        }    
      }
      else if(koordinaatit_2[[i]][j]-koordinaatit_2[[i]][j+1] > 30){
        if(is_empty(faktorit_2) == T | length(faktorit_2)<i){
          pit <- 0
          faktorit_2[[i]] <- c(rep(paste0(unique(jee2_dev_subset$id)[i], ".", desimaali), (j-pit*2)/2))
          desimaali <- desimaali + 1
        }
        else{
          pit <- length(faktorit_2[[i]])
          faktorit_2[[i]] <- append(faktorit_2[[i]], c(rep(paste0(unique(jee2_dev_subset$id)[i], ".", desimaali), (j-pit*2)/2)))
          desimaali <- desimaali + 1
        }
      }
      else{
      }
    }
  }
  jee2_dev_subset$group <- as.factor(unlist(faktorit_2))#[1:length(jee2_dev_subset[,1])])
return(jee2_dev_subset)
}
