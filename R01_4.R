# 1. summary() ----

# INSTALL AND LOAD PACKAGES ################################

library(datasets)  # Load/unload base packages manually

# LOAD DATA ################################################

head(iris)

# SUMMARY() ################################################

summary(iris$Species)       # Categorical variable
summary(iris$Sepal.Length)  # Quantitative variable
summary(iris)               # Entire data frame

# 2. describe()----

# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")

# Use pacman to load add-on packages as desired
pacman::p_load(pacman, psych)
library(pacman, psych)

# LOAD DATA ################################################

head(iris)

# PSYCH PACKAGE ############################################

# Get info on package
# p_help(psych)           # Opens package PDF in browser
p_help(psych, web = F)  # Opens help in R Viewer

# DESCRIBE() ###############################################

# For quantitative variables only.

describe(iris$Sepal.Length)  # One quantitative variable
describe(iris)               # Entire data frame


hist(iris$Petal.Length)
summary(iris$Petal.Length)

summary(iris$Species)  # Get names and n for each species


# 3.Select by category ----

# Versicolor
hist(iris$Petal.Length[iris$Species == "versicolor"],
     main = "Petal Length: Versicolor")

# Virginica
hist(iris$Petal.Length[iris$Species == "virginica"],
     main = "Petal Length: Virginica")

# Setosa
hist(iris$Petal.Length[iris$Species == "setosa"],
     main = "Petal Length: Setosa")

# SELECT BY VALUE ##########################################

# Short petals only (all Setosa)
hist(iris$Petal.Length[iris$Petal.Length < 2],
     main = "Petal Length < 2")

# MULTIPLE SELECTORS #######################################

# Short Virginica petals only
hist(iris$Petal.Length[iris$Species == "virginica" & 
                         iris$Petal.Length < 5.5],
     main = "Petal Length: Short Virginica")

# CREATE SUBSAMPLE #########################################

# Format: data[rows, columns]
# Leave rows or columns blank to select all
i.setosa <- iris[iris$Species == "setosa", ]

# EXPLORE SUBSAMPLE ########################################

head(i.setosa)
summary(i.setosa$Petal.Length)
hist(i.setosa$Petal.Length)

