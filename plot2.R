###################################################
# plot2.R
# DESCRIPTION: This script is used to generate plot2
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
# Generate Plot 2
###################################################
library(data.table)
data <- fread("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data[,DateTime:=as.POSIXct(paste(Date,Time),format="%d/%m/%Y %H:%M:%S")]
datasubset <- data[(DateTime>="2007-02-01")&(DateTime<"2007-02-03")]
png("plot2.png",width=480,height=480)
plot(datasubset$DateTime,datasubset$Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()
