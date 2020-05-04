#Week 4 Quiz q2, q3
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile = "./W4_Quiz_q2_data.csv", methods = "curl")
GDP <- fread("W4_Quiz_q2_data.csv", 
             skip = 9, 
             nrow = 190, 
             select = c(1,2,4,5), 
             col.names = c("CountryCode", "Rank", "countryNames", "GDP_Dollars"))
GDP$GDP_Dollars <- as.numeric(gsub(",", "", GDP$GDP_Dollars))
mean(GDP$GDP_Dollars)

#q3
grep("^United", countryNames)