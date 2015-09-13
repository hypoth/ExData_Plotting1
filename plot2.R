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

#change active power to numeric type
h$Global_active_power <- as.numeric(as.character(h$Global_active_power))

#opend png graphic device
png(file = "plot2.png")

#created plot 
plot(h$Time3,h$Global_active_power, ylab="Global Active Power (kilowatts)" , xlab = "",main = "Global Active Power", type="l")

#close graphic device
dev.off()
