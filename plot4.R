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
Sys.setlocale("LC_ALL", 'en_US.UTF-8') # important for non-english locations
png(file = "plot4.png" , width = 480, height = 480)
par( mfrow = c(2,2), bg = "transparent")

## Pay attention to the sequence of my subgraphs plotting
## When plotting subgraph-3, it will first plot two empty graphs, then it 
## plots the actually subgraph-3 on second row first column.
## After that, I plot the fourth subgraph on second row second column.
## Finally, I use subgraph-1/2 to re-cover the first row, and thus
## we can get the correct results

#Subgraph-1
plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Global_active_power,type="l",
     xlab = "",
     ylab = "Global Active Power"
)

#Subgraph-2
plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Voltage,type="l",
     xlab = "datetime",
     ylab = "Voltage"
)

#Subgraph-3
with(DT2,{
    plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_1,
         type="n",xlab = "",ylab="",ylim=c(0,38))
#     plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_2,
#          type="n",xlab = "",ylab="",ylim=c(0,38))
#     plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_3,
#          type="n",xlab = "",ylab="",ylim=c(0,38))
    lines(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_1,
           col="black",type="l")
    lines(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_2,
           col="red",type="l")
    lines(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Sub_metering_3,
           col="blue",type="l")
})

legend("topright", lwd = 1,
       col = c("black","red","blue"), 
       box.lwd = 0,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(main = NULL, xlab = "", ylab = "Energy sub metering")

#Subgraph-4
plot(dmy_hms(paste(DT2$Date,DT2$Time)),DT2$Global_reactive_power,type="l",
     xlab = "datetime",
     ylab = "Global_reactive_power"
)

dev.off()
