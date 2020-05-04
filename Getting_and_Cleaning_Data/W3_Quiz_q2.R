#Week 3 quiz q1

#Note mode = 'wb' read in as binary
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", paste(getwd(), "/W3_Quiz_q2_data.jpg", sep = ''), mode = 'wb')

data <- readJPEG("W3_Quiz_q2_data.jpg", native = TRUE)
a <- sort(data)
a[length(data)*0.8]
a[length(data)*0.3]

quantile(data, c(0.3, 0.8))