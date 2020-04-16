# Reference: Steph Locke, Data Manipulation in R
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# Learning goals: 
# 1. Working with column names
# 2. Working with row names
# 3. Rearrange your data
# 4. Changing the data


# 1. rename columnames ----
iris %>%
  select(sepal_width=Sepal.Width, species=Species)


iris %>%
  rename(sepal_width=Sepal.Width, species=Species)


iris %>%
  select_all(str_to_lower)


iris %>%
  rename_if(is.numeric, str_to_lower)

iris %>%
  rename_at(vars(starts_with("S")), str_to_lower)

# 2. rename rownames ----

mtcars

mtcars %>%
  rownames_to_column("car")


# 3. Rearrange your data ----
# sorting all of the data from left to right
iris %>%
  arrange_all()

#
iris %>%
  arrange(desc(Species), Sepal.Length)
#
iris %>%
  arrange_at(vars(Species, starts_with("P")), desc)

# reordering columns
iris %>%
  select(starts_with("P"), everything())

# 4. Changing the data----

iris %>%
  mutate(Sepal.Area = Sepal.Width * Sepal.Length)

iris %>%
  mutate(Sepal.Area = Sepal.Width * Sepal.Length,
         Avg.Sepal.Area = mean(Sepal.Area))

iris %>%
  mutate(Sepal.Width=Sepal.Width*.9)

# To delete a column, you can either assign NULL
# to a column in a mutate() statement 
iris %>%
  mutate(Sepal.Length=NULL)
#
iris %>%
  mutate(Sepal.Area = Sepal.Width * Sepal.Length,
         Avg.Sepal.Area = mean(Sepal.Area),
         Sepal.Width=Sepal.Width*.9,
         Sepal.Length=NULL)

# Some useful functions
iris %>%
  mutate(id=row_number())
#
iris %>%
  mutate(prev = lag(Sepal.Length),
         future = lead(Sepal.Length))

#
iris %>%
  mutate(size = case_when(
    Sepal.Length < mean(Sepal.Length) ~ "s",
    Sepal.Length > mean(Sepal.Length) ~ "l",
    TRUE ~ "m"
  ))

#
iris %>%
  mutate(Species = case_when(
    Species == "setosa" ~ toupper(Species),
    TRUE ~ as.character(Species)
  ))
#
iris %>%
  mutate(runagg=cumall(Sepal.Length < mean(Sepal.Length)))

# Occasionally, you might want to
# return only the columns you want to change. In such a situation,
# swap the word mutate for transmute.
iris %>%
  transmute(Sepal.Width=floor(Sepal.Width),
            Species = case_when(
              Species == "setosa" ~ toupper(Species),
              TRUE ~ as.character(Species)
            ))


#
iris %>%
  mutate_all(as.character)
#
iris %>%
  mutate_if(is.numeric, ~ . + rnorm(.))
#
iris %>%
  mutate_at(vars(Sepal.Width:Petal.Width), ~ . + rnorm(.))







