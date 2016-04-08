
library(lubridate)

# Get the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method ="curl") 
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE)


# Create a subset of the relevant period
Subset.df <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
Subset.df$Global_active_power <- as.numeric(Subset.df$Global_active_power)

# Convert date time
Subset.df$DateTime <- dmy_hms(paste(Subset.df$Date, Subset.df$Time, sep=" "))


# Create the plot using the png device
png("plot2.png", width=480, height=480)
plot(Subset.df$DateTime, Subset.df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()