###################################################
# plot4.R
# DESCRIPTION: This script is used to generate plot4
#              for the Exploratory Data Analysis Course
#              project1
###################################################
###################################################
# Download data
###################################################
if(!file.exists("household_power_consumption.txt")){
  message("Start to download the data file 'household_power_consumption.txt'")
  data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(data_url,destfile="data.zip")
  log_url <- paste0("Data was downloaded from:",data_url)
  log_date <- paste0("Data was downloaded at date:",date())
  log <- file("log.txt")
  writeLines(c(log_url,log_date),log)
  close(log)
  unzip("data.zip")
}else{
  message("'household_power_consumption.txt' is available in the folder.")
}
###################################################
# Generate Plot 4
###################################################
library(data.table)
data <- fread("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data[,DateTime:=as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]
datasubset <- data[(DateTime>="2007-02-01")&(DateTime<"2007-02-03")]
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(datasubset$DateTime,datasubset$Global_active_power,type="l",xlab="",ylab="Global Active Power")
plot(datasubset$DateTime,datasubset$Voltage,type="l",xlab="detetime",ylab="Voltage")
plot(datasubset$DateTime,datasubset$Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering")
lines(datasubset$DateTime,datasubset$Sub_metering_2,col="red")
lines(datasubset$DateTime,datasubset$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
plot(datasubset$DateTime,datasubset$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
