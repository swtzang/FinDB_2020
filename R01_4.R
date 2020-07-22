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

# 4. explore package() ----
# Reference: 
# https://cran.r-project.org/web/packages/explore/vignettes/explore_mtcars.html
pacman::p_load(pacman)
p_load(explore)

explore_tbl(mtcars)
# describe(mtcars)
# explore(mtcars)
explore_all(mtcars)

# 
# Is there a difference between cars with 3,4 and 5 gears? #############
# proportion of cars with 3, 4 and 5 gears 
explore(mtcars, gear)

# Check relation between some of the variables and gear ########
p_load(tidyverse)

mtcars %>% 
  select(gear, mpg, hp, cyl, am) %>% 
  explore_all(target = gear)

# We see that 100% of cars with am = 0 (automatic) have 3 gears. 
# All cars with am = 1 (manual) have 5 gears.

# high MPG: define cars that have mpg (miles per gallon) > 25
data <- mtcars %>% 
  mutate(highmpg = if_else(mpg > 25, 1, 0, 0)) %>% 
  select(-mpg)

data %>% explore(highmpg)

# What else is special about them?
data %>% 
  select(highmpg, cyl, disp, hp) %>% 
  explore_all(target = highmpg)
#
data %>% 
  select(highmpg, drat, wt, qsec, vs) %>% 
  explore_all(target = highmpg)
#
data %>% 
  select(highmpg, am, gear, carb) %>% 
  explore_all(target = highmpg)

# create decision tree
data %>% 
  explain_tree(target = highmpg) %>% 
  .$obj
# 
# we have 6 highmpg out of 32 observations (18.75%)
# 7 cars are identified as highmpg. 
# 1 car is being wrongly classied as highmpg.
# 6 cars are correctly classied as highmpg (0.8571)

# 
# https://bradleyboehmke.github.io/HOML/DT.html
# we use rpart()
p_load(rpart, rpart.plot)
#
cart.model<- rpart(highmpg ~. , 
                   data = data, 
                   method = "anova")
cart.model

#
prp(cart.model,         # model
    faclen = 0,           # no abbrev. for variables
    fallen.leaves = TRUE, # vertical leaves
    shadow.col = "gray",  # shadow
    # number of correct classifications / number of observations in that node
    extra=1)  


