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


# 2. Construct plot1

## constructing the histogram
hist(selected_data$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")

## copying the histogram to png file
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
