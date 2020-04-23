# Reference: Steph Locke, Data Manipulation in R
# https://data-flair.training/blogs/descriptive-statistics-in-r/
# https://bookdown.org/content/2880/module-1-introduction-to-r.html
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# https://zhuanlan.zhihu.com/p/34410229
# Learning goals: 
# 1. Summarise: summarise, summarise_all, summarise_if, summarise_at
# 2. group_by: group_by_all, group_by_if, group_by_at
# 3. ungroup


library(pacman)
p_load(lubridate)

# Summarise ----
iris %>% summarise

iris %>% 
  summarise(mean(Sepal.Width), mean(Sepal.Length))
#
iris %>%
  summarise(Mean.Sepal.Width=mean(Sepal.Width),
            Mean.Sepal.Length=mean(Sepal.Length))
#
iris %>%
  summarise(n = n(), unique = n_distinct(Species),
            first = first(Species), last = last(Species),
            `51st` = nth(Species, 51))
#
iris %>%
  summarise_all(n_distinct)

#
iris %>%
  summarise_if(is.numeric, mean)

#
iris %>%
  summarise_at(vars(Sepal.Length:Petal.Length), mean)

# Summarising by groups ----
iris %>%
  group_by(Species) %>%
  summarise(Avg.Sepal.Length=mean(Sepal.Length))

# 
iris %>%
  group_by(Species) %>%
  mutate(Avg.Sepal.Length=mean(Sepal.Length))

#
iris %>%
  group_by(Species) %>%
  slice(1)

#
iris %>%
  group_by(Species) %>%
  arrange(desc(Sepal.Length)) %>% 
  ungroup

#
iris %>%
  group_by(Species) %>%
  mutate(SpeciesN=n()) %>%
  ungroup() %>%
  head()

# 
#iris %>%
#  group_by(Species) %>%
#  mutate(SpeciesN=n()) %>%
#  group_by(Sepal.Length) %>%
#  mutate(Sepal.LengthN=n())

# find out duplicates in a dataset
test <- iris %>%
  group_by_all() %>%
  summarise(nrows=n())
  

#
test1 <- iris %>%
  group_by_if(~n_distinct(.)<30) %>%
  summarise(n())

sum(test1$`n()`)
#
iris %>%
  group_by_at(vars(starts_with("Sp"))) %>%
  summarise(n())


# Practice
# Q1. Find the min and max values for length in movies
library(ggplot2movies)
movies %>% 
  summarise(min = min(length), max = max(length))

# Q2. In a pipeline, find out what proportion of films are Action
# movies, Action Comedies, Comedies, and neither Action or Comedy
data(movies)

movies %>% 
  group_by(Action, Comedy) %>% 
  summarise(n = n()) %>% 
  mutate(prop = n / sum(n))


# Q3. Get the range for each numeric variable in
# movies. Hint: Range outputs two values so you need to
# make a custom function that will concatenate the outputs of range
movies %>%
  summarise_if(is.numeric,
               ~paste(range(., na.rm=TRUE),
                      collapse = "-"))
#
range
x <- c(NA, 1:3, -1:1/0); 
x
range(x)
r <- range(x, na.rm = TRUE)
r
paste(r, collapse = "-")



