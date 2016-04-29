#We have 2 tables with the data, NEI and SCC
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#Have total emissions from PM2.5 decreased in the United States
#from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.


#Sum of all emissions for every year in the table NEI
SumEmissionsYear <- aggregate(Emissions ~ year,NEI, sum)

head(SumEmissionsYear)

#xlab=year,ylab=Emissions, and save the plot as a npg file

png("plot1.png")
barplot(SumEmissionsYear$Emissions/10^5, main="Total Emissions for Year", names.arg=SumEmissionsYear$year, xlab="Year",ylab="Emissions (10^5)",cex.names=0.8)
dev.off()

#The total emissions decrease every year