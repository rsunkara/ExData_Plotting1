# read the files
NEI <- readRDS("aqs/summarySCC_PM25.rds")
SCC <- readRDS("aqs/Source_Classification_Code.rds")

NEI$type <- as.factor(NEI$type)

# setup the EI.Sector codes for motor vehicles
motor_vehicles = c("Mobile - On-Road Diesel Heavy Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles","Mobile - On-Road Diesel Light Duty Vehicles","Mobile - On-Road Gasoline Light Duty Vehicles")

motor_vehicle_PM25 = SCC$SCC[SCC$EI.Sector %in% motor_vehicles]

motor_vehicles_PM25_baltimore = subset(NEI, SCC %in% motor_vehicle_PM25 & fips == "24510")

total_motor_PM25 = with(motor_vehicles_PM25_baltimore, tapply(Emissions, year, sum, na.rm=TRUE))



png("aqs/plot5.png")

plot(names(total_motor_PM25), total_motor_PM25, xlab = "YEAR", ylab="Total Motor Vehicle based Emissions (Tons)", main = "Total Motor Vehicle based Emissions (Baltimore) 1999 - 2008", type = "l", col="red")

dev.off()