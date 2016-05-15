plot4 <- function() {

# reading code
## I read the first date in the file and manually used the 
## strptime and difftime function on strings of those dates 
## to work out how many rows to skip and how many rows were needed.
workset <- read.csv("household_power_consumption.txt", skip=66636, nrows=2880,na.strings = "?", sep=";")

# gets titles
## when you only take part of a data frame (or list etc), the names 
## (or first row) are not included so you have to get them manually
testheader <- names(read.csv("household_power_consumption.txt", nrows=1, sep=";"))
names(workset) <- testheader

# Getting a date and time column
## The trickiest bit of the assignment, I thought!
## Just using date factors and times gave me a box plot. 
## I think there's a cleverer way of doing this but...
## I pasted (which converted the columns to strings) the date and time together
## then I used as.POSIXct and forced the format to make it a proper timeseries
workset$fulldate <- as.POSIXct(paste(workset$Date,workset$Time),format="%d/%m/%Y %H:%M:%S")

# A function for plotting graphs
## I made this so the output would both display the graph on screen and 
## write it to file. There's probably a clever way of doing this!
plotss <- function(workset) {
leg_name <- names(workset[,7:9])
par(mfrow=c(2,2))
plot(workset$fulldate, workset[,3], type="l", ylab="Global Active Power", xlab="")
plot(workset$fulldate, workset[,5], type="l", ylab="Voltage", xlab="datetime")
plot(workset$fulldate, workset[,7], type="l", ylab="Energy sub metering", xlab="")
lines(workset$fulldate, workset[,8], col="red")
lines(workset$fulldate, workset[,9], col="blue")
legend("topright", leg_name, col = c("black","red","blue"), lty=c(1,1), bty="n")
plot(workset$fulldate, workset[,4], type="l", ylab="Global_reactive_power", xlab="datetime")
}

# Create PNG file
## When I selected transparent as my background, I got a black screen 
## so I had to set it as white.
png(file="plot4.png", bg = "white")
plotss(workset)
dev.off()

# Displays the graph onscreen.
plotss(workset)
}