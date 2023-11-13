#SILA ARSIN - Assignment 2 11/11/23

#Assignment 2 Data wrangling
learning2014 <- read.table ("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-data.txt", sep = "\t", header = T)

# Dimensions of the learning2014 data frame, 
# there are 183 (row length) observations made  for 60 (number of columns) variables checked.:
dim(learning2014)

# Structure of the learning2014 data:
str(learning2014)
# Here we can check what this data frame sort of looks like, list of the variables and part of the observed data only as the file is too big tho show on console.

# Now we need to create a new dataset with gender, age, attitude, deep, stra, surf and points in the learning2014 data 
# and we scale to original scales with the mean while also excluding exam points where variable is zero.

# get dplyr library
library(dplyr)

NL2014<- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

my_clmns <- c( "gender", "Age", "attitude", "deep", "stra", "surf", "Points")

learning2014 <- select(NL2014, one_of(my_clmns))

#warning message here says there are unknown columns "Unknown columns: `attitude`, `deep`, `stra`, `surf` because these don't exist yet.

# we create the "attitude" column by taking the existing Attitude column and dividing by 10 and assigning those in the attitude column
NL2014$attitude <- NL2014$Attitude/ 10

NL2014$attitude
# similarly we have to create columns for deep, stra and surf - there are several columns existing for these so the data there has to be combined and "meaned" and that data will be 
# written into the new respective columns.

# Data for the deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Combine columns for  deep learning 
deep_columns <- select(NL2014, one_of(deep_questions))
deep_columns
# and create column 'deep' by averaging
NL2014$deep <- rowMeans(deep_columns)

# Combine columns for surface learning 
surface_columns <- select(NL2014, one_of(surface_questions))
# and create column 'surf' by averaging
NL2014$surf <- rowMeans(surface_columns)

# Combine columns for  strategic learning 
strategic_columns <- select(NL2014, one_of(strategic_questions))
# and create column 'stra' by averaging
NL2014$stra <- rowMeans(strategic_columns)

# Now we combine and change column names:
learning2014 <- NL2014[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

# We remove the rows with 0 points:
Lpoints <- filter(learning2014, Points > 0 )
learning2014 <- Lpoints

# We rename col names for consistency with the assignment 2

colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

# Now check:

learning2014
dim(learning2014)

# We get the values "166 observations and 7 variables" as required by the assignment 2!

# Set the directory from sessions to IODS Project folder. Save the dataset now int he folder using write_csv
library(tidyverse)

write.csv(learning2014, file= "learning2014.csv")

# check if this file can be read:
data <- read_csv("V:/Data Science/IODS-project/learning2014.csv")

# check the data written is correct:
head(data)
str(data)                 

#