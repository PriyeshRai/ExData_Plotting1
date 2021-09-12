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
png("plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

with(subset.dt, {plot(DateTime, Global_active_power, type = "l", col = "black", ylab = "Global Active Power (kilowatts)") 
                
        plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "Day", ylab = "Energy sub metering")
                lines(subset.dt$DateTime, subset.dt$Sub_metering_2, col = "red")
                lines(subset.dt$DateTime, subset.dt$Sub_metering_3, col = "blue")
                legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col = c("black", "red", "blue"))
        
        plot(DateTime, Voltage, type = "l", col = "black", xlab = "datetime", ylab = "Voltage")
        
        plot(DateTime, Global_reactive_power, type = "l", col = "black", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()
