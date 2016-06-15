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

# open PNG device; create "plot1.png" in working directory
# default size is 480 x 480 px
png(file = "plot1.png")
# create plot and send to the file
with(powerData, hist(Global_active_power, col = "red", 
                     main = "Global Active Power", 
                     xlab = "Global Active Power (kilowatts)"))
dev.off() ## close the PNG file device

