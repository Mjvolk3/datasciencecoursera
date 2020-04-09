#3 Ranking hospitals by outcome in a state

# state <- "TX"
# outcome <- "heart failure"
# num = "best"

rankhospital <- function(state, outcome, num = "best"){
      
      #correct naming scheme for possible outcome to correspond with column headings, and check invalid
      if (outcome == "heart attack"){
            tail_col <- "Heart.Attack"
      } else if (outcome == "heart failure"){
            tail_col <- "Heart.Failure"
      } else if (outcome == "pneumonia"){
            tail_col <- "Pneumonia"
      } else {
            stop("invalid outcome")
      }
      
      data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
      
      #filter by state and check for invalid
      states_vec <- unique(data$State)
      if (state %in% states_vec == FALSE){
            stop("invalid state")
      }
      data_st_sub <- (subset(data, data$State == state))
      
      #df with hospitals and order best rates
      head_col <- "Hospital.30.Day.Death..Mortality..Rates.from."
      outcome_col <- data_st_sub[paste(head_col,tail_col,sep = '')]
      red_df <- cbind(data_st_sub$Hospital.Name, outcome_col)
      outcome_col_num <- as.numeric(outcome_col[,1])
      red_df_clean <- red_df[!is.na(outcome_col_num),]
      red_df_clean[,2] <- as.numeric(red_df_clean[,2])
      best_rt <- red_df_clean[order(red_df_clean[,2], red_df_clean[,1]),]
      #renaming to match Coursera names, and for simplicity
      colnames(best_rt) <- c("Hospital.Name", "Rate")
      Rank <- 1:nrow(best_rt)
      Ranked <- cbind(best_rt, Rank)
      
      if (is.numeric(num) == TRUE && num > nrow(best_rt)){
            return(NA)
      }
      
      if (num == "best"){
            hospital <- as.character(Ranked[1,1])
      } else if (num == "worst"){
            hospital <- as.character(tail(Ranked[,1],1))
      } else {
            hospital <- as.character(Ranked[num,1])
      }
      
      return(hospital)
      
}