## Read datafile with readRDS function as given in assignment instructions
if (!exists("NEI")) {NEI <- readRDS("summarySCC_PM25.rds")}
if (!exists("SCC")) {SCC <- readRDS("Source_Classification_Code.rds")}

library(ggplot2)

NEI_vehicle <- NEI[(NEI$fips == "24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",]

aggregate.by.year <- aggregate(Emissions ~ year + fips, NEI_vehicle, sum)
aggregate.by.year$fips[aggregate.by.year$fips=="24510"] <- "Baltimore, MD"
aggregate.by.year$fips[aggregate.by.year$fips=="06037"] <- "Los Angeles County, CA"

png("plot6.png", width=640, height=480)
g <- ggplot(aggregate.by.year, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")
g <- g + ylab("Total emissions per year") + xlab("Year") + ggtitle('Total Emissions from road vehicles in Baltimore City vs Los Angeles County from 1999 to 2008')
print(g)
dev.off()