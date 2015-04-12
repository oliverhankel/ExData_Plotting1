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



png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
dev.off()