#W1 Quiz q5

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "delete_download.csv")
DT <- fread("delete_download.csv")
system.time(mean(DT$pwgtp15, by = DT$SEX))
system.time(sapply(split(DT$pwgtp15, DT$SEX), mean))
system.time(tapply(DT$pwgtp15, DT$SEX, mean))
system.time(rowMeans(DT)[DT$SEX == 1]; rowMeans(DT)[DT$SEX == 2])
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(mean(DT[DT$SEX == 1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))