#read raw data.
hhpc <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";")


#force any missing values to NA 'in data missing values are denoted by ?'
hhpc[hhpc =='?'] <- NA
unknown <- "?"

#convert rawdata date to R format.
hhpc$Date2 <-as.Date( as.character(hhpc$Date), "%d/%m/%Y")

#create subset of data needed for analysis (feb1 and feb2 2007 data)
hh    = subset(hhpc, Date2 > as.Date(as.character("2007-01-31"),"%Y-%m-%d"))
h  = subset(hh, Date2   < as.Date(as.character("2007-02-03"),"%Y-%m-%d"))

#create proper time string
h$Time2 <- paste(h$Date2,h$Time)
#convert to time format of R
h$Time3 <- strptime(h$Time2,"%Y-%m-%d %H:%M:%S")

#change  submetering to numeric type
h$Sub_metering_1 <- as.numeric(as.character(h$Sub_metering_1))
h$Sub_metering_2 <- as.numeric(as.character(h$Sub_metering_2))
h$Sub_metering_3 <- as.numeric(as.character(h$Sub_metering_3))

#opend png graphic device
png(file = "plot3.png")

#created plot 
with( h, plot  (Time3, Sub_metering_1, ylab="Energy sub metering" ,xlab = "", type="l"))
with( h, lines (Time3, Sub_metering_2, col="red"))
with( h, lines (Time3, Sub_metering_3, col="BLUE"))
legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#close graphic device  
dev.off()
