# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

coal_sources = c("Fuel Comb - Comm/Institutional - Coal", "Fuel Comb - Industrial Boilers, ICEs - Coal","Fuel Comb - Electric Generation - Coal")
coal_based_PM25 = SCC$SCC[SCC$EI.Sector %in% coal_sources]

coal_NEI = subset(NEI, SCC %in% coal_based_PM25)

total_coal_emissions = with(coal_NEI, tapply(Emissions, year, sum, na.rm=TRUE))



png("aqs/plot4.png")

plot(names(total_coal_emissions), total_coal_emissions, xlab = "YEAR", ylab="Total Coal based Emissions (Tons)", main = "Total Coal based Emissions 1999 - 2008", type = "l", col="red")

dev.off()