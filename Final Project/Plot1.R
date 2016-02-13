# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

total_emissions <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))
png("aqs/plot1.png")
plot(names(total_emissions), total_emissions, xlab = "YEAR", ylab="Total Emissions (Tons)", main = "Total Emissions 1999 - 2008", type = "l", col="red")
dev.off()
