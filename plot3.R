###############################################################
##
## plot3.R   - Program for the 3rd plot of the Course Project 1
##             in the Exploratory Data Analysis course:
##             Energy Sub Metering over Time
##
## created July 2019 by Patrick Simon
##
###############################################################

## Check if the data zipfile has already been downloaded
if(!file.exists("exdata_data_household_power_consumption.zip")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl,destfile="exdata_data_household_power_consumption.zip",method="libcurl")
}

## Check if the file has already been unzipped, otherwise do so
if(!file.exists("household_power_consumption.txt")){
        unzip("exdata_data_household_power_consumption.zip")
} 

## Read the column names from the file
col_names <- read.table("household_power_consumption.txt",header=FALSE,sep=";",
                        nrows=1,stringsAsFactors = FALSE)

## Read only the relevant 2880 data points (= 2*24*60) on 2007-2-1 and 2007-2-2
data <- read.table("household_power_consumption.txt",header=FALSE,sep=";",
                skip=66637,nrows=2880, stringsAsFactors = FALSE, na.strings="?")

## Assign correct column names
colnames(data) <- col_names

## Convert Date and Time columns to R formats
dateandtime <- paste(data$Date,data$Time)
data$Date <- as.Date(dateandtime, "%d/%m/%Y")
data$Time <- strptime(dateandtime, "%d/%m/%Y %H:%M:%S")


## Temporarily switch to English locale, to ensure correct axis labels
oldlocale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","English")


## make Energy sub metering over time plot with the PNG device
png("plot3.png",width = 480,height = 480)

## create empty frame with correct labels and dimensions
plot(data$Time,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")

## add the three datasets one after the other
points(data$Time,data$Sub_metering_1,type="l",col="black")
points(data$Time,data$Sub_metering_2,type="l",col="red")
points(data$Time,data$Sub_metering_3,type="l",col="blue")

## add the legend
legend("topright",lty=c("solid","solid","solid"),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()    ## always close the device!

## Return to original locale
Sys.setlocale("LC_TIME",oldlocale)
