plot3 <- function() {

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
## I used the par function in the first three graphs just in case you had 
## previous par conditions giving you multipanel maps.
plotty <- function(workset) {
par(mfrow=c(1,1))
leg_name <- names(workset[,7:9])
plot(workset$fulldate, workset[,7], type="l", ylab="Energy sub metering", xlab="")
lines(workset$fulldate, workset[,8], col="red")
lines(workset$fulldate, workset[,9], col="blue")
legend("topright", leg_name, col = c("black","red","blue"), lty=c(1,1))
}

# Create PNG file
## When I selected transparent as my background, I got a black screen 
## so I had to set it as white.
png(file="plot3.png", bg = "white")
plotty(workset)
dev.off()

# Displays the graph onscreen.
plotty(workset)
}