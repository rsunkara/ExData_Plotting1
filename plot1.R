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
png("plot1.png")
hist(electric_power_consumption$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
