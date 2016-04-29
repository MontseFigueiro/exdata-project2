#
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#How many types are?
unique(NEI$type)

EmissionsYear24510 <- NEI[NEI$fips=="24510",]

#Aggregate for two variables, for type and for year
SumEmissionsYear24510 <- aggregate(Emissions ~type+year, EmissionsYear24510,sum)

#Plotting
png("plot3.png")
ggplot(SumEmissionsYear24510, aes(year, Emissions, group = type,colour = type))+geom_line(size=1)+labs(title="Emissions Baltimore from 1999 to 2008")
dev.off()