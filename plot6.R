setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
options(scipen = 999)
library(dplyr)
library(ggplot2)

# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset to these counties and motor vehicle type emissions

la_balt_motor <- NEI %>% subset(fips %in% c('06037', '24510') & type=="ON-ROAD") %>% group_by(fips, year) %>%  summarise(tot_emissions=sum(Emissions))
la_balt_motor$fips <- factor(la_balt_motor$fips)
levels(la_balt_motor$fips) <- c('LA County', 'Baltimore City')

la_balt_motor$year <- factor(la_balt_motor$year)

# Plot

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot6.png")
g <- ggplot(la_balt_motor, aes(x=year, y=tot_emissions, group = fips, fill = fips)) + 
  geom_bar(stat = "identity", color="black", position = position_dodge()) +
  ggtitle("Baltimore City and LA County Motor Vehicle PM2.5 Emissions from 1999-2008") + xlab("Year") + 
  ylab("Total Emissions (Tons)") + theme_minimal() + theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.off()

# Chg over time
# final-initial/initial
LA_chg <- (4101.32100-3931.12000)/3931.12000 # 4% increase
Balt_chg <- (88.27546-346.82000)/346.82000 # 75% decrease

# Comclusion: Though LA motor pollution is larger than Baltimore's,
# Baltimore has seen a greater change over time (75% decrease from 1999 to 2008).
# LA motor pollution levels increased from 1999 to 2005 and decreased slightly in 2008.
# The LA 2008 level is still higher than 1999