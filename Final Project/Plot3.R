# load the ggplot2 library
library(ggplot2)

# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

baltimore_emissions <- subset(NEI, fips == "24510")
balt_total_by_type <- aggregate(Emissions ~ type + year, data = baltimore_emissions, FUN=sum)

png("aqs/plot3.png")

g = ggplot(balt_total_by_type, aes(x = factor(year), y= Emissions, group=type))

g + geom_line(aes(color = type)) + ggtitle("Baltimore Emissions by Source (1999 - 2008)") + xlab("YEAR") + ylab("Emissions (Tons)")



dev.off()