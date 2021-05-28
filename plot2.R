####################################################################################################################
################################################## Course Project 1: plot2.R #########################################
####################################################################################################################
#Note:  Set working directory = source file diretory
########################################### Capture dataset for use in Problem #####################################

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/exdata_data_household_power_consumption.zip",method="curl")

# unzip(zipfile="./data/exdata_data_household_power_consumption.zip",
#       files = NULL, list = FALSE, overwrite = TRUE,
#       junkpaths = FALSE, exdir = "./data", unzip = "internal",
#       setTimes = FALSE)


check_data <- read.table(unz("./data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), nrows=10, header=TRUE, quote="\"", sep=";")
classes<-sapply(check_data, class)

#data <- read.table(unz("./data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, quote="\"", sep=";")
data <- read.table(unz("./data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=TRUE, sep=";")

#data<-data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]
data<-data[as.Date(data$Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(data$Date, "%d/%m/%Y") <= "2007-02-02",]
table(data$Date)

library(lubridate)
data$dtTime<-dmy_hms(paste(data$Date,data$Time, sep=" "))

library(dplyr)
data<-mutate(data, 
             Date=as.Date(Date), 
             Time=hms(Time),
             Global_active_power=as.numeric(Global_active_power),
             Global_reactive_power=as.numeric(Global_reactive_power),
             Voltage=as.numeric(Voltage),
             Global_intensity=as.numeric(Global_intensity),
             Sub_metering_1=as.numeric(Sub_metering_1),
             Sub_metering_2=as.numeric(Sub_metering_2),
             Sub_metering_3=as.numeric(Sub_metering_3)
             )

summary(data)
########################################### Subsetted to the proper dates ####################################

plot(data$dtTime, data$Global_active_power, type="l", col="black", ylab="Global Active Power (kilowatts)", xlab="")
     
png("./plot2.png", width=480, height=480)
plot(data$dtTime, data$Global_active_power, type="l", col="black", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

#png file is created in same directory as source code.  The dimensions can be checked; they are 480x480.
