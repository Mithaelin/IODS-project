# 01/12/23
# Sila Arsin
# Week 5 - Assignment 5 - Data Wrangling Exercise

#We continue from where we left in week 4 for this data wrangling exercise. The 'human' dataset originates from the United Nations Development Programme. 
# The data page https://hdr.undp.org/data-center/human-development-index#/indicies/HDI. 

#Most of the variable names in the data have been shortened and two new variables have been computed as shown below last week.
#See the meta file:https://github.com/KimmoVehkalahti/Helsinki-Open-Data-Science/blob/master/datasets/human_meta.txt for the modified data here for descriptions of the variables.

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

colnames(hd) <- c('HDI.Rank','Country','HDI','Life.Exp','Edu.Exp', 'Edu.Mean', 'GNI', 'GNI.Minus.Rank') #rename columns
summary(hd)
# Calculate the ratio of female and male populations with secondary education:

gii <- gii %>%
  mutate(Edu2.FM = `Edu2.F`/`Edu2.M`)

# Calculate the ratio of labor force participation of females and males:

gii <- gii %>%
  mutate(Labo.FM = `Labo.F`/`Labo.M`)

# Let's check if this is done right:
summary(gii) # yes!
gii
# Joining datasets hd and gii using coundtry variable from the:
# Inner join based on the 'Country' variable

humanw4 <- inner_join(gii, hd, by = "Country")
humanw4

# Save the joined data as a CSV file in the Data folder

write.csv(humanw4, file = "Data/humanw4.csv", row.names = FALSE)

# Week 5 - Continuing from previous work - Dimensions and and structure:
str(humanw4)
dim(humanw4) # 195 observations and 19 variables

# we need to keep only the columns matching the following variable names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F" 
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
humanw5<- select(humanw4, all_of(keep))
dim(humanw5)

#We should remove all columns with missing values:
humanw5 <- filter(humanw5, complete.cases(humanw5))

dim(humanw5) #now we got 162 obs and 9 variables.

# We should remove observations relating to regions.

tail(humanw5) # last 6 rows are regions so they have to go 

last <- nrow(humanw5) - 7
humanw5 <- humanw5[1:last, ]

dim(humanw5) #now we have 155 obs and 9 variables

write.csv(humanw5, file = "Data/humanw5.csv", row.names = FALSE)
