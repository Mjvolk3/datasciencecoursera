#4 Ranking hospitals in all states


rankall <- function(outcome, num = "best") {


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
      
      #df with hospitals and order best rates
      head_col <- "Hospital.30.Day.Death..Mortality..Rates.from."
      outcome_col <- data[paste(head_col,tail_col,sep = '')]
      red_df <- cbind(data$Hospital.Name, data$State ,outcome_col)
      outcome_col_num <- as.numeric(outcome_col[,1])
      #can have NA's
      #red_df_clean <- red_df[!is.na(outcome_col_num),]
      red_df[,3] <- as.numeric(red_df[,3])
      colnames(red_df) <- c("hospital", "state", "rate")
      
      #reordered state list
      state_ls <- split(red_df, red_df$state)
      for (i in 1:length(state_ls)){
            current_st <- state_ls[i]
            state_name <- names(current_st)
            current_st[[state_name]] <- current_st[[state_name]][order(current_st[[state_name]]$rate, current_st[[state_name]]$hospital),]
            state_ls[i] <- current_st
      }
      
      st_un_ls <- unique(red_df$state)
      st_un_ls[order(st_un_ls)]
      ranked_df <- data.frame()

      #handling num input
      num_fm <- numeric()
      if (num == "best"){
            num_fm <- 1
      } else if (num != "best" && num != "worst"){
            num_fm <- num
      }
      
      for (i in 1:length(st_un_ls)){
            if (num == "worst"){
                  #num_fm <- nrow(state_ls[[st_un_ls[i]]])
                  na_rm <- state_ls[[st_un_ls[i]]][!is.na(state_ls[[st_un_ls[i]]][,3]),]
                  num_fm <- nrow(na_rm)
            } 
          
            ranked_df <- rbind(ranked_df, state_ls[[st_un_ls[i]]][num_fm,])

      }
      
      ranked_df[,2] <- st_un_ls
      ranked_df <- ranked_df[order(ranked_df$state),]
      #drop rate
      drop <- c("rate")
      ranked_df <- ranked_df[!(names(ranked_df) %in% drop)]

}
