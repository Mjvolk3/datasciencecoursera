#W1 Quiz q1 & q2
df1 <- read.table("C:/Users/michaelvolk/downloads/getdata_data_ss06hid.csv", header = TRUE, sep = ',')
names(df)
thresh <- df$VAL[df$VAL >= 24]
thresh_nona <-thresh[!is.na(thresh)]

