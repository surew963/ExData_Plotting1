cmd <- 'findstr /b /c:"1/2/2007" /c:"2/2/2007" /c:"Date;" household_power_consumption.txt'
t <- paste0(system(cmd, intern = T), collapse = "\n")
dt <- fread(t, sep = ";", header = T, na.strings = '?')

#typeof(dt$date)
#typeof(as.Date(dt$date))
       
dateTime<-paste(dt$Date,dt$Time)
dateTime2<-strptime(dateTime, "%d/%m/%Y %H:%M:%S")
dt$dateTime<-as.POSIXct(dateTime2)
#typeof(dt$dateTime)

png('plot2.png')
plot(dt$dateTime,dt$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.off()
