#Week 4 Quiz q1
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./W4_Quiz_q1_data.csv", methods = "curl")
housing <- read.csv("W4_Quiz_q1_data.csv")
sp_list <- strsplit(names(housing), "wgtp")

