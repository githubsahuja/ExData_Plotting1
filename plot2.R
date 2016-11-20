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
png(file="./plot2.png", 480, 480)

#draw the plot 
with(readDF, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#close the device
dev.off()
