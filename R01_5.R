# 1. Data formats ----

# DATA TYPES ###############################################

# Numeric

n1 <- 15  # Double precision by default
n1
typeof(n1)

n2 <- 1.5
n2
typeof(n2)

# Character

c1 <- "c"
c1
typeof(c1)

c2 <- "a string of text"
c2
typeof(c2)

# Logical

l1 <- TRUE
l1
typeof(l1)

l2 <- F
l2
typeof(l2)

int <- c(1L, 2L)
int
typeof(int)


# DATA STRUCTURES ##########################################

## Vector ##################################################

v1 <- c(1, 2, 3, 4, 5)
v1
is.vector(v1)

v2 <- c("a", "b", "c")
v2
is.vector(v2)

v3 <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
v3
is.vector(v3)

## Matrix ##################################################

m1 <- matrix(c(T, T, F, F, T, F), nrow = 2, byrow = T)
m1

m2 <- matrix(c("a", "b", 
               "c", "d"), 
             nrow = 2,
             byrow = T)
m2

## Array ###################################################

# Give data, then dimemensions (rows, columns, tables)
a1 <- array(c(1:24), c(4, 3, 2))
a1

## Data frame ##############################################

# Can combine vectors of the same length

vNumeric   <- c(1, 2, 3)
vCharacter <- c("a", "b", "c")
vLogical   <- c(T, F, T)

dfa <- cbind(vNumeric, vCharacter, vLogical)
dfa  # Matrix of one data type

df <- as.data.frame(cbind(vNumeric, vCharacter, vLogical))
df  # Makes a data frame with three different data types

## List ####################################################

o1 <- c(1, 2, 3)
o2 <- c("a", "b", "c", "d")
o3 <- c(T, F, T, T, F)

list1 <- list(o1, o2, o3)
list1

list2 <- list(o1, o2, o3, list1)  # Lists within lists!
list2

# COERCING TYPES ###########################################

## Automatic coercion ######################################

# Goes to "least restrictive" data type

coerce1 <- c(1, "b", TRUE)
# coerce1  # Parenthese around command above make this moot
typeof(coerce1)

## Coerce numeric to integer ###############################

coerce2 <- 5
typeof(coerce2)

coerce3 <- as.integer(5)
typeof(coerce3)

## Coerce character to numeric #############################

coerce4 <- c("1", "2", "3")
typeof(coerce4)

coerce5 <- as.numeric(c("1", "2", "3"))
typeof(coerce5)

## Coerce matrix to data frame #############################

coerce6 <- matrix(1:9, nrow= 3)
is.matrix(coerce6)

coerce7 <- as.data.frame(matrix(1:9, nrow= 3))
is.data.frame(coerce7)


# 2. Factors ----
# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

# CREATE DATA ##############################################

x1 <- 1:3
y  <- 1:9

# Combine variables
df1 <- cbind.data.frame(x1, y)
typeof(df1$x1)
str(df1)

# AS.FACTOR ################################################

x2  <- as.factor(c(1:3))
df2 <- cbind.data.frame(x2, y)
typeof(df2$x2)
str(df2)

# DEFINE EXISTING VARIABLE AS FACTOR #######################

x3  <- c(1:3)
df3 <- cbind.data.frame(x3, y)
df3$x3 <- factor(df3$x3, levels = c(1, 2, 3))
typeof(df3$x3)
str(df3)

# LABELS FOR FACTOR ########################################

x4  <- c(1:3)
df4 <- cbind.data.frame(x4, y)
df4$x4 <- factor(df4$x4,
                 levels = c(1, 2, 3),
                 labels = c("macOS", "Windows", "Linux"))
df4
typeof(df4$x4)
str(df4)

# ORDERED FACTORS AND LABELS ###############################

x5  <- c(1:3)
df5 <- cbind.data.frame(x5, y)
df5$x5 <- ordered(df5$x5,
                   levels = c(3, 1, 2),
                   labels = c("No", "Maybe", "Yes"))
df5
typeof(df5$x5)
str(df5)

#
rm(list=ls())

