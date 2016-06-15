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

# open PNG device; create "plot2.png" in working directory
# default size is 480 x 480 px
png(file = "plot2.png")

# create plot and send to the file
with(powerData, plot(Datetime, Global_active_power, type = "n",
                     ylab = "Global Active Power (kilowatts)",
                     xlab = ""))
# add lines
with(powerData, lines(Datetime, Global_active_power))
dev.off() ## close the PNG file device

