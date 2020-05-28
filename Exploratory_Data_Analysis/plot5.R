#plot 5

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## This first line will likely take a few seconds. Be patient!
# import data
if (!exists("NEI")){
      NEI <- readRDS("summarySCC_PM25.rds")
}

if (!exists("SCC")){
      SCC <- readRDS("Source_Classification_Code.rds")
}

## munge
library(dplyr)
# Subsetting Motor Vehicles
motor_level_two <- levels(SCC$SCC.Level.Two)[str_detect(levels(SCC$SCC.Level.Two), "Vehicle")]
SCC_sub <- SCC %>% 
      filter(SCC.Level.Two %in% motor_level_two) %>% 
      select(SCC, Short.Name, SCC.Level.Two, SCC.Level.One, SCC.Level.Three, SCC.Level.Four) %>% 
      select(SCC)
SCC_sub <- as.array(SCC_sub$SCC)

# Baltimore City Maryland
BCM_sb <- (subset(NEI, fips == '24510'))
motor_emissions_BCM <- BCM_sb %>% 
      filter(SCC %in% SCC_sub) %>% 
      group_by(year) %>% 
      summarize(emissions.total = sum(Emissions))

## ploting
library(ggplot2)
g <- ggplot(data = motor_emissions_BCM, aes(x = year, y = emissions.total)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = "Emissions from Motor Vehicle Sources in Baltimore City Over Time", x = "year", y = "Emissions")
g

# #graphics device
dev.copy(png, file = "plot5.png")
dev.off()