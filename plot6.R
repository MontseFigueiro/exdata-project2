#We have 2 tables with the data, NEI and SCC
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#Only need the Data from Baltimore, fips = "24510" and Los Angeles, fips="06037"
#df[df$x %in% c('a','b'),]

EmissionsYear24510_06037 <- NEI[NEI$fips %in% c("24510","06037"),]
unique(EmissionsYear24510_06037$fips)
dim(EmissionsYear24510_06037)

SCCvehicles <- SCC[grepl("Vehicles" , SCC$EI.Sector), ]

EmissionsYearvehicles <- EmissionsYear24510_06037[EmissionsYear24510_06037$SCC %in% SCCvehicles$SCC, ]
head(EmissionsYearvehicles)

#We made the sum for every code fips(city), and for every year.
SumEmissionsYear <- aggregate(Emissions ~year+fips, EmissionsYearvehicles,sum)

#Plotting difference between the two cities
png("plot6.png")
ggplot(data=SumEmissionsYear, aes(x=year, y=Emissions, group=fips, shape=fips, colour=fips)) + geom_line() + geom_point()+ggtitle(expression(atop("Motor-Vehicle Emission Comparison",atop(italic("Baltimore vs Los Angeles, 1999-2008")))))+scale_shape_discrete(name  ="City",breaks=c("06037", "24510"),labels=c("Los Angeles", "Baltimore"))          
dev.off()
#The emissions for motor vehicles in Los Angeles have increased between 1999 and 2008 and are highest than the values from Baltimore.