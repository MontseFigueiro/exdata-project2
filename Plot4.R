NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")

#Look inside the SCC file and find "coal"

SCCcoal <- SCC[grepl("Coal" , SCC$Short.Name), ]

#Select inside NEI the rows equal to the file SCC

NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC, ]
dim(SCCcoal)

#Save the Plot inside Plot4.png file

png("Plot4.png")
ggplot(NEIcoal, aes(x=year, y=Emissions/10^5),xlab=year) + geom_bar(stat='identity', width=0.5)+labs(title="Emissions Coal from 1999-2008")+scale_x_continuous(breaks=c(1999,2002,2005,2008))
dev.off()
