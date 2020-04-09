# 1. Barchart ----

# LOAD DATASETS PACKAGES ####
rm(list = ls())

library(datasets)

# LOAD DATA ################################################

?mtcars
head(mtcars)

# BAR CHARTS ###############################################

barplot(mtcars$cyl)             # Doesn't work

# Need a table with frequencies for each category
cylinders <- table(mtcars$cyl)  # Create table
cylinders
barplot(cylinders)              # Bar chart
plot(cylinders)                 # Default X-Y plot (lines)

# CLEAN UP #################################################

# 2. Histograms ----
# LOAD DATA ################################################

?iris
head(iris)

# BASIC HISTOGRAMS #########################################

hist(iris$Sepal.Length)
hist(iris$Sepal.Width)
hist(iris$Petal.Length)
hist(iris$Petal.Width)

# HISTOGRAM BY GROUP #######################################

# Put graphs in 3 rows and 1 column
par(mfrow = c(3, 1))

# Histograms for each species using options
hist(iris$Petal.Width[iris$Species == "setosa"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Setosa",
     xlab = "",
     col = "red")

hist(iris$Petal.Width [iris$Species == "versicolor"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Versicolor",
     xlab = "",
     col = "purple")

hist(iris$Petal.Width [iris$Species == "virginica"],
     xlim = c(0, 3),
     breaks = 9,
     main = "Petal Width for Virginica",
     xlab = "",
     col = "blue")

# Restore graphic parameter
par(mfrow=c(1, 1))

# 3. Scatterplot ----
# LOAD DATA ################################################

?mtcars
head(mtcars)

# PLOTS ####################################################

# Good to first check univariate distributions
hist(mtcars$wt)
hist(mtcars$mpg)

# Basic X-Y plot for two quantitative variables
plot(mtcars$wt, mtcars$mpg)

# Add some options
plot(mtcars$wt, mtcars$mpg,
     pch = 19,         # Solid circle
     cex = 1.5,        # Make 150% size
     col = "#cc0000",  # Red
     main = "MPG as a Function of Weight of Cars",
     xlab = "Weight (in 1000 pounds)",
     ylab = "MPG")


# LOAD DATA ################################################

# 4. Overlaying plots ----

# Annual Canadian Lynx trappings 1821-1934
?lynx
head(lynx)

# HISTOGRAM ################################################

# Default
hist(lynx)

# Add some options
hist(lynx,
     breaks = 14,          # "Suggests" 14 bins
     freq   = FALSE,       # Axis shows density, not freq.
     col    = "thistle1",  # Color for histogram
     main   = paste("Histogram of Annual Canadian Lynx",
                    "Trappings, 1821-1934"),
     xlab   = "Number of Lynx Trapped")

# Add a normal distribution
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)),
      col = "thistle4",  # Color of curve
      lwd = 2,           # Line width of 2 pixels
      add = TRUE)        # Superimpose on previous graph

# Add two kernel density estimators
lines(density(lynx), col = "blue", lwd = 2)
lines(density(lynx, adjust = 3), col = "purple", lwd = 2)

# Add a rug plot
rug(lynx, lwd = 2, col = "gray")






