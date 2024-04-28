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

# Make a line plot of global_active_power (y) versus time (x), no title
# y axis title: "Global Active Power (kilowatts)", x axis: no title, weekday as ticks
time_range <- seq(min(hs_pw2$dateTime),max(hs_pw2$dateTime)+100,by="days")
plot(hs_pw2$dateTime, as.numeric(hs_pw2$Global_active_power),
     type = "l", 
     xlab = "", xaxt = "n",
     ylab = "Global Active Power (kilowatts)")
axis.POSIXct(1, at=time_range, "days",format = "%a")


# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file="plot2.png", width=480,height=480)
dev.off()