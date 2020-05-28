#plot1

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## This first line will likely take a few seconds. Be patient!
# import data
if (!exists("NEI")){
      NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

#ploting
with(NEI, plot(unique(year), tapply(Emissions, year, sum, na.rm = TRUE), 
               xlab = "year", 
               ylab = "PM2.5 Emission",
               main = "Total PM2.5 Emission from 2000 - 2008"))

#graphics device
dev.copy(png, file = "plot1.png")
dev.off()