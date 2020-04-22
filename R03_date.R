# Reference: Steph Locke, Data Manipulation in R
# https://data-flair.training/blogs/descriptive-statistics-in-r/
# https://bookdown.org/content/2880/module-1-introduction-to-r.html
# Sharon Machlis, Practical R in Mass Communication and Journalism
# https://github.com/smach/R4JournalismBook
# Learning goals: 
# 1. Working with dates and times


library(pacman)
p_load(lubridate)
#
ymd_hms(c("20110604110101",
          "2011-06-04 11:01:01",
          "2011/06/04/11/01/01",
          "2011 june 4th, 11:01:01",
          "2011%06%04%11%01%01",
          "04/06/2011 11:01:01",
          "2011-06-04 11:01:01 PDT",
          "2011-06-04 11:01:00+1400"))
#
myDate <- ymd_hms("20110604110101")
myDate
#
date(myDate)
date(myDate) <- "2012-05-01"
myDate
#
year(myDate)
year(myDate) <- year(Sys.Date())
myDate
#
month(myDate)
month(myDate) <- month(Sys.Date())
myDate
#
yday(myDate)
mday(myDate)
wday(myDate)
wday(myDate, label = TRUE, abbr=TRUE)


























