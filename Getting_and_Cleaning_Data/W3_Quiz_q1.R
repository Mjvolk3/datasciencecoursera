#Week 3 quiz q1

#only works if in setwd() is used to be in desired directory
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", paste(getwd(), "/W3_Quiz_q1_data.csv", sep = ''))

df <- read.csv("W3_Quiz_q1_data.csv")
a <- df %>% select(ACR, AGS)
agricultureLogical <- a$ACR == 3 & a$AGS == 6
which(agriculturalLogical)
