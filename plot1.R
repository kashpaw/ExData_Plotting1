plot1 <- function() {

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

# A function for plotting graphs
## I made this so the output would both display the graph on screen and 
## write it to file. There's probably a clever way of doing this!
## I used the par function in the first three graphs just in case you had 
## previous par conditions giving you multipanel maps. 
plotty <- function(workset) {
par(mfrow=c(1,1))
hist(workset[,3], col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
}

# Create PNG file
## When I selected transparent as my background, I got a black screen 
## so I had to set it as white.
#plotting code
png(file="plot1.png", bg = "white")
plotty(workset)
dev.off()

# Displays the graph onscreen.
plotty(workset)

}