library(sqldf)

#Read in data where Date = 1/2/2007 or 2/2/2007
file <- "household_power_consumption.csv"
data <- read.csv.sql(file, sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

#Change Date and Time columns to date and time variables
date <- strptime(data$Date, format="%d/%m/%Y")
time <- strptime(data$Time, format="%H:%M:%S")

#Combine the date and time columns with rest of data set
newData <- cbind(date, time, data[,3:9])

png("plot3.png", width=480, height=480)
plot(newData$Sub_metering_1, type="l", axes=F, xlab="", frame.plot=T, ylab="Energy sub metering")
lines(newData$Sub_metering_2, type="l", col="red")
lines(newData$Sub_metering_3, type="l", col="blue")
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()
