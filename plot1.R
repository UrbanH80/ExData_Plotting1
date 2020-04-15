#Memory requirement calc prior to loading data
#memory required = ncol(data) * nrow(data) * 8  bytes/numeric
#    9 * 2075259 * 8 = 149,418,648 bytes = 149 MB

#Download file and save in table
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp, "household_power_consumption.txt")
data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", colClasses = c("character", "character", rep ("numeric", 7)), header=TRUE)
#importing as character was necessary to get strptime to work
ndata <- data     #making copy to work with

#Examine Data
head(ndata)
str(ndata)


#Subset data for two days of interest
sdata <- subset(ndata, Date=="1/2/2007"| Date =="2/2/2007")

#convert date format, combine date and time
sdata$datetime <- strptime(paste(sdata$Date,sdata$Time), format = "%d/%m/%Y %H:%M:%S") #this format shows how to read date


#Build plot
hist(sdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")


#Save to PNG
png(file="plot1.png")
hist(sdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()  #exit