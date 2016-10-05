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

#Question 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)
emissionytB <- NEI %>% filter(fips == "24510") %>% group_by(year) %>% summarize(Emissions = sum(Emissions, na.rm=T))

png("plot2.png")
barplot(emissionytB$Emissions, ylab=" PM2.5 Emission (in tons)", names.arg=emissionytB$year,xlab="Year",main ="Plot 2: PM2.5 Emission by Year in Baltimore", col="#E52B50")
dev.off()