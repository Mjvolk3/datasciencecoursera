#2 Finding the best hospital in a state

best <- function(state, outcome){

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
      best_rt <- red_df_clean[order(red_df_clean[,2]),]
      
      #check for ties
      log_dup <- duplicated(best_rt[,2])
      hospital_list <- best_rt[1,]
      for (i in (1:nrow(best_rt))){
            if(log_dup[i+1] == TRUE){
                  hospital_list <- rbind(hospital_list, best_rt[i+1,])
            } else{
                  break
            }
      }
      #alphabetical ordering
      hospital_list_alpha <- hospital_list[order(hospital_list[,1]),]
      
      top_hospital <- as.character(hospital_list_alpha[1,1])
      return(top_hospital)
}