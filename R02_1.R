# Reference: Steph Locke, Data Manipulation in R
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# Learning goals: 
# 1. install packages
# 2. import excel files
install.packages(c("tidyverse","ggplot2movies",
                   "nycflights13","odbc",
                   "writexl", "openxlsx",
                   "gapminder", "usethis"))

library(tidyverse)
library(nycflights13)
library(openxlsx)
library(gapminder)
library(ggplot2movies)
library(writexl)

#
library(pacman)
p_load(usethis, tidyverse, nycflights13, openxlsx, gapminder, ggplot2movies, writexl)
#


iris2 <- read_csv("iris.csv")
head(iris2)
#
iris2<-read_csv("iris.csv",
                col_names = c("sepal_length","sepal_width",
                              "petal_length","petal_width",
                              "species"),
                skip=1)
#
library(readxl)
iris2 <- read_excel("iris.xlsx")
#
iris2 <- read_excel("iris.xlsx",
                    col_names = c("sepal_length","sepal_width",
                                  "petal_length","petal_width",
                                  "species"),
                    skip=1)
#========================================
#The simple syntax for using purrr map functions is: map(mydata, myfunction, anyAdditionalArguments).
#This says “For each item in mydata, apply the function myfunction, using any additional function arguments
#I’ve speciﬁed.”
#========================================
getwd()
# you can set working directory back to default
# setwd("..")
setwd("sandydata")
# Data explanations from
# https://www.transtats.bts.gov/Fields.asp?table_id=236
sandyfiles <- list.files()
# method 1
sandydf <- map_df(sandyfiles, rio::import)
# or you can use:
sandydf.1 <- map_df(list.files(pattern="*.csv"), read_csv)
# method 2
sandydf <- list.files() %>%
  map_df(rio::import)
# method 3
# lapply(mylist, myfunction)
sandydata <- lapply(sandyfiles, rio::import)
sandydf2 <- bind_rows(sandydata)
# 
sandydf2 <- lapply(sandyfiles, rio::import) %>%
            bind_rows()
#
identical(sandydf, sandydf2)
