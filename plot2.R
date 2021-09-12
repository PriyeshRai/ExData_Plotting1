library(data.table)
library(dplyr)
# READ data
dt <- fread("household_power_consumption.txt", 
            colClasses = c("character", "character", "numeric", "numeric", 
                           "numeric", "numeric", "numeric", "numeric", "numeric"), 
            na.strings = "?")

## combine Date and Time in one column
DateTime <- strptime(paste(dt$Date, dt$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
dt <- cbind(dt, DateTime)

## change class of Date and Time
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt$Time <- format(dt$Time, format =  "%H:%M:%S")

## subset data from 2007-02-01 to 2007-02-01
subset.dt <- subset(dt, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## plot histogram of global active power for those 2 days
png("plot2.png", width = 480, height = 480)
with(subset.dt, plot(DateTime, Global_active_power, type = "l", 
                     ylab = "Global Active Power (kilowatts)"))
dev.off()
