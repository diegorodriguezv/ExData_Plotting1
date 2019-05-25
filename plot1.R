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

# plot1
png(filename = "plot1.png")
hist(
  power_data$Global_active_power,
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)",
  col = "red"
)
dev.off()