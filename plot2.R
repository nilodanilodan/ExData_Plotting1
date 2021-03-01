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

#graph2
#save into png
png("plot2.png", width = 600, height = 350)
with(electric1, plot(DateAndTime, Global_active_power, type = "l",
                     xlab = "",
                     ylab = "Global Active Power (kilowatts)"))
dev.off()
