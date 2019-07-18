###############################################################
##
## plot1.R   - Program for the 1st plot of the Course Project 1
##             in the Exploratory Data Analysis course:
##             Histogram of the Global Active Power (kW)
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

## make histogram plot with the PNG device
png("plot1.png",width = 480,height = 480)
hist(data$Global_active_power,col="red",xlab="Global active power (kilowatts)",
     main="Global Active Power")
dev.off()    ## always close the device!
