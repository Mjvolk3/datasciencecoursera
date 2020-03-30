# #Week 2 part 2
# #Write a function that takes a directory of data files and a 
# threshold for complete cases and calculates the correlation between 
# sulfate and nitrate for monitor locations where the number of 
# completely observed cases (on all variables) is greater than the 
# threshold. The function should return a vector of correlations for
# the monitors that meet the threshold requirement. If no monitors meet
# the threshold requirement, then the function should return a numeric 
# vector of length 0.

#example
# cr <- corr("specdata", 150)
# head(cr)
## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814
# summary(cr)
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.21057 -0.04999  0.09463  0.12525  0.26844  0.76313

# corr <- function(directory, threshold = 0){
#   
#   
# }
corr <- function(directory, threshold = 0){
  
  comp_cases <- complete(directory, id = 1:332)
  thresh_cases <- subset(comp_cases, nobs>threshold)
  cor_mon <- vector()
  
  if (dim(thresh_cases)[1] == 0){
    cor_mon = 0
  } else {
    for(i in 1:nrow(thresh_cases)) {
      current_id <- thresh_cases['id'][i,1]
      current_file <- (sprintf("%s/%03d.csv",directory,current_id))
      df <- read.csv(current_file)
      df_clean <-na.omit(df[,])
      cor_mon <- c(cor_mon, cor(df_clean["sulfate"], df_clean["nitrate"]))
    } 
  }

  return(cor_mon)
}
