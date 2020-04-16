# Reference: Steph Locke, Data Manipulation in R
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# Learning goals: 
# 1. Filtering columns
# 2. Filtering rows

# 1. select----
iris %>% select(Species, Sepal.Length)

iris %>% select(-Species)

#
iris %>% select(Sepal.Length:Petal.Length)

iris %>% select(-(Sepal.Length:Petal.Length))

#
iris %>% select(starts_with("S"))

iris %>% select(ends_with("s"))

#
iris %>% select(contains("Length"))
#
iris %>% select(Petal.Width:Species, -contains("Length"))

#
iris %>% select_if(is.numeric)

# what if we wanted only numeric columns with a high
# degree of variation? 
# Check if the column is numeric
# and if the number of unique values in the column is more than 30.
a <- c(1,2,3,3,3,4,5,5,6)
n_distinct(a)
# ~ means that we are writing a custom condition
iris %>% select_if(~is.numeric(.) & n_distinct(.) > 30)

is_v_unique_num <- as_mapper(
  ~is.numeric(.) & n_distinct(.)>30
)

is_v_unique_num(1:5)
is_v_unique_num(LETTERS)
is_v_unique_num(1:50)

# 2. slice ----
iris %>% slice(1:5)
#
iris %>% slice(-(1:floor(n()/3)))
#
iris %>% filter(Species=="virginica")
#
iris %>% filter(Species == "virginica", Sepal.Length > mean(Sepal.Length))
#

iris %>%
  filter(Species == "virginica" |
           Sepal.Length > mean(Sepal.Length))
# Return any row where a column’s value exceeds a specified value
iris %>%
  filter_all(any_vars(.>7.5))

# Find rows where any column’s value is more than two standard
# deviations away from the mean
iris %>% select(-Species) %>% 
  filter_all(any_vars(abs(. - mean(.))>2*sd(.)))

#
iris %>% select(-Species) %>% 
  filter_all(all_vars(. < mean(.)))
#
iris %>%
  filter_if(is.numeric, all_vars(.<mean(.)))
# 
iris %>%
  filter_if(~is.numeric(.) & n_distinct(.)>30,
            any_vars(.< mean(.)))



