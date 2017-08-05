setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
options(scipen = 999)
library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

balt_emissions <- NEI %>% subset(fips=="24510") %>% group_by(year) %>% 
  summarise(tot_emissions=sum(Emissions))

balt_emissions$year <- factor(balt_emissions$year)

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot2.png")
barplot(balt_emissions$tot_emissions, names = balt_emissions$year, 
        xlab = "Year", ylab = "Total Emissions (Tons)", ylim = c(0,3500),
        main = "Total PM2.5 Emissions by Year in Baltimore City", col = "turquoise")
dev.off()

# Conclusion: total PM2.5 emissions have gone down from 1999 to 2008, but sporadically
# There was an increase from 2002 to 2005, but a decline again in 2008 below the levels of 1999