# load ggplot
library(ggplot2)

# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

#setup EI.Sector codes for motor vehicles
motor_vehicles = c("Mobile - On-Road Diesel Heavy Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles")
motor_vehicle_PM25 = SCC$SCC[SCC$EI.Sector %in% motor_vehicles]

motor_vehicles_PM25_LV_BM = subset(NEI, SCC %in% motor_vehicle_PM25 & (fips == "24510" | fips == "06037"))

motor_PM25_compare = aggregate(Emissions ~ fips + year, data = motor_vehicles_PM25_LV_BM, FUN=sum)

#Convert code to text for plotting
motor_PM25_compare$fips[motor_PM25_compare$fips=="24510"] = "Baltimore"
motor_PM25_compare$fips[motor_PM25_compare$fips=="06037"] = "Los Angeles"


png("aqs/plot6.png")
g = ggplot(motor_PM25_compare, aes(x=factor(year), y= Emissions, group=fips))
g + geom_line(aes(color=fips))+ ggtitle("Baltimore vs LA Motor Vehicle Emissions(1999 - 2008)") + xlab("YEAR") + ylab("Emissions (Tons)")

dev.off()