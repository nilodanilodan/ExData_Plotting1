getwd()
setwd("D:\\Documentos\\R\\Coursera\\exploratory_data")

#memory dataset will need
#The dataset has 2,075,259 rows and 9 columns
#GB
memory <- round(2075259*9*8/2^{20}/1024, 2)
memory
#0.14gb or 140 mb will be needed to use this dataset

#get the dataset
electric <- read.csv("household_power_consumption.txt", sep = ";")

#concatenate columns Date and Time into one
electric$DateAndTime <- paste(electric$Date, electric$Time)

#transform column date into date format
electric$DateAndTime <- strptime(electric$DateAndTime, format = "%d/%m/%Y %H:%M:%S")
electric$Date <- as.Date(electric$Date, format = "%d/%m/%Y")


#subset and create new df
electric1 <- subset(electric, Date >= "2007-02-01" & Date <= "2007-02-02")

#turn Global_active_power into numeric value
electric1$Global_active_power <- as.numeric(electric1$Global_active_power)

#turn sub_meterings into numbers
electric1$Sub_metering_1 <- as.numeric(electric1$Sub_metering_1)
electric1$Sub_metering_2 <- as.numeric(electric1$Sub_metering_2)

#graph4
#change the device and turn variables into numeric
electric1$Voltage <- as.numeric(electric1$Voltage)
electric1$Global_reactive_power <- as.numeric(electric1$Global_reactive_power)

png("plot4.png", width = 600, height = 350)
par(mfrow=c(2,2), mar = c(2,4.5,1,2), oma = c(1,1,0,0))

#first
with(electric1, plot(DateAndTime, Global_active_power, type = "l",
                     xlab = "",
                     ylab = "Global Active Power"))

#second
with(electric1, plot(DateAndTime, Voltage, type = "l",
                     xlab = "datetime",
                     ylab = "Voltage"))

#third
with(electric1, plot(DateAndTime, Sub_metering_1, type = "l",
                     xlab = "",
                     ylab = "Energy sub metering"))
lines(electric1$DateAndTime, electric1$Sub_metering_2, col = "red")
lines(electric1$DateAndTime, electric1$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, cex=0.8)

#fourth
with(electric1, plot(DateAndTime, Global_reactive_power, type = "l",
                     xlab = "datetime"))

dev.off()
