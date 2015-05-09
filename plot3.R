#check if file exists and download it if the file does not exist
if (!file.exists("exdf.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="exdf.zip")
  #unzip("exdf.zip")  
}
#read date from file
df <- read.csv(unz("exdf.zip", "household_power_consumption.txt"),header=T,na.strings = "?",sep=";")
#Subset data based on date
df<-subset(df,as.Date(df$Date)==as.Date("02/01/2007")|as.Date(df$Date)==as.Date("02/02/2007"))

#Convert dates to date format
df$Date <- as.Date(df$Date, format="%d/%m/%y")
df$Time <- strptime(df$Time, format="%H:%M:%S")


#Create Plot 2
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")
#data$Date <- as.Date(data$Date, format="%d/%m/%y")
#data$Time <- strptime(data$Time, format="%H:%M:%S")


df$Datetime <- paste(df$Date,df$Time)


png("plot3.png", width = 480, height = 480)
ylimits = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3))
plot(df$Time, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
par(new = TRUE)
plot(df$Time, df$Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
par(new = TRUE)
plot(df$Time, df$Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       #bg = "transparent",
       #bty = "n",
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
dev.off ()  