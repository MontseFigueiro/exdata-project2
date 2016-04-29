#We have 2 tables with the data, NEI and SCC
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#Only need the Data from Baltimore, fips = "24510"

EmissionsYear24510 <- NEI[NEI$fips=="24510",]

head(SumEmissionsYear24510)

SumEmissionsYear24510 <- aggregate(Emissions ~year, EmissionsYear24510,sum)
head(SumEmissionsYear24510)

#Plotting and save in .png file

png("plot2.png")
barplot(SumEmissionsYear24510$Emissions/10^2, main="Total Emissions for Year in Baltimore", names.arg=SumEmissionsYear24510$year, xlab="Year",ylab="Emissions in Baltimore (10^2)",cex.names=0.8)
dev.off()

#Only the type POINT increase a little from 1999 to 2008.