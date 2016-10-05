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

#Question 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999¡V2008?

library(dplyr)
library(ggplot2)
SCC.coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]
NEI_SCC_coal <- merge(NEI,SCC.coal,by.x="SCC",by.y="SCC")
emissionytc <-  NEI_SCC_coal %>% group_by(year) %>% summarize(Emissions = sum(Emissions, na.rm=T))

png("plot4.png",width = 600, height = 480)
ggplot(emissionytc, aes(year, Emissions/1000))+ 
  geom_bar(stat = "identity",fill = '#007FFF')+
  theme_bw()+
  xlab("Year")+
  ylab(" PM2.5 Emission (in 1000 tons)")+
  ggtitle("Plot 4: PM2.5 Emission from Coal Combustion-related Sources by Year")
dev.off()
