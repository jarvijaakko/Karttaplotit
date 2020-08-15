jee2_dev_creator <- function(spdf2, jee){
  jou <- matrix(ncol = 2)
  pituus <- NA
  koordinaatit <- list()
  jee_names <- c("long", "lat", "order", "hole", "piece", "id", "group")
  # for(i in 1:length(spdf2$geometry)){
  #   temp_matrix <- matrix(unlist(spdf2$geometry[i]), ncol = 2)
  #   pituus[i] <- length(temp_matrix[,1])
  #     jou <- rbind(jou, temp_matrix)
  # }
  # jou <- jou[2:length(jou[,1]),]
  #
  # jee2_dev <- data.frame(matrix(c(rep(NA,length(jou[,1]))), ncol = 7, nrow = length(jou[,1])))
  # names(jee2_dev) <- names(jee)
  
  for(i in 1:length(spdf2$geometry)){
    temp_list <- unlist(spdf2$geometry[i])
    koordinaatit[[i]] <- temp_list
    temp_matrix <- matrix(nrow = length(temp_list)/2, ncol = 2)
    temp_matrix[,1] <- temp_list[temp_list<50]
    temp_matrix[,2] <- temp_list[temp_list>50]
    pituus[i] <- length(temp_matrix[,1])
    jou <- rbind(jou, temp_matrix)
  }
  jou <- jou[2:length(jou[,1]),]
  
  # for(i in 1:length(spdf2$geometry)){
  #   temp_list <- unlist(spdf2$geometry[i])
  #   temp_matrix <- matrix(nrow = length(temp_list)/2, ncol = 2)
  #   temp_matrix[,1] <- temp_list[temp_list<50]
  #   temp_matrix[,2] <- temp_list[temp_list>50]
  #   pituus[i] <- length(temp_matrix[,1])
  #   jou <- rbind(jou, temp_matrix)
  # }
  # jou <- jou[2:length(jou[,1]),]
  
  jee2_dev <- data.frame(matrix(c(rep(NA,length(jou[,1]))), ncol = 7, nrow = length(jou[,1])))
  names(jee2_dev) <- jee_names
  
  # jee2_dev <- data.frame(matrix(c(rep(NA,length(jou[,1]))), ncol = 7, nrow = length(jou[,1])))
  # names(jee2_dev) <- jee_names
  
  jee2_dev$long <- jou[,1]
  jee2_dev$lat <- jou[,2]
  jee2_dev$hole <- rep(TRUE, length(jou[,1]))
  jee2_dev$piece <- rep(1, length(jou[,1]))
  
  # Sarakkeeet jee2_dev$id & jee2_dev$order
  a <- 1
  b <- 1
  for(i in pituus){
      jee2_dev$id[a:(a+i-1)] <- b + as.numeric(jee$id[length(jee$id)])
      jee2_dev$order[a:(a+i-1)] <- (1:i)
      a <- a + i
      b <- b + 1
  }
  
  # Sarake jee2_dev$group
  faktorit <- list()
  for(i in 1:length(koordinaatit)){
    desimaali <- 1
    for(j in 1:length(koordinaatit[[i]])){
      if(j == length(koordinaatit[[i]])){
        if(is_empty(faktorit) == T){
          pit <- 0
          faktorit[[i]] <- c(rep(paste0(unique(jee2_dev$id)[i], ".", desimaali), (j-pit*2)/2))#(length(koordinaatit[[i]])-length(faktorit)))))
        }
        else{
          pit <- length(faktorit[[i]])
          faktorit[[i]] <- append(faktorit[[i]], c(rep(paste0(unique(jee2_dev$id)[i], ".", desimaali), (j-pit*2)/2)))#(length(koordinaatit[[i]])-length(faktorit)))))
        }
      }
      else if(koordinaatit[[i]][j]-koordinaatit[[i]][j+1] > 30){
        if(is_empty(faktorit) == T | length(faktorit)<i){
          pit <- 0
          faktorit[[i]] <- c(rep(paste0(unique(jee2_dev$id)[i], ".", desimaali), (j-pit*2)/2))
          desimaali <- desimaali + 1
        }
        else{
          pit <- length(faktorit[[i]])
          faktorit[[i]] <- append(faktorit[[i]], c(rep(paste0(unique(jee2_dev$id)[i], ".", desimaali), (j-pit*2)/2)))
          desimaali <- desimaali + 1
        }
      }
      else{
      }
    }
  }
  jee2_dev$group <- as.factor(unlist(faktorit))
return(jee2_dev)
}

