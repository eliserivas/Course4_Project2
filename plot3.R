setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
options(scipen = 999)
library(dplyr)
library(ggplot2)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI$year <- factor(NEI$year)
NEI$type <- factor(NEI$type)

balt_type <- NEI %>% subset(fips=='24510') %>% group_by(type, year) %>% 
  summarise(tot_emissions=sum(Emissions))

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot3.png")
ggplot(balt_type, aes(x = year, y=tot_emissions, group = type, colour = type)) + 
  geom_line(size=1) + theme_bw() + ylim(0,2500) + xlab("Year") + ylab("Total Emissions (Tons)") +
  ggtitle("Total PM2.5 Emissions by Source in Baltimore City From 1999-2008")
dev.off()

# Conclusion: PM2.5 non-road, on-road, and nonpoint emissions in Baltimore City have decreased
# from 1999-2008. Point emissions, however, increased sharply from 1999 to 2005, then declining 
# by 2008 to almost the 1999 levels

