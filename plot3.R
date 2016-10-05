#download, unzip and load data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile = "Airpollutionfile.zip")
unzip("Airpollutionfile.zip") 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#convert variable "year" in data NEI to factor
NEI$year <- as.factor(NEI$year)

#view datasets' structure 
str(NEI)
str(SCC)

#Question 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999¡V2008 for Baltimore City? Which have seen increases in emissions from 1999¡V2008? Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)
emissionytBt <- NEI %>% filter(fips == "24510") %>% group_by(type,year) %>% summarize(Emissions = sum(Emissions, na.rm=T))

png("plot3.png", width = 700, height = 480)
ggplot(emissionytBt, aes(year, Emissions,fill=type))+ 
  geom_bar(stat = "identity")+  
  facet_wrap(~ type, ncol=4)+ 
  theme_bw()+
  xlab("Year")+
  ylab(" PM2.5 Emission (in tons)")+
  ggtitle("Plot 3: PM2.5 Emission by Year and Types in Baltimore")
dev.off()