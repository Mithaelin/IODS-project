# 05.12.23
# Sila Arsin
# Data Wrangling - Assignment 6 - Week 6

# Load necessary packages
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
# We start with loading the data given by the assignment to R; These are BPRS and RATS:

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T) 

RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# Let's have a look at these datasets:

summary(BPRS)
dim(BPRS) # 41 observations and 1 variable
str(BPRS)

summary(RATS)
dim(RATS) # 16 observations 13 variables
str(RATS)

# Check variable names
names(BPRS)
names(RATS)

# View data contents
head(BPRS)
head(RATS)

# Identify and convert categorical variables to factors in both datasets
# In BPRS these are treatment and subject and in RATS these are ID and Group.

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor variables ID and Group
RATS$ID = factor(RATS$ID)
RATS$Group = factor(RATS$Group)
RATS

# Now we convert the data sets to long form. Add a week variable to BPRS and a Time variable to RATS. 
# BPRS:
BPRS
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
BPRSL

# RATS:
RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)
RATS
RATSL

#This way the tables' measurements are turned from the column to row format which makes it easier to group these data in their number of rows. 
#This allows for easier modelling and grouping for multiple measurements per individual and works better for certain tools such as ggplot.
#Long-form data is often more suitable for statistical modeling, especially when analyzing repeated measures or multilevel structures (e.g., hierarchical models).
