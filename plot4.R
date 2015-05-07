library(sqldf)

#Read in data where Date = 1/2/2007 or 2/2/2007
file <- "household_power_consumption.csv"
data <- read.csv.sql(file, sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

#Change Date and Time columns to date and time variables
date <- strptime(data$Date, format="%d/%m/%Y")
time <- strptime(data$Time, format="%H:%M:%S")

#Combine the date and time columns with rest of data set
newData <- cbind(date, time, data[,3:9])

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#Plot 1
plot(newData$Global_active_power, type="l", axes=F, frame.plot=T, ylab="Global Active Power", xlab="")
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
#Plot 2
plot(newData$Voltage, type="l", axes=F, frame.plot=T, ylab="Voltage", xlab="datetime")
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
#Plot 3
plot(newData$Sub_metering_1, type="l", axes=F, xlab="", frame.plot=T, ylab="Energy sub metering")
lines(newData$Sub_metering_2, type="l", col="red")
lines(newData$Sub_metering_3, type="l", col="blue")
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"),bty="n")
#Plot 4
plot(newData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power", axes=F, frame.plot=T)
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
dev.off()