# 3. Entering data ----

# COLON OPERATOR ###########################################

# Assigns number 0 through 10 to x1
x1 <- 0:10
x1

# Descending order
x2 <- 10:0
x2

# SEQ ######################################################

?seq  # R help on seq

# Ascending values (duplicates 1:10)
x3 <- seq(10)

# Specify change in values
x4 <- seq(30, 0, by = -3)
x4

# 
seq(0, 21, length.out = 15)

# ENTER MULTIPLE VALUES WITH C #############################

# c = concatenate (or combine or collect)
?c  # R help on c

x5 <- c(5, 4, 1, 6, 7, 2, 2, 3, 2, 8)
x5

# SCAN #####################################################

?scan  # R help on scan

x6 <- scan()  # After running this command, go to console
# Hit return after each number
# Hit return twice to stop
x6

# REP ######################################################

?rep  # R help on rep
x7 <- rep(TRUE, 5)
x7

# Repeats set
x8 <- rep(c(TRUE, FALSE), 5)
x8

# Repeats items in set
x9 <- rep(c(TRUE, FALSE), each = 5)
x9

#
rep(1:4, each = 2)

# 3.1 Generate random variables ----
n = 25
# Generate n random numbers between the default values of 0 and 1 ####
runif(n)

# Generate n random numbers between 0 and 25 ####

runif(n, min = 0, max = 25)

# generate n random numbers between 0 and 25 (with replacement) ####
sample(0:25, n, replace = TRUE)

# generate n random numbers between 0 and 25 (without replacement) ####
sample(0:25, n, replace = FALSE)

# RANDOM NUMBERS from NORMAL DISTRIBUTION ####
# generate n random numbers from a normal distribution with given mean & st. dev.
rnorm(n, mean = 0 , sd = 1 )
# generate CDF probabilities for value(s) in vector q
pnorm(q , mean = 0 , sd = 1 )
# generate quantile for probabilities in vector p
qnorm(p, mean = 0 , sd = 1 )
# generate density function probabilites for value(s) in vector x
dnorm(x, mean = 0 , sd = 1 )

# Setting the seed for reproducible results ####
set.seed(1234)
rnorm(n = 10 , mean = 0, sd = 1 )

set.seed(1234)
rnorm(n = 10 , mean = 0, sd = 1 )


# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 


# 4. Importing data----
#
# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# Use pacman to load add-on packages as desired
pacman::p_load(pacman, rio) 

# ABOUT EXCEL FILES ########################################

# From the official R documentation
browseURL("http://j.mp/2aFZUrJ")

# You have been warned: ಠ_ಠ

# IMPORTING WITH RIO #######################################

# CSV
getwd()
#
setwd("~/git/FinDB_2020")

rio_csv <- import("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.csv")
head(rio_csv)
str(rio_csv)

# TXT
rio_txt <- import("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.txt")
head(rio_txt)

# Excel XLSX
rio_xlsx <- import("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.xlsx")
head(rio_xlsx)

# DATA VIEWER ##############################################

?View
View(rio_csv)

# READ.TABLE FOR TXT FILES #################################

# R's built-in function for text files (used by rio)

# TEXT FILES

# Load a spreadsheet that has been saved as tab-delimited
# text file. Need to give complete address to file. This
# command gives an error on missing data but works on
# complete data.
r_txt1 <- read.table("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.txt", header = TRUE)
r_txt1
# This works with missing data by specifying the separator: 
# \t is for tabs, sep = "," for commas. R converts missing
# to "NA"
r_txt2 <- read.table("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.txt", 
                     header = TRUE, 
                     sep = "\t")
r_txt2
# READ.CSV FOR CSV FILES ###################################

# R's built-in function for csv files (also used by rio)

# CSV FILES
# Don't have to specify delimiters for missing data
# because CSV means "comma separated values"
trends.csv <- read.csv("R01_Course_Files/R01_5_4_ImportingData_Datasets/mbb.csv", header = TRUE)
trends.csv
# CLEAN UP #################################################

# Clear environment
rm(list = ls()) 

