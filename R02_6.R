# Reference: Steph Locke, Data Manipulation in R
# https://data-flair.training/blogs/descriptive-statistics-in-r/
# https://bookdown.org/content/2880/module-1-introduction-to-r.html
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# https://zhuanlan.zhihu.com/p/34410229
# Learning goals: 
# 1. Join: inner join, left join, full join
# 2. bind_cols, bind_rows


irisLk <- data.frame(
  species=c("setosa","virginica","VERSICOLOR"),
  colour=c("Red","Blue","Green"))

irisLk
#
iris %>%
  left_join(irisLk)

# The value on the LHS is the column name from our first table, and
# the value on the RHS is the column name from the table we’re
# joining to our first table.
iris %>%
  left_join(irisLk, c("Species"="species") )

#
iris %>%
  mutate(dummycol=1) %>%
  full_join({
    irisLk %>%
      mutate(dummycol=1)
  }, by="dummycol") %>%
  select(-dummycol)

#
iris %>%
  left_join(irisLk, c("Species"="species"))

#
iris %>%
  inner_join(irisLk, c("Species"="species"))

#
iris %>%
  full_join(irisLk, c("Species"="species"))

# An anti-join filters out cases where there’s a match in our join
# criteria. This doesn’t add extra columns so we only have 5 columns,
# and it filters out the “setosa” and “virginica” rows leaving us with 50 rows.
iris %>%
  anti_join(irisLk, c("Species"="species"))

# Join by position
iris[,1:3] %>%
  bind_cols(iris[,4:5])

#
iris1 <- iris[1:50, 1:4]
iris2 <- iris[51:100, 2:5]
iris3 <- iris[101:150, 2:3]
#
to_merge <- list(iris1, iris2, iris3)
to_merge %>%
  bind_rows() %>%
  nrow()

# Practice
# Q1: Create a summary of the movies data by year that says how
# many movies were released each year and the average duration
movies %>%
  group_by(year) %>%
  summarise(n = n(), avg_length=mean(length)) ->
  movies_sum


# Q2. Add this summary data to the movies table
movies %>%
  inner_join(movies_sum)

# Q3. Create a subset of the movies table that has any film over 300
# minutes long, use a join to get everything but those records
movies %>%
  filter(length >= 300) ->
  long_movies

movies %>%
  anti_join(long_movies)

# Q4. If you didn’t do this in an earlier chapter, use sample_n() to
# take a thousand records from movies, write the data to CSV
# with a file name that contains the current time. Rerun the
# code multiple times to generate some CSVs. Read any CSVs
# into a combined dataset called moviessample

movies %>%
  sample_n(1000) %>%
  readr::write_csv(.,
                   paste0("movies",
                          format(now(), "%Y%m%d%H%M%S"),
                          ".csv"))
#
moviessample <- list.files(pattern = "movies") %>%
                map_df(read_csv) 
#
str(moviessample)




