#We have 2 tables with the data, NEI and SCC
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#Only need the Data from Baltimore, fips = "24510"

EmissionsYear24510 <- NEI[NEI$fips=="24510",]

SCCvehicles <- SCC[grepl("Vehicles" , SCC$EI.Sector), ]

EmissionsYear24510vehicles <- EmissionsYear24510[EmissionsYear24510$SCC %in% SCCvehicles$SCC, ]

SumEmissionsYear <- aggregate(Emissions ~year+fips, EmissionsYear24510vehicles,sum)

#Plotting
png("plot5.png")
ggplot(EmissionsYear24510vehicles, aes(x=year, y=Emissions),xlab=year) + geom_bar(stat='identity', width=0.5)+labs(title="Emissions Vehicles from 1999-2008")+scale_x_continuous(breaks=c(1999,2002,2005,2008))+xlab("Year")+ylab("Emission Levels")
dev.off()

