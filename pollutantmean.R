#Week 2 part 1
# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified 
#list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector 
#monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' 
#argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA

#example
#source("pollutantmean.R")
#pollutantmean("specdata", "sulfate", 1:10)
## [1] 4.064128

pollutantmean <- function(directory, pollutant, id = 1:332) {
  count <- 1
  for (i in id) {
    
    current_file <- (sprintf("%s/%03d.csv",directory,i))
    df <- read.csv(current_file)
    clean_col <- (df[pollutant][(!is.na(df[pollutant]))])
    
    if (count == 1) {
      comb_vec <- clean_col   
    }
    else {
      comb_vec <- c(comb_vec, clean_col)
    }
    count <- count + 1
  }
  
  pol_mean <- mean(comb_vec)
  return(pol_mean)
}






