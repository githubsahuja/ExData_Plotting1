#Load library dplyr, so that we can manipulate the date time column
library(dplyr)

#read the data file from working directory
file <- "./household_power_consumption.txt"

#read lines, as reading the complete data into df using read.table is memory intensive
allLines <- readLines(file)
#find the line numbers corresponding to dates 2007-02-01 and 2007-02-02
reqLines <- grep("^[12]/2/2007", allLines)

#read the lines into a df - include first line as that has the header
readDF <- read.table(text=c(allLines[1], allLines[reqLines]), header=TRUE, sep=";" )

#convert the Date and Time variables to Date/Time
#using library dplyr
readDF <- mutate(readDF, DateTime = paste(Date, Time, sep = " "))
readDF$DateTime <- strptime(readDF$DateTime, "%d/%m/%Y %H:%M:%S")

#open PNG Graphical Device
png(file="./plot4.png", 480, 480)

#draw the plot and then add-on points and legends
#setup for 2x2 plots
par(mfrow = c(2,2))
#first plot
with(readDF, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
#second plot
with(readDF, plot(DateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
#third plot
with(readDF, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(readDF, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(readDF, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legText <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
lineColor <- c("black", "red", "blue")
with(readDF, legend("topright", lty = c(1,1,1), lwd = c(2,2,2), col = lineColor, bty = "n", cex = 0.75, legend = legText ))
#fourth plot
with(readDF, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

#close the device
dev.off()