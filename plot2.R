library(data.table)
library(tidyverse)


## loading the entire dataset and subset data that I'm interested
# noticed that we're interested in the dates 2007-02-01 and 2007-02-02
# but the Date variable in the dataset are in the character class
# 1/2/2007 and 2/2/2007
# So, I use as.Date() to change them to Date class

# using fread() from the data.table package make the reading process much 
# faster compared with the read.table() from the base package

## reading and subsetting data
dt <- as.tibble(fread("data/household_power_consumption.txt", 
                      na.strings = "?"))
subset.dt  <- dt %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007") 

subset.dt$Date <- as.Date(subset.dt$Date, format = "%d/%m/%Y")

subset.dt$DateTime <- with(subset.dt, as.POSIXct(paste(Date, Time)))

## construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
with(subset.dt, plot(DateTime, Global_active_power, type ='l', lwd = 2,
                     xlab = "",
                     ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()