library(lubridate)

## Read in Data
data <- read.table("household_power_consumption 2.txt", sep = ";", 
                   header = TRUE)

## Subset to appropriate date range
data2 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Remove Data for memory's sake
rm(data)

## Convert Date and Time & create combined column
data2$Date <- dmy(data2$Date)
data2$Time <- hms(data2$Time)
data2 <- cbind(datetime = 0, data2)
data2$datetime <- data2$Date + data2$Time

## Cast as.numeric
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

## Open PNG graphic device
png(file="plot1.png", width=480, height=480)

## Histogram
hist(data2$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)")

## Close Graphic Device
dev.off()
