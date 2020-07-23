# Data processing
# 1. split() ----
# split() divides the data in the vector x into the groups defined by f. 
# The replacement forms replace values corresponding to such a division. 
# unsplit reverses the effect of split.
p_load(datasets)
data <- mtcars
data
#
gr.mtcars <- split(mtcars,mtcars$cyl)
gr.mtcars
#
gr.mpg <- split(mtcars$mpg,mtcars$cyl)
gr.mpg
# split and compute ####
lapply(gr.mpg, mean)
# sapply() to make output shorter ####
sapply(gr.mpg, mean)
#
gr.state1 <- split(state.x77, state.region)
gr.state1

# 2. subset() ----
data <- iris
subset(data, Sepal.Length > 5)

subset(data, Sepal.Length == 5,select = c("Sepal.Length","Species"))

# 3. rbind(), cbind(), merge()----
# rbind() ####
ID <- c(1,2,3,4)
Name <- c("A","B","C","D")
Student1 <- data.frame(ID,Name)

ID <- c(5,6,7,8)
Name <- c("E","F","G","H")
Student2 <- data.frame(ID,Name)

rbind(Student1,Student2)

# cbind() ####
ID <- c(1,2,3,4)
Name <- c("A","B","C","D")

Score <- c(60,70,80,90)
Sex <- c("M","F","M","M")

Student1 <- data.frame(ID,Name)
Student2 <- data.frame(Score,Sex)

cbind(Student1,Student2)

# merge() ####
df1 <- data.frame(CustomerId = c(1:5), Product = c(rep("Toaster", 3), rep("Radio", 2)))
df2 <- data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))
# Inner join ####
merge(x = df1, y = df2, by = "CustomerId")

# Full join ####
merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

# Left join: join by keeping x "CustomerId" ####
merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)

# Right join: join by keepig y "CustomerId" ####
merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)

# 4. Impute missing value ----

tmp <- c(1,5,8,NA,5,NA,6)
is.na(tmp)
sum(is.na(tmp))

# generate random missing values
p_load(missForest)

data <- prodNA(iris, noNA = 0.1)
head(data)

# method 1: delete missing rows ####
complete.cases(data)
rm.data <- data[complete.cases(data), ]

# method 2: use mean, 1st-quartile value to fill the missing value ####
mean.data <- data

mean.1 <- mean(mean.data[, 1], na.rm = T)  
na.rows <- is.na(mean.data[, 1])           

#
mean.data[na.rows, 1] <- mean.1

# method 3: K-nearest neighbours ####

p_load(DMwR)
imputeData <- knnImputation(data)
head(imputeData)

# method 4: use mice package ####
p_load(mice)
mice.data <- mice(data,
                  m = 3,           # generate 3 filled data tables
                  maxit = 50,      # max iteration
                  method = "cart", # use cart decision trees
                  seed = 188)

complete(mice.data, 1) # 1st data
complete(mice.data, 2) # 2nd data
complete(mice.data, 3) # 3rd data



