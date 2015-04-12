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
par(mfrow = c(2, 2))
with(data, {
  plot(DateTime, Global_active_power, type="l", 
       ylab="Global Active Power", xlab="")
  plot(DateTime, Voltage, type="l", 
       ylab="Voltage", xlab="")
  plot(DateTime, Sub_metering_1, type="l", 
       ylab="Energy sub  metering", xlab="")
  lines(DateTime, Sub_metering_2,col='Red')
  lines(DateTime, Sub_metering_3,col='Blue')
  legend("topright", bty = "n", lty=1, col = c("black", "red", "blue"), inset=c(0,0), x.intersp=0, cex=0.4, pt.cex = 0.4,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(DateTime, Global_reactive_power, type="l", 
       ylab="Global_reactive_power",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()