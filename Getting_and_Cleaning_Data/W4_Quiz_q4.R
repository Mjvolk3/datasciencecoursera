#Week 4 Quiz q4

#Code chunk from "W3_Quiz_q3_q4_q5.R"
GDP <- fread("W3_Quiz_q3_1_data.csv", 
             skip = 9, 
             nrow = 190, 
             select = c(1,2,4,5), 
             col.names = c("CountryCode", "Rank", "Long.Name", "GDP_Dollars"))
EDU <- fread("W3_Quiz_q3_2_data.csv")

merged_df <- merge(GDP, EDU, by = "CountryCode")
#End of code chunk
fiscal_year_ls <- grep("June", merged_df$`Special Notes`)
print(length(fiscal_year_ls))

for (i in 1:length(fiscal_year_ls)){
      print(i)
      print(merged_df$`Special Notes`[fiscal_year_ls[i]])
}
#previous GREP proved not specific enough

fiscal_year_ls <- grep("Fiscal year end: June", merged_df$`Special Notes`)
print(length(fiscal_year_ls))