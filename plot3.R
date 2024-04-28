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
    mutate(dateTime = strptime(dateTimeString,"%d/%m/%Y %H:%M:%S")) 

# Make a line plot of the 3 different energy sub metering (y) versus time (x), no title
# y axis title: "Energy sub metering", x axis: no title, weekday as ticks
# metering 1 in black, 2 in red and 3 in blue. Add legend on top right
time_range <- seq(min(hs_pw2$dateTime),max(hs_pw2$dateTime)+100,by="days")
plot(hs_pw2$dateTime, as.numeric(hs_pw2$Sub_metering_1),
     type = "l",      xlab = "", xaxt = "n", ylab = "Energy sub metering")
    lines(hs_pw2$dateTime, as.numeric(hs_pw2$Sub_metering_2), col="red") 
    lines(hs_pw2$dateTime, hs_pw2$Sub_metering_3, col="blue")
axis.POSIXct(1, at=time_range, "days",format = "%a")
legend("topright",col = c("black","red","blue"), lty = 1,cex = 0.9,
       text.width = strwidth("Sub_metering_3"), box.lwd = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file="plot3.png", width=480,height=480)
dev.off()