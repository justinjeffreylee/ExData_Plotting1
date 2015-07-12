library(lubridate)

## Read in Data
data <- read.table("household_power_consumption 2.txt", sep = ";", 
                   header = TRUE)

## Subset to appropriate date range
data2 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Remove Data for memory's sake
rm(data)

## Open PNG graphic device
png(file="plot2.png", width=480, height=480)

## Convert Date and Time & create combined column
data2$Date <- dmy(data2$Date)
data2$Time <- hms(data2$Time)
data2 <- cbind(datetime = 0, data2)
data2$datetime <- data2$Date + data2$Time

## Add weekday column
data2 <- cbind(weekday=0, data2)
data2$weekday <- weekdays(data2$Date)

## Convert Watts to kiloWatts
data2 <- cbind(Global_active_power_kW=0, data2)
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))

## Plot Line Chart
with(data2, plot(datetime, Global_active_power, 
                 type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## Close Graphic Device
dev.off()




