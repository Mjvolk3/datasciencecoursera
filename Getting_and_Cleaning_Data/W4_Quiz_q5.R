#Week 4 Quiz q5

#install.packages("quantmod")
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

year_log <- year(index(amzn)) == 2012
amzn[year_log]
monday_log <- wday(sampleTimes, label = TRUE) == "Mon"
print(sum(year_log))
print(nrow(amzn[year_log & monday_log]))

