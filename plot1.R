#read raw data.
hhpc <- read.table(unz("exdata_data_household_power_consumption.zip", "household_power_consumption.txt"), header=T, sep=";")

#force any missing values to NA 'in data missing values are denoted by ?'
hhpc[hhpc =='?'] <- NA
unknown <- "?"


#convert rawdata date to R format.
hhpc$Date <- as.character(hhpc$Date)
hhpc$Date2 <-as.Date(strptime(hhpc$Date,format="%d/%m/%Y",tz=""))

#create subset of data needed for analysis (feb1 and feb2 2007 data)
#hh    = subset(hhpc, Date2 > as.Date(as.character("2007-01-31"),"%Y-%m-%d"))
#h  = subset(hh, Date2   < as.Date(as.character("2007-02-03"),"%Y-%m-%d"))

hh    = subset(hhpc, Date2 > "2007-01-31")
h     = subset(hh, Date2   < "2007-02-03")


#change active power to numeric type
h$Global_active_power <- as.numeric(as.character(h$Global_active_power))

#opend png graphic device and create plot
png(file = "plot1.png")
hist(h$Global_active_power, xlab="Global Active Power (kilowatts)" , ylab = "Frequency", col = "red",main = "Global Active Power")

#close graphic device
dev.off()

