# The input file has been pre-truncated using Vim to CY 2007 to speed 
# up the process

# Read the input file
electric_power_consumption = read.table("electric_power_consumption.txt", header=T, sep=";", na.strings="?")

# Remove all the rows with NA
electric_power_consumption = na.omit(electric_power_consumption)

# Create a new column that's a combination of the Date and time string
electric_power_consumption$TDate = paste(electric_power_consumption$Date, electric_power_consumption$Time)
# Update the Date column to Date class
electric_power_consumption$Date = as.Date(electric_power_consumption$TDate, "%d/%m/%Y")
# Update the Time column to Time class
electric_power_consumption$Time =strptime(electric_power_consumption$TDate, "%d/%m/%Y %T")

#We are only interested in date between Feb-1st - Feb-2nd
begda = as.Date("2007/01/02","%Y/%d/%m")
endda = as.Date("2007/02/02","%Y/%d/%m")

#Subset the date to 1st and 2nd of Feb
electric_power_consumption = subset(electric_power_consumption,electric_power_consumption$Date == begda |electric_power_consumption$Date == endda)

#Open the png device
png("plot4.png")

#setup 4x4
par(mfrow = c(2,2))

#Plot 1
plot(electric_power_consumption$Time, electric_power_consumption$Global_active_power, type = "l",ylab = "Global Active Power",  xlab = "")

#Plot 2
plot(electric_power_consumption$Time, electric_power_consumption$Voltage, type = "l",ylab = "Voltage",  xlab = "datetime")

#Plot 3
plot(electric_power_consumption$Time, electric_power_consumption$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab="")
points(electric_power_consumption$Time, electric_power_consumption$Sub_metering_3, type ="l", col = "blue")
points(electric_power_consumption$Time, electric_power_consumption$Sub_metering_2, type="l", col="red")

#add legend in the top right corner
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),horiz=F, lty=1, col=c("black","red","blue"))

#Plot 4
plot(electric_power_consumption$Time, electric_power_consumption$Global_reactive_power, type = "l",ylab = "Global Reactive Power",  xlab = "datetime")
 

#Setup the axis
axis(side=1, at = unique(electric_power_consumption$Date), labels=(weekdays(unique(electric_power_consumption$Date))))

#close file
dev.off()
