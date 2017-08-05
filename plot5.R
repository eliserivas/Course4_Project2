setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
options(scipen = 999)
library(dplyr)
library(ggplot2)

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset to Baltimore and type - on road

balt_motor <- NEI %>% subset(type=="ON-ROAD" & fips=='24510') %>% 
  group_by(year) %>% summarise(tot_emissions=sum(Emissions))

balt_motor$year <- factor(balt_motor$year)

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot5.png")
g <- ggplot(balt_motor, aes(x=year, y=tot_emissions)) + 
  geom_bar(stat = "identity", fill="#DD8888", color="black") +
  ggtitle("Baltimore City Motor Vehicle PM2.5 Emissions from 1999-2008") + xlab("Year") + 
  ylab("Total Emissions (Tons)") + theme_minimal() + theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.off()
