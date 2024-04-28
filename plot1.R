# Load libraries
library(utils)
library(dplyr)

# Read file from the dates 2007-02-01 and 2007-02-02
hs_pw <- read.table("household_power_consumption.txt", header=TRUE, sep=";") %>%
    filter(as.Date(Date, "%d/%m/%Y") == as.Date("01/02/2007","%d/%m/%Y")|
               as.Date(Date, "%d/%m/%Y") == as.Date("02/02/2007","%d/%m/%Y"))

# Convert the Date and Time variables to Date/Time classes
hs_pw2 <- hs_pw %>% 
    mutate(dateTimeString = paste(Date,Time)) %>%
    mutate(dateTime = strptime(dateTimeString,"%d/%m/%Y %H:%M:%S"))

# Make a histogram of global_active_power, color red, title: "Gobal Active Power"
# y axis title: Frequency; x axis title: Global Active Power (kilowatts)
hist(as.numeric(hs_pw2$Global_active_power), col = "red",
     main = "Gobal Active Power",
     xlab = "Global Active Power (kilowatts)")

# Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file="plot1.png", width=480,height=480)
dev.off()