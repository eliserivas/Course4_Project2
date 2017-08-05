setwd("C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4")
options(scipen = 999)
library(dplyr)
library(ggplot2)

# Across the United States, how have emissions from 
# coal combustion-related sources changed from 1999-2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Do a search for coal in EI.Sector to get SCCs that correspond
coal_sccs <- unique(SCC[grepl('coal', SCC$EI.Sector, ignore.case = T), "SCC"])
length(coal_sccs) # 99 SCCs about coal

coal_emissions <- NEI %>% subset(SCC %in% coal_sccs) %>% 
  group_by(year) %>% summarise(tot_emissions=sum(Emissions))

coal_emissions$year <- factor(coal_emissions$year)

png(filename = "C:/Users/elrivas/Documents/Trainings/JHU/Class4/Week 4/plot4.png")
g <- ggplot(coal_emissions, aes(x=year, y=tot_emissions)) + 
  geom_bar(stat = "identity", fill="#DD8888", color="black") +
  ggtitle("US-Wide Coal Combustion-Related PM2.5 Emissions from 1999-2008") + xlab("Year") + 
  ylab("Total Emissions (Tons)") + theme_minimal() + theme(plot.title = element_text(hjust = 0.5))
print(g)
dev.off()

# Conclusion: Coal combustion PM2.5 pollution changed little from 1999-2005 but declined
# significantly in 2008, showing an overall decrease over time. 
# There was a slight decrease between 1999 and 2002, but a slight increase
# again in 2005. 2005 to 2008 shows a notable decline
