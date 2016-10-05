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

#Question 5. How have emissions from motor vehicle sources changed from 1999¡V2008 in Baltimore City?

library(dplyr)
library(ggplot2)
emissionytBmv <- NEI %>% filter(fips == "24510" & type =="ON-ROAD") %>% group_by(year) %>% summarize(Emissions = sum(Emissions, na.rm=T))

png("plot5.png", width = 600, height = 480)
ggplot(emissionytBmv, aes(year, Emissions))+ 
  geom_bar(stat = "identity",fill = '#E52B50')+  
  theme_bw()+
  xlab("Year")+
  ylab(" PM2.5 Emission (in tons)")+
  ggtitle("Plot 5: PM2.5 Emission from Motor Vehicle by Year and Types in Baltimore")
dev.off()