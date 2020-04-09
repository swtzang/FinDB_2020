# Reference: Data wrangling with R
# Bradley C. Boehmke
# https://github.com/bradleyboehmke/dw-r
# Charater string ----
rm(list=ls())
#
a <- "learning to create" # create string a
b <- "character strings" # create string b 

#
# Paste together string a & b ####
paste(a, b)

paste("The life of", pi)

# paste multiple strings with a separating character
paste("I" , "love", "R", sep = "-")

# use paste0() to paste without spaces btwn characters
paste0( "I", "love", "R")

# paste objects with different lengths
paste("R" , 1:5, sep = "v1.")

# 
a <- "The life of"
b <- pi
is.character(a)
is.character(b)

# Print Strings ----

# print(): generic printing
# noquote(): print with no quotes
# cat(): concatenate and print with no quotes
# sprintf(): a wrapper for the C function sprintf, that returns a character vector containing
#            formatted combination of text and variable values

x <- "learning to print strings"
# basic printing
print(x)

# print without quotes
print(x, quote = FALSE)

# basic printing (similar to noquote)
cat(x)

# combining character strings
cat(x, "in R" )

#
x <- "print strings"

# sprintf ----
# substitute a single string/variable
sprintf( "Learning to %s in R", x)

# substitute multiple strings/variables
y <- "in R"
sprintf( "Learning to %s %s", x, y)
#
version <- 3
# substitute integer
sprintf("This is R version:%d", version)

# print with leading spaces
sprintf("This is R version:%4d", version)


# can also lead with zeros
sprintf("This is R version:%04d", version)

sprintf("%f", pi)
# '%f' indicates 'fixed point' decimal notation
## [1] "3.141593"

sprintf( "%.3f", pi)
# decimal notation with 3 decimal digits
## [1] "3.142"

sprintf( "%1.0f", pi)
# 1 integer and 0 decimal digits
## [1] "3"









