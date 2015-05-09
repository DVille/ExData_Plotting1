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



#create histogram based on Global Active Power
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white") ## Open .png device

## Create plot and send to a file, the .png device

with(df, hist(as.numeric(df$Global_active_power), col = "red",main="Global Active Power",
                    xlab = "Global Active Power (kilowatts)"))

dev.off()  ## Close the PNG device