# Reference: Steph Locke, Data Manipulation in R
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# Learning goals: 
# 1. Data pipelines
# 2. How to pipe? The use of dot "."

# One assign at a time
is_setosa <- iris$Species=="setosa"
setosa <- iris[is_setosa, ]
setosa_area <- setosa$Sepal.Length * setosa$Sepal.Width
avg_area <- mean(setosa_area)

# The all-in-one
avg_area <- mean(iris$Sepal.Length[iris$Species=="setosa"]*
                   iris$Sepal.Width[iris$Species=="setosa"])
# %>% 
# ctl+shift+M
# <- 
# alt+- 
library(magrittr)
#
letters %>% toupper() %>% length()
#
iris %>% head() %>% nrow()
#
iris_filtered <- iris %>% head()
iris_filtered
#
iris %>% head() -> iris_filtered3
iris_filtered3

# Jumbled functions
# Sometimes functions that we encounter do not put the key input
# as the first argument. 
letterz <- sub("s","z", letters)
letterz
#
my_lm <- lm(Sepal.Width~Sepal.Length, iris)
#
letters %>% sub("s","z", .) -> letterz
letterz

# 
iris %>% lm(Sepal.Width~Sepal.Length, .) -> my_lm


