#Install necessary packages
if (!"lubridate" %in% installed.packages()){ install.packages("lubridate")} 
if (!"data.table" %in% installed.packages()){ install.packages("data.table")} 
library(lubridate)
library(data.table)

#Loading in data
DT <- fread("../household_power_consumption.txt",na.strings = "?", 
            header=TRUE, stringsAsFactors = FALSE);

#Subsetting and Type conversion
DT2 <- DT[Date=="2/2/2007" | Date == "1/2/2007",]
DT2$Global_active_power <- as.numeric(DT2$Global_active_power)
DT2$Global_reactive_power <- as.numeric(DT2$Global_reactive_power)
DT2$Voltage <- as.numeric(DT2$Voltage)
DT2$Global_intensity <- as.numeric(DT2$Global_intensity)
DT2$Sub_metering_1 <- as.numeric(DT2$Sub_metering_1)
DT2$Sub_metering_2 <- as.numeric(DT2$Sub_metering_2)
DT2$Sub_metering_3 <- as.numeric(DT2$Sub_metering_3)

#Plotting
Sys.setlocale("LC_ALL", 'en_US.UTF-8')
png(file = "plot2.png" , width = 480, height = 480)
par( mar = c(5,4,3,2), bg = "transparent")
plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Global_active_power,type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)
dev.off()


