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

# plot4
lc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
png(filename = "plot4.png")
par(mfrow = c(2, 2))
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  ylab = "Global Active Power",
  xlab = "",
  type = "n"
)
lines(power_data$DateTime, power_data$Global_active_power)
plot(
  power_data$DateTime,
  power_data$Voltage,
  ylab = "Voltage",
  xlab = "datetime",
  type = "n"
)
lines(power_data$DateTime, power_data$Voltage)
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
plot(
  power_data$DateTime,
  power_data$Global_reactive_power,
  ylab = "Global_reactive_power",
  xlab = "datetime",
  type = "n"
)
lines(power_data$DateTime, power_data$Global_reactive_power)
par(mfrow = c(1, 1))
Sys.setlocale("LC_TIME", lc)
dev.off()