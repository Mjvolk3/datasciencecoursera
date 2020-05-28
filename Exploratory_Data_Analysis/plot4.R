#plot 4

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

# combustion - determined by level one of SCC
comb_level_one <- levels(SCC$SCC.Level.One)[str_detect(levels(SCC$SCC.Level.One), "combustion|Combustion|COMBUSTION")]

# coal determined by level three and four of SCC
coal_level_three <- levels(SCC$SCC.Level.Three)[str_detect(levels(SCC$SCC.Level.Three), "coal|Coal|COAL")]
coal_level_four <- levels(SCC$SCC.Level.Four)[str_detect(levels(SCC$SCC.Level.Four), "coal|Coal|COAL")]
SCC_sub <- SCC %>% 
      filter(SCC.Level.One %in% comb_level_one & (SCC.Level.Three %in% coal_level_three | SCC.Level.Four %in% coal_level_four)) %>% 
      select(SCC, Short.Name, SCC.Level.One, SCC.Level.Three, SCC.Level.Four) %>% 
      select(SCC)
SCC_sub <- as.array(SCC_sub$SCC)

# can use SCC$SCC.Level.THREE or SCC$Short.Name
coal_emissions <- NEI %>% 
      filter(SCC %in% SCC_sub) %>% 
      group_by(year) %>% 
      summarize(emissions.total = sum(Emissions))

## ploting
library(ggplot2)
g <- ggplot(data = coal_emissions, aes(x = year, y = emissions.total)) +
      geom_line(size = 1) +
      geom_point(size = 2) +
      labs(title = "Emissions from Coal Combustion-related Sources Over Time", x = "year", y = "Emissions")
g

#graphics device
dev.copy(png, file = "plot4.png")
dev.off()