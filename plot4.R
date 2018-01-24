# Module 4: Exploratory Data, Course Project 1.
# Plotting Data
# Introduction
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the "Individual household electric power consumption Data Set" which I have made available on the course web site:
#      Dataset: Electric power consumption [20Mb]
# 
# Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#      
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# load the libraries needed

# Download the dataset if its not yet downloaded
# filename <- "exdata_household_power_consumption.zip"
# 
# ## Download and unzip the given dataset:
# if (!file.exists(filename)){
#      fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#      download.file(fileURL, filename, method="curl")
# }  
# if (!file.exists("household_power_consumption.txt")) { 
#      unzip(filename) 
# }

# Read the dataframe in R
householdDat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")

# convert the Date/Time column to R date and time class
householdDat$Date <- as.Date(householdDat$Date, "%d/%m/%Y")
# Subset the data on the dates needed
houseDat <- subset(householdDat, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))

# Plot4.R
# generate the x-axis to R-time class
taxis <- sort(strptime(paste(as.character(houseDat$Date),as.character(houseDat$Time), sep=" "), format="%Y-%m-%d %H:%M:%S"))
# generate the y-axis data
GlobalActivePower <- as.numeric(houseDat$Global_active_power)
GlobalReactivePower <- as.numeric(houseDat$Global_reactive_power)
Voltage <- as.numeric(houseDat$Voltage)
SubMeter1 <- as.numeric(houseDat$Sub_metering_1)
SubMeter2 <- as.numeric(houseDat$Sub_metering_2)
SubMeter3 <- as.numeric(houseDat$Sub_metering_3)

# prepare the 4 plots
par(mfrow = c(2, 2))

# plot on the (1,1)
plot(taxis, GlobalActivePower,type="l", ylab="Global Active Power (kilowatts)", xlab="")

# plot on the (1,2)
plot(taxis, Voltage,type="l", ylab="Voltage", xlab="datetime")

# plot on the (2,1)
plot(taxis, SubMeter1, type="l", ylab="Energy sub metering")
lines(taxis, SubMeter2, type="l", col="red")
lines(taxis, SubMeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col=c("black", "red", "blue"), cex=0.25)

# plot on (2,2)
plot(taxis, GlobalReactivePower,type="l", ylab="Global_reactive_power", xlab="datetime")

# copy to a PNG device with 480x480 resolution
dev.copy(png, width=480, height=480, file="plot4.png"); dev.off()
