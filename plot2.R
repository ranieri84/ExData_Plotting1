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
plot(df$Time,df$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)",xlab = "")
dev.copy(png, file= "plot2.png",width = 480, height = 480, units = "px")
dev.off()
