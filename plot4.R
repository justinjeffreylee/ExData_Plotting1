library(lubridate)

## Read in Data
data <- read.table("household_power_consumption 2.txt", sep = ";", 
                   header = TRUE)

## Subset to appropriate date range
data2 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Remove Data for memory's sake
rm(data)

## Open PNG graphic device
png(file="plot4.png", width=480, height=480)

## Convert Date and Time & create combined column
data2$Date <- dmy(data2$Date)
data2$Time <- hms(data2$Time)
data2 <- cbind(datetime = 0, data2)
data2$datetime <- data2$Date + data2$Time

## Add weekday column
data2 <- cbind(weekday=0, data2)
data2$weekday <- weekdays(data2$Date)


## Cast Columns as Numeric
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))
data2$Sub_metering_3 <- as.numeric(as.character(data2$Sub_metering_3))
data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))


## Plot Charts
par(mfrow=c(2,2))
with(data2,{
        plot(datetime, Global_active_power, 
             type="l", xlab="", ylab="Global Active Power (kilowatts)")
        plot(datetime, Voltage, type="l")
        plot(datetime, Sub_metering_1, type="n", 
             ylab="Energy sub metering", xlab="", yaxt="n")
        points(datetime, Sub_metering_1, type="l")
        points(datetime, Sub_metering_2, type="l", col="red")
        points(datetime, Sub_metering_3, type="l", col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                                    "Sub_metering_3"), col=c(1,2,3), 
               lwd=c(2.5,2.5))
        box(which="plot")
        axis(side=2, at=c(0,10,20,30))
        plot(datetime, Global_reactive_power, type="l")      
})

## Close Graphic Device
dev.off()

