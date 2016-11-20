#read the data file from working directory
file <- "./household_power_consumption.txt"

#read lines, as reading the complete data into df using read.table is memory intensive
allLines <- readLines(file)
#find the line numbers corresponding to dates 2007-02-01 and 2007-02-02
reqLines <- grep("^[12]/2/2007", allLines)

#read the lines into a df - include first line as that has the header
readDF <- read.table(text=c(allLines[1], allLines[reqLines]), header=TRUE, sep=";" )

#open PNG Graphical Device
png(file="./plot1.png", 480, 480)

#plot the histogram
with(readDF, hist(Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power"))

#close the device
dev.off()
