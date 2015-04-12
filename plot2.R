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

plot(data$Global_active_power~data$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()