# 20/11/23

# SILA ARSIN - Assignment-3 

# Assignment-3: Data wrangling Exercise

# 1. For this exercise we will be working with the Student performance data regarding alcohol consumption: "https://www.archive.ics.uci.edu/dataset/320/student+performance"

# 2. From this data set we obtained two .csv files mat and por which we will be working with so first we downloaded them and now we read them into this script as follows:
mat <- read.table("Data/student-mat.csv", sep = ";", header= T)
por <- read.table("Data/student-por.csv", sep = ";", header= T)

# 3. We have a look at the dimenstions and the structure of each dataset:

dim(mat)
dim(por)

str(mat)
str(por)

# 4. Now we join the two data sets using all other variables than "failures, paid, absences, G1, G2, G3" as identifiers. We keep only students in both datasets.

# We will be using dplyr so we first load that.

library(dplyr)

free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

join_cols <- setdiff(colnames(por), free_cols)

mat_por <- inner_join(mat, por, by = join_cols, suffix = c(".mat", ".por"))

dim(mat_por)
str(mat_por)

# 5 now we should remove duplicated records

for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(mat_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}

# 6. Alcohol consumption average bar-plot for high-use where alc-use is > 2

library(dplyr); library(ggplot2)

# Taking average use of weekday alcohol and weekend alcohol
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Plot set up for alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use)) +
  geom_bar()

# define the plot as a bar plot and draw it
g1 <-( g1 + aes(fill = sex))

# define a new logical column 'high_use' over 2
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = high_use)) + geom_bar()

# draw a bar plot of high_use by sex
g2 + facet_wrap("sex")

# now we take a look at the joined data with glimpse()

glimpse(mat_por)

# indeed there are 370 observations

# save the new table to data folder

write.csv(mat_por, file = "Data/mat_por.csv", row.names= T)
