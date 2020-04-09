#Week 2 part 2
# Write a function that reads a directory full of files and reports the 
# number of completely observed cases in each data file. The function 
# should return a data frame where the first column is the name of the file 
# and the second column is the number of complete cases.

#example
#complete("specdata", c(2, 4, 8, 10, 12))
##   id nobs
## 1  2 1041
## 2  4  474
## 3  8  192
## 4 10  148
## 5 12   96

complete <- function(directory, id = 1:332){
      
      df_ret <- data.frame('id' = NULL, 'nobs' = NULL)
      count <- 1
      
      for (i in id) {
            
            current_file <- (sprintf("%s/%03d.csv",directory,i))
            df <- read.csv(current_file)
    #Equivalent lines
    #df[complete.cases(df[1:731,]),]
    df_clean <-na.omit(df[,])
    
    nrow <- dim(df_clean)[1]
    #build data frame
    df_ret[count, 'id'] <- i
    df_ret[count, 'nobs'] <- nrow
    
    count <- count + 1
  } 
  return(df_ret)
}





