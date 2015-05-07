library(sqldf)

#Read in data where Date = 1/2/2007 or 2/2/2007
file <- "household_power_consumption.csv"
data <- read.csv.sql(file, sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

#Change Date and Time columns to date and time variables
date <- strptime(data$Date, format="%d/%m/%Y")
time <- strptime(data$Time, format="%H:%M:%S")

#Combine the date and time columns with rest of data set
newData <- cbind(date, time, data[,3:9])

#Change dates to weekdays
newData$date <- weekdays(newData$date)

png("plot2.png", width=480, height=480)
plot(newData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", axes=F, frame.plot=T)
axis(1, at=c(0,1450,2900), labels=c("Thu", "Fri", "Sat"))
axis(2)
dev.off()
