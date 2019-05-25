data_folder <- "data"
file_name <-
  paste(data_folder, "household_power_consumption.txt", sep = "/")
# Line numbers obtained by inspection in a text editor
first_line <- 66637
last_line <- 69517
data_names <-
  read.table(file_name,
             header = TRUE,
             sep = ";",
             nrows = 1)
power_data <-
  read.table(
    file_name,
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
lc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
# plot1
hist(
  power_data$Global_active_power,
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  col = "red"
)
# plot2
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  ylab = "Global Active Power (kilowatts)",
  xlab = "",
  type = "n"
)
lines(power_data$DateTime, power_data$Global_active_power)
# plot3|
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  ylab = "Global Active Power (kilowatts)",
  xlab = "",
  type = "n"
)
lines(power_data$DateTime, power_data$Global_active_power)
Sys.setlocale("LC_TIME", lc)