# 1. Download and read the data

## downloading zip file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("exdata-data-household_power_consumption.zip")) {
  download.file(fileURL, destfile = "exdata-data-household_power_consumption.zip")
}
## unzipping file
if (!file.exists("household_power_consumption")) {
  dir.create("household_power_consumption")
  unzip("exdata-data-household_power_consumption.zip", exdir = "household_power_consumption")
}

## some strange method to get colnames))))
table_for_colnames <- read.table("./household_power_consumption/household_power_consumption.txt", nrows = 1, sep = ";", header = TRUE)
colnames <- colnames(table_for_colnames)

## reading data from unzipped file, just the two days we need, to make things faster
selected_data <- read.table("./household_power_consumption/household_power_consumption.txt", na.strings = "?", skip = 66637, nrows = 2880, sep = ";", col.names = colnames)

## adding date & time variable
datetime <- strptime(paste(selected_data$Date, selected_data$Time), format = "%e/%m/%Y %H:%M:%S")


# 2. Construct plot3

## constructing the plot
##### the weekday's names on x axis in the github picture are in my native language - i guess it's somewhere
##### in R'Studio settings, but i don't see where to change it yet. If you run the same code, the resulting
##### picture will slightly differ :)
plot(x = datetime, y = selected_data$Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab = "")
lines(x = datetime, y = selected_data$Sub_metering_2, col = "red")
lines(x = datetime, y = selected_data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2)
     
## copying the plot to png file
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()