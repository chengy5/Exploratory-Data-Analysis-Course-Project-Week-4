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

#Question 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

emissionyt <- aggregate(Emissions ~ year,NEI, sum)
png("plot1.png")
barplot(emissionyt$Emissions/1000, ylab=" PM2.5 Emission (in 1000 tons)", names.arg=emissionyt$year,xlab="Year",main ="Plot 1: PM2.5 Emission by Year ", col="#0F52BA")
dev.off()
