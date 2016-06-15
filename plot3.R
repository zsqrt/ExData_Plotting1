fileName <- "household_power_consumption.txt"
# download and unzip data
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp, mode = "wb")
unzip(temp, fileName)

# load data
powerData <- read.table(fileName, 
                        header = TRUE, sep = ";", na.strings = "?", 
                        colClasses = c(rep("character", 2), rep("numeric", 7)))
# subset data with dates from 2007-02-01 and 2007-02-02
powerData <- subset(powerData, Date == "1/2/2007" | Date == "2/2/2007")

# convert datetime string into time object
datetimeStr <- paste(powerData$Date, powerData$Time)
datetimeVec <- strptime(datetimeStr, "%d/%m/%Y %H:%M:%S")
powerData$Datetime <- datetimeVec

# open PNG device; create "plot3.png" in working directory
# default size is 480 x 480 px
png(file = "plot3.png")

# create plot and send to the file
with(powerData, plot(x = Datetime, y = Sub_metering_1, 
                     type = "n",
                     ylab = "Energy sub metering",
                     xlab = ""))
# add lines
with(powerData, lines(Datetime, Sub_metering_1, col = "black"))
with(powerData, lines(Datetime, Sub_metering_2, col = "red"))
with(powerData, lines(Datetime, Sub_metering_3, col = "blue"))

# add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1),
       col = c("black", "red", "blue"))

dev.off() ## close the PNG file device

