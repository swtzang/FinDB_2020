# Reference: Steph Locke, Data Manipulation in R
# https://data-flair.training/blogs/descriptive-statistics-in-r/
# https://bookdown.org/content/2880/module-1-introduction-to-r.html
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# https://zhuanlan.zhihu.com/p/34410229
# Learning goals: 
# 1. reshaping data

p_load(tidyverse)
#
data(mtcars)
mtcars %>%
  rownames_to_column("car") ->
  mtcars2
#
mtcars2 %>%
  gather(measure, value, -car)

#
mtcars2 %>%
  gather(measure, value, -car) %>%
  group_by(measure) %>%
  mutate(diff= value-mean(value))
#
mtcars2 %>%
  gather(measure, value, -car, factor_key = TRUE) 

# To spread() data we need to say which column will
# become our column names and which values will go into our cells.

mtcars2 %>%
  group_by(cyl, am) %>%
  summarise(avg = mean(mpg)) %>%
  spread(am, avg)
#
mtcars2 %>%
  group_by(cyl, am) %>%
  summarise(avg=round(mean(mpg),1)) %>%
  spread(am, avg)
# 
mtcars2 %>%
  group_by(cyl, am) %>%
  summarise(avg=round(mean(mpg),1)) %>%
  spread(am, avg, sep=":")

# Practice
# Make a table showing country population as a percentage of
# global population by year using the population dataset
# 1. Calculate the percentage of the worlds population by year for each country
# 2. Format the percentage
# 3. Excluding columns as required, pivot the data
data(population)

population %>%
  group_by(year) %>%
  mutate(prop=scales::percent(
    population / sum(as.numeric(population),
                     na.rm=TRUE))) %>%
  select(year, country, prop) %>%
  spread(year, prop)


















