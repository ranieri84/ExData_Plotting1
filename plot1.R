#Read entire file
df<-read.csv("household_power_consumption.txt",sep = ";")

#get lines with only 1/2/2007 or 2/2/2007
id <- grep("^[1-2]{1}/2/2007", df$Date)
df<-df[id,]

#Convert Strings to Date
df$Date<-as.Date(df$Date, format = "%d/%m/%y")

#convert row 3:9 to numeric numbers and remove na
cols.name=names(df)
cols.num <- cols.name[3:9]
df[cols.num] <- sapply(df[cols.num],as.numeric)
df<-na.omit(df)

# Create Histagram plot
hist(df$Global_active_power,col="red",breaks=seq(0,10,by=0.5), 
     xlim = c(0,6),ylim = c(0,1200),xlab = "Global Active Power (kilowatts)",
     main ="Global Active Power",xaxt='n')
axis(side=1, at=seq(0,6,2))
dev.copy(png, file= "plot1.png",width = 480, height = 480, units = "px")
dev.off()
