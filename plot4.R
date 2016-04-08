
library(lubridate)

# Get the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip", method ="curl") 
household_power_consumption <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors=FALSE)


# Create a subset of the relevant period
Subset.df <- household_power_consumption[household_power_consumption$Date %in% c("1/2/2007","2/2/2007") ,]
Subset.df$Global_active_power <- as.numeric(Subset.df$Global_active_power)
Subset.df$Global_reactive_power <- as.numeric(Subset.df$Global_reactive_power)
Subset.df$Voltage <- as.numeric(Subset.df$Voltage)


# Convert date time
Subset.df$DateTime <- dmy_hms(paste(Subset.df$Date, Subset.df$Time, sep=" "))

Subset.df$Sub_metering_1 <- as.numeric(Subset.df$Sub_metering_1)
Subset.df$Sub_metering_2 <- as.numeric(Subset.df$Sub_metering_2)
Subset.df$Sub_metering_3 <- as.numeric(Subset.df$Sub_metering_3)



# Create the plot using the png device
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(Subset.df$DateTime, Subset.df$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(Subset.df$DateTime, Subset.df$Voltage, type="l", xlab="datetime", ylab="Voltage")

plot(Subset.df$DateTime, Subset.df$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(Subset.df$DateTime, Subset.df$Sub_metering_2, type="l", col="red")
lines(Subset.df$DateTime, Subset.df$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(Subset.df$DateTime, Subset.df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()