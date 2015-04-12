library(sqldf)


url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "household_power_consumption.zip"
if(!file.exists(downloadFile)){
   download.file(url, downloadFile, method = "curl")
}

dataFile <- "household_power_consumption.txt"
if(!file.exists(dataFile)){
    unzip(downloadFile)
}


data <- read.csv.sql(dataFile, 
             sql = "select * from file where Date == '1/2/2007' or Date =='2/2/2007'",sep=";")

dateTime <- paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time)
data$DateTime <- as.POSIXct(dateTime)

with(data, {
  plot(DateTime, Sub_metering_1, type="l",
       ylab="Energy Sub Metering", xlab="")
  lines(DateTime, Sub_metering_2,col='Red')
  lines(DateTime, Sub_metering_3,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()