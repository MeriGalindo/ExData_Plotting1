# Load libraries
library(utils)
library(dplyr)
library(graphics)

# Read file from the dates 2007-02-01 and 2007-02-02
hs_pw <- read.table("household_power_consumption.txt", header=TRUE, sep=";") %>%
    filter(as.Date(Date, "%d/%m/%Y") == as.Date("01/02/2007","%d/%m/%Y")|
               as.Date(Date, "%d/%m/%Y") == as.Date("02/02/2007","%d/%m/%Y"))

# Convert the Date and Time variables to Date/Time classes
hs_pw2 <- hs_pw %>% 
    mutate(dateTimeString = paste(Date,Time)) %>%
    mutate(datetime = strptime(dateTimeString,"%d/%m/%Y %H:%M:%S")) 

# Make a 4 plot layout with plot2 and plot 3 in the first column 
# and in the 2nd column Voltage vs. datetime and Global_Reactive_power vs. datetime
time_range <- seq(min(hs_pw2$datetime),max(hs_pw2$datetime)+100,by="days")
par(mfcol=c(2,2), mar=c(5,4,2,1))
# plot c1/r1
plot(hs_pw2$datetime, as.numeric(hs_pw2$Global_active_power),
     type = "l", 
     xlab = "", xaxt = "n",
     ylab = "Global Active Power")
axis.POSIXct(1, at=time_range, "days",format = "%a")
# plot c1/r2
plot(hs_pw2$datetime, as.numeric(hs_pw2$Sub_metering_1),
     type = "l", xlab = "", xaxt = "n", ylab = "Energy sub metering")
lines(hs_pw2$datetime, as.numeric(hs_pw2$Sub_metering_2), col="red") 
lines(hs_pw2$datetime, hs_pw2$Sub_metering_3, col="blue")
axis.POSIXct(1, at=time_range, "days",format = "%a")
legend("topright",col = c("black","red","blue"), lty = 1,cex = 0.9,
       text.width = strwidth("Sub_metering_3"), box.lwd = 1, bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# plot c2/r1
plot(hs_pw2$datetime,as.numeric(hs_pw2$Voltage),type = "l",xlab = "datetime", xaxt = "n",
     ylab = "Voltage",lab=c(3,7,7))
axis.POSIXct(1, at=time_range, "days",format = "%a")
# plot c2/r2
plot(hs_pw2$datetime,as.numeric(hs_pw2$Global_reactive_power),type = "l",
     xlab = "datetime", xaxt = "n",
     ylab = "Global_reactive_power")
axis.POSIXct(1, at=time_range, "days",format = "%a")
# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file="plot4.png", width=480,height=480)
dev.off()