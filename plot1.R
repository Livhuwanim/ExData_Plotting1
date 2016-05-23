
# Create a working directory called "ExData_Plotting1" to save all your workings

# Set the working directory to the directory created above

setwd("./ExData_Plotting1")

# Download the data set from the web address and then save it in the working directory

fileUrl<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
download.file(fileUrl,destfile = "Electiric Power Consumption.zip")

# Unzip downloaded zipped file.

unzip("Electiric Power Consumption.zip")

# Read the power consumption data to a data frame.

data<-read.table("household_power_consumption.txt",header = TRUE,sep=";")

# Format the "Date" column as a date.

data$Date<-as.Date(data$Date,"%d/%m/%Y")

# Convert the "Time" column to date time

data$Time<-strptime(data$Time,"%H:%M:%S")

# Extract time only from date time on column "Time".

data$Time<-strftime(data$Time,format="%H:%M:%S")

# Data Extract for 2 days

data_subset<-subset(data,Date>="2007-02-01" & Date<="2007-02-02")


## Global Active Power subset, exclude rows with missing values

Global_power<-data_subset[data_subset$Global_active_power!="?",]

# Format the columns as numeric data type

Global_power$Global_active_power<-as.numeric(as.character(Global_power$Global_active_power))
Global_power$Sub_metering_1<-as.numeric(as.character(Global_power$Sub_metering_1))
Global_power$Sub_metering_2<-as.numeric(as.character(Global_power$Sub_metering_2))
Global_power$Sub_metering_3<-as.numeric(as.character(Global_power$Sub_metering_3))
Global_power$Voltage<-as.numeric(as.character(Global_power$Voltage))
Global_power$Global_reactive_power<-as.numeric(as.character(Global_power$Global_reactive_power))

# Create a date time variable

Global_power<-cbind(Global_power,as.POSIXct(paste(Global_power$Date, Global_power$Time), format="%Y-%m-%d %H:%M:%S"))

# Name the newly created column

names(Global_power)[10]<-"DateTime"


# Plot 1.

hist(Global_power$Global_active_power,col="Red",xlab="Global Active Power (kilowatts)", main= "Global Active Power")
dev.copy(png,"Plot 1.png",width=480,height=480)
dev.off()

