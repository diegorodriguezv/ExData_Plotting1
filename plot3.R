data_folder <- "data"
zip_name <- paste(data_folder,
                  "exdata_data_household_power_consumption.zip",
                  sep = "/")
file_name <- "household_power_consumption.txt"
# Line numbers obtained by inspection in a text editor
first_line <- 66637
last_line <- 69517
data_names <-
  read.table(
    unz(zip_name, file_name),
    header = TRUE,
    sep = ";",
    nrows = 1
  )
power_data <-
  read.table(
    unz(zip_name, file_name),
    header = FALSE,
    sep = ";",
    skip = first_line,
    nrows = last_line - first_line,
    na.strings = "?",
    stringsAsFactors = FALSE
  )
names(power_data) <- names(data_names)
power_data$DateTime <-
  strptime(paste(power_data$Date, power_data$Time), "%d/%m/%Y %H:%M:%S")

# plot3
png(filename = "plot3.png")
lc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
plot(
  power_data$DateTime,
  power_data$Sub_metering_1,
  ylab = "Energy sub metering",
  xlab = "",
  type = "n"
)
lines(power_data$DateTime, power_data$Sub_metering_1, col = "black")
lines(power_data$DateTime, power_data$Sub_metering_2, col = "red")
lines(power_data$DateTime, power_data$Sub_metering_3, col = "blue")
legend(
  "topright",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  col = c("black", "red", "blue"),
  lty = "solid"
)
Sys.setlocale("LC_TIME", lc)
dev.off()