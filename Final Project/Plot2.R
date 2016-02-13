# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

baltimore_emissions <- subset(NEI, fips == "24510")
balt_total <- with(baltimore_emissions, tapply(Emissions, year, sum, na.rm=TRUE))
png("aqs/plot2.png")
plot(names(balt_total), balt_total, type="l", xlab = "YEAR", ylab="Total Emissions (Tons)", main = "Total Emissions in Baltimore (1999 - 2008)", col="red")
dev.off()