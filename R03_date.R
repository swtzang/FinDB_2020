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
date(myDate) <- "2020-05-14"
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

# 2.
# https://medium.com/@suipichen/%E4%B8%80%E5%A4%A9%E4%B8%80%E9%BB%9Er-2-%E6%99%82%E9%96%93%E8%B3%87%E6%96%99%E5%89%8D%E8%99%95%E7%90%86-2-543d312650a8
# Date存年、月、日、星期等信息;然而POSIX類別則可以儲存年、月、日、時、分、秒、時區、星期等訊息。
# POSIXct, POSIXlt 是R系統中DataTimeClasses兩個物件
#1. POSIXct代表的是總秒數從1970/1/1開始算起(R裡面的epoch)
#2. POSIXlt則是一個列表，裡面有跟時間相關的數值（秒、分、時、日、月、年等）
class(Sys.time())

# (1)當你資料原本就是時間資料格式，透過format這個函數，就可以根據自己的需求，
# 輸出特定格式的時間資料。
format(Sys.time(), "%Y-%m-%d")
# (2)如果你的資料格式是字串，則要使用as.POSIXct，as.POSIXlt與設定參數format
# 就可以轉換成特定的資料格式
a=as.POSIXct("2014-05-01", format="%Y-%m-%d")
b=as.POSIXlt("2014-05-01", format="%Y-%m-%d")
a
b
#
dates17 <- date(c("2017-02-01", "2017-02-02", "2017-02-03",
                  "2017-01-27", "2017-01-30", "2017-01-31"))
INTC <- c(36.52, 36.68, 36.52, 
          37.98, 37.42, 36.82)
GSPC <- c(2279.55, 2280.85, 2297.42, 
          2294.69, 2280.90, 2278.87)
datadf <- data.frame(INTC, GSPC)
rownames(datadf) <- dates17
datadf
class(datadf)
#
dataxts <- xts(datadf, dates17)
dataxts
class(dataxts)
#
library(xts)













