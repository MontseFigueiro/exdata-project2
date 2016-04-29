

Exploratory Data Analysis - Course Project 2
============================================

# Introduction

Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National [Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

# Data

The data for this assignment are available from the course web site as a single zip file:

* [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:

PM2.5 Emissions Data (`summarySCC_PM25.rds`): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:

````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999–2008. You may use any R package you want to support your analysis.

## Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

In preparation we first ensure the data sets archive is downloaded and extracted.



We now load the NEI and SCC data frames from the .rds files.


```r
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1

Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

We have 2 tables with the data, NEI and SCC

```r
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```

Sum of all emissions for every year in the table NEI
```r
SumEmissionsYear <- aggregate(Emissions ~ year,NEI, sum)
head(SumEmissionsYear)
```
xlab=year,ylab=Emissions, and save the plot as a npg file
```r
png("plot1.png")
barplot(SumEmissionsYear$Emissions/10^5, main="Total Emissions for Year", names.arg=SumEmissionsYear$year, xlab="Year",ylab="Emissions (10^5)",cex.names=0.8)
dev.off()
```
![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/plot1.png) 

**The total emissions have decreased every year from 1999 to 2008**

### Question 2

Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

We have 2 tables with the data, NEI and SCC:

```r
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```

Only need the Data from Baltimore, fips = "24510"


```r
EmissionsYear24510 <- NEI[NEI$fips=="24510",]

head(SumEmissionsYear24510)

SumEmissionsYear24510 <- aggregate(Emissions ~year, EmissionsYear24510,sum)
head(SumEmissionsYear24510)
```
Plotting and save in .png file:

```r
png("plot2.png")
barplot(SumEmissionsYear24510$Emissions/10^2, main="Total Emissions for Year in Baltimore", names.arg=SumEmissionsYear24510$year, xlab="Year",ylab="Emissions in Baltimore (10^2)",cex.names=0.8)
dev.off()
```
![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/plot2.png) 

**Only the type POINT have increased a little the emissions from 1999 to 2008**

### Question 3

Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

We need the 2 Databases:
```r
library(ggplot2)

NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```
How many types are?
```r
unique(NEI$type)

EmissionsYear24510 <- NEI[NEI$fips=="24510",]
```
Aggregate for two variables, for type and for year:

```r
SumEmissionsYear24510 <- aggregate(Emissions ~type+year, EmissionsYear24510,sum)
```
Plotting and saving:

```r
png("plot3.png")
ggplot(SumEmissionsYear24510, aes(year, Emissions, group = type,colour = type))+geom_line(size=1)+labs(title="Emissions Baltimore from 1999 to 2008")
dev.off()
```
![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/plot3.png) 
**The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.**
**the `point` source increase until 2005 and it decreases again by 2008**


### Question 4

Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

```r
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```
Look inside the SCC file and find "coal"
```r
SCCcoal <- SCC[grepl("Coal" , SCC$Short.Name), ]
```
Select inside NEI the rows equal to the file SCC
```r
NEIcoal <- NEI[NEI$SCC %in% SCCcoal$SCC, ]
dim(SCCcoal)
```
Save the Plot inside Plot4.png file
```r
png("Plot4.png")
ggplot(NEIcoal, aes(x=year, y=Emissions/10^5),xlab=year) + geom_bar(stat='identity', width=0.5)+labs(title="Emissions Coal from 1999-2008")+scale_x_continuous(breaks=c(1999,2002,2005,2008))
dev.off()
```
![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/Plot4.png) 

** Emission form Coal from 1999-2008 have decreased between 1999 and 2002, have increased a little between 2002-2005 and have decreased between 2005 and 2008**

### Question 5

How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

We have 2 tables with the data, NEI and SCC:
```r
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```
Only need the Data from Baltimore, fips = "24510"
```r
EmissionsYear24510 <- NEI[NEI$fips=="24510",]

SCCvehicles <- SCC[grepl("Vehicles" , SCC$EI.Sector), ]

EmissionsYear24510vehicles <- EmissionsYear24510[EmissionsYear24510$SCC %in% SCCvehicles$SCC, ]
````
We can see the Sum of Emission for every year in Baltimore:
```r
SumEmissionsYear <- aggregate(Emissions ~year+fips, EmissionsYear24510vehicles,sum)
``

Plotting and saving .npg
```r
png("plot5.png")
ggplot(EmissionsYear24510vehicles, aes(x=year, y=Emissions),xlab=year) + geom_bar(stat='identity', width=0.5)+labs(title="Emissions Vehicles from 1999-2008")+scale_x_continuous(breaks=c(1999,2002,2005,2008))+xlab("Year")+ylab("Emission Levels")
dev.off()
```

![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/plot5.png) 

**The vehicles emissions have decreased from 346.82 in 1999 to 88.27 in 2008**

###Question 6

Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

We have 2 tables with the data NEI and SCC

```r
NEI<- readRDS("summarySCC_PM25.rds")
SCC<- readRDS("Source_Classification_Code.rds")
```
Only need the Data from Baltimore, fips = "24510" and Los Angeles, fips="06037"

```r
EmissionsYear24510_06037 <- NEI[NEI$fips %in% c("24510","06037"),]
unique(EmissionsYear24510_06037$fips)
dim(EmissionsYear24510_06037)

SCCvehicles <- SCC[grepl("Vehicles" , SCC$EI.Sector), ]

EmissionsYearvehicles <- EmissionsYear24510_06037[EmissionsYear24510_06037$SCC %in% SCCvehicles$SCC, ]
head(EmissionsYearvehicles)
```
We made the sum for every code fips(city), and for every year.
```r
SumEmissionsYear <- aggregate(Emissions ~year+fips, EmissionsYearvehicles,sum)
```
Plotting difference between the two cities
```r
png("plot6.png")
ggplot(data=SumEmissionsYear, aes(x=year, y=Emissions, group=fips, shape=fips, colour=fips)) + geom_line() + geom_point()+ggtitle(expression(atop("Motor-Vehicle Emission Comparison",atop(italic("Baltimore vs Los Angeles, 1999-2008")))))+scale_shape_discrete(name  ="City",breaks=c("06037", "24510"),labels=c("Los Angeles", "Baltimore"))          
dev.off()
```

![plot of chunk plot1](https://github.com/MontseFigueiro/exdata-project2/blob/master/plot6.png) 

**The emissions for motor vehicles in Los Angeles have increased between 1999 and 2008 and are highest than the values from Baltimore**



