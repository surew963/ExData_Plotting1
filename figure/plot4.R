cmd <- 'findstr /b /c:"1/2/2007" /c:"2/2/2007" /c:"Date;" household_power_consumption.txt'
t <- paste0(system(cmd, intern = T), collapse = "\n")
dt <- fread(t, sep = ";", header = T, na.strings = '?')

dateTime<-paste(dt$Date,dt$Time)
dateTime2<-strptime(dateTime, "%d/%m/%Y %H:%M:%S")
dt$dateTime<-as.POSIXct(dateTime2)

png('plot4.png')
par(mfrow=c(2,2))


#upper left
plot(dt$dateTime,dt$Global_active_power,type="l",ylab="Global Active Power",xlab="")


#upper right
plot(dt$dateTime,dt$Voltage,type="l",ylab="Voltage",xlab="datetime")

#lower left
plot(dt$dateTime,dt$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(dt$dateTime,dt$Sub_metering_2,col="red")
lines(dt$dateTime,dt$Sub_metering_3,col="blue")

legend('topright',names(dt)[7:9],border="black",lty=1, col=c("black","red", "blue"),bty="n")


#lower right

plot(dt$dateTime,dt$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.off()