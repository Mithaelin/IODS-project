# 23/11/23
# Sila Arsin
# Week 4 - Assignment 4 - Data Wrangling Exercise

# Read in the “Human development” and “Gender inequality” data sets as follows:
library(readr)
library(dplyr)

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Let's look how these datasets look like:

str(hd)
str(gii)
dim(hd)
dim(gii)

summary(hd)
summary(gii)


# Renaming the columns to make shorter:
colnames(gii)
colnames(gii) <- c("GII Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")
summary(gii)

# Calculate the ratio of female and male populations with secondary education:

gii <- gii %>%
  mutate(Secondary_Edu_Ratio = `Edu2.F`/`Edu2.M`)

# Calculate the ratio of labor force participation of females and males:

gii <- gii %>%
  mutate(Labor_Force_Ratio = `Labo.F`/`Labo.M`)

# Let's check if this is done right:
summary(gii) # yes!

# Joining datasets hd and gii using coundtry variable from the:
# Inner join based on the 'Country' variable

human <- inner_join(gii, hd, by = "Country")

# Save the joined data as a CSV file in the Data folder

write.csv(human, file = "Data/human.csv", row.names = FALSE)
