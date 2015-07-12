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
png(file = "plot1.png" , width = 480, height = 480)
par( mar = c(5,6,4,3), bg = "transparent")
hist(DT2$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )
dev.off()
