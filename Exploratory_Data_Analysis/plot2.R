#plot2

# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## This first line will likely take a few seconds. Be patient!
# import data
if (!exists("NEI")){
      NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

#ploting
BCM_sb <- (subset(NEI, fips == '24510'))
with(BCM_sb, plot(unique(year),tapply(Emissions,year,sum, na.rm = TRUE),
     xlab = "year", 
     ylab = "PM2.5 Emission", 
     main = "Total PM2.5 Emission in Baltimore City, Marlyland from 2000-2008"))

#graphics device
dev.copy(png, file = "plot2.png")
dev.off()