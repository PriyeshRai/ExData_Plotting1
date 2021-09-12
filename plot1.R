library(data.table)
library(dplyr)
# READ data
dt <- fread("household_power_consumption.txt", 
            colClasses = c("character", "character", "numeric", "numeric", 
                           "numeric", "numeric", "numeric", "numeric", "numeric"), 
            na.strings = "?")

## change class of Date and Time
dt$Date <- as.Date(dt$Date, format = "%d/%m/%Y")
dt$Time <- format(dt$Time, format =  "%H:%M:%S")

## subset data from 2007-02-01 to 2007-02-01
subset.dt <- subset(dt, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

## plot histogram of global active power for those 2 days
png("plot1.png", width = 480, height = 480)
with(subset.dt, hist(Global_active_power, col = "red", border = "black", main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)", 
              ylab = "Frequency"))
dev.off()
