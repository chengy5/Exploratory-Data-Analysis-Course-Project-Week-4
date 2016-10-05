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

#Question 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)
emissionytBLmv <- NEI %>% filter(type =="ON-ROAD" & fips == "24510" | fips == "06037") %>% group_by(fips,year) %>% rename(City = fips) %>% summarize(Emissions = sum(Emissions, na.rm=T))
emissionytBLmv$City <- gsub("24510","Baltimore", emissionytBLmv$City )
emissionytBLmv$City <- gsub("06037","Los Angeles", emissionytBLmv$City )

png("plot6.png",width = 800, height = 480)
ggplot(emissionytBLmv, aes(year, Emissions,fill=City))+ 
  geom_bar(stat = "identity")+
  facet_wrap(~ City, ncol=2, scales="free")+ 
  theme_bw()+
  xlab("Year")+
  ylab(" PM2.5 Emission (in tons)")+
  ggtitle("Plot 6: PM2.5 Emission from Motor Vehicle by Year in Baltimore and Los Angeles")
dev.off()