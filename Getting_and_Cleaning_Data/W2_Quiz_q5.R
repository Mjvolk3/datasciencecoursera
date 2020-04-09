#Week 2 Quiz q5
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
df <- read.fwf(file_url, skip = 4, widths = c(12, 7, 4, 9, 4, 9, 4, 9, 4))
print(sum(df$V4))
