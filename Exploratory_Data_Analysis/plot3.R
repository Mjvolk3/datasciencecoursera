#plot3

# Of the four types of sources indicated by the \color{red}{\verb|type|}type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have 
# seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.

## This first line will likely take a few seconds. Be patient!
# import data
if (!exists("NEI")){
      NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

#ploting
library(ggplot2)
library(dplyr)
BCM_sb <- (subset(NEI, fips == '24510'))
type_year <- summarize(group_by(BCM_sb, year, type), total = sum(Emissions))

g <- ggplot(data = type_year, aes(x = year, y = total)) +
      geom_line(aes(color = type), size = 1) +
      geom_point(aes(color = type), size = 2) +
      labs(title = "Emissions totals over time for different source types", x = "year", y = "Emissions Totals")
g
      
#graphics device
dev.copy(png, file = "plot3.png")
dev.off()