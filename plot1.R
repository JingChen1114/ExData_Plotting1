###################################################
# plot1.R
# DESCRIPTION: This script is used to generate plot1
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
# Generate Plot 1
###################################################
library(data.table)
data <- fread("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
data[,Date:=as.Date(Date,"%d/%m/%Y")] 
datasubset <- data[(Date>="2007-02-01")&(Date<="2007-02-02")]
png("plot1.png",width=480,height=480)
hist(datasubset$Global_active_power,col="red",xlab="Global Active Power(kilowatts)",ylab="Frequency",main="Global Active Power")
dev.off()
