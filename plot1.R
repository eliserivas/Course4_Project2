setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
library(dplyr)
options(scipen = 999)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

by_year <- NEI %>% group_by(year) %>% summarise(tot_emissions = sum(Emissions))
by_year$year <- factor(by_year$year)

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot1.png")
barplot(by_year$tot_emissions, names = by_year$year, 
        xlab = "Year", ylab = "Total Emissions (Tons)", ylim = c(0,7500000),
        main = "Total PM2.5 Emissions by Year", col = "turquoise")
dev.off()

# Conclusion: total PM2.5 emissions have decreased since 1999, declining every year
