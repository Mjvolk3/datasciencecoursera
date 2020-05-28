# Plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
# vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

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
      summarize(BCM.emissions.total = sum(Emissions))

#Los Angeles County
LAC_sb <- (subset(NEI, fips == '06037'))
motor_emissions_LAC <- LAC_sb %>% 
      filter(SCC %in% SCC_sub) %>% 
      group_by(year) %>% 
      summarize(LAC.emissions.total = sum(Emissions))

#combine
motor_emissions_comb <- data.frame(left_join(motor_emissions_BCM, motor_emissions_LAC, by = 'year'))
motor_emissions_tidy <- motor_emissions_comb %>% 
      gather(key = Location, value = Emissions, BCM.emissions.total:LAC.emissions.total)

## ploting
library(ggplot2)
g <- ggplot(data = motor_emissions_tidy, aes(x = year, y = Emissions, color = Location)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = "Motor Emissions in Baltimore City (BCM) and Los Angeles (LAC)", x = "year", y = "Emissions")
g

## Saving
ggsave("plot6.png")