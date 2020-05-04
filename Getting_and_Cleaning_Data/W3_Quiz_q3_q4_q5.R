#Week 3 quiz q3
library(data.table)

#only works if in setwd() is used to be in desired directory
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", paste(getwd(), "/W3_Quiz_q3_1_data.csv", sep = ''))
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", paste(getwd(), "/W3_Quiz_q3_2_data.csv", sep = ''))

# q3
GDP <- fread("W3_Quiz_q3_1_data.csv", skip = 9, nrow = 190, select = c(1,2,4,5), col.names = c("CountryCode", "Rank", "Long.Name", "GDP_Dollars"))
EDU <- fread("W3_Quiz_q3_2_data.csv")

length(intersect(GDP$CountryCode, EDU$CountryCode))

merged_df <- merge(GDP, EDU, by = "CountryCode")
print(nrow(merged_df))

arranged_df <- arrange(merged_df, desc(Rank))
print(arranged_df[13,"Long.Name"])

# q4
Inc_df <- select(merged_df, Rank, "Income Group")
g_Inc <- group_by(Inc_df, `Income Group`)
#g_Inc$GDP_Dollars <- as.numeric(gsub(",", "", g_Inc$GDP_Dollars))
summarize(g_Inc, mean(Rank))

#5
ug_Inc <- ungroup(g_Inc)
a_Inc <- arrange(ug_Inc, Rank)
q_Inc <- mutate(a_Inc, quantile = ntile(Rank, 5), count = 1)          
g_qIG <- group_by(q_Inc, quantile, `Income Group`)
c <- summarize(g_qIG, sum(count))
