#Read entire file
df<-read.csv("household_power_consumption.txt",sep = ";")

#get lines with only 1/2/2007 or 2/2/2007
id <- grep("^[1-2]{1}/2/2007", df$Date)
df<-df[id,]

#Convert Strings to Date
df$Date<-as.Date(df$Date, format = "%d/%m/%Y")
df$Time<-strptime(paste(df$Date,df$Time), format = "%Y-%m-%d %H:%M:%S")
#convert row 3:9 to numeric numbers and remove na
cols.name=names(df)
cols.num <- cols.name[3:9]
df[cols.num] <- sapply(df[cols.num],as.numeric)
df<-na.omit(df)

# Create Histagram plot
plot(df$Time,df$Sub_metering_1, type = "n", ylab = "Energy sub metering",xlab = "")
points(df$Time,df$Sub_metering_1,type = "l",col = "black")
points(df$Time,df$Sub_metering_2,type = "l", col = "red")
points(df$Time,df$Sub_metering_3,type = "l", col = "blue")
legend("topright", lty=1 , col = c("black","red","blue"),legend = cols.name[7:9])
dev.copy(png, file= "plot3.png",width = 480, height = 480, units = "px")
dev.off()
