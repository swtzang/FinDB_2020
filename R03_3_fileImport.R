#======================================================
# Import data from .txt file
# # read monthly closing price for listed stock in TWSE
# TEJ choose listed stocks without TRD and F-stocks
# TEJ下載之資料要先另存為UTF-8才能讀入
#======================================================
m.price = read.table("./data/TWSE_1990_2017_m_close1.TXT")
m.price<-m.price[,-2]
colnames(m.price)<-c("id", "date", "close")
write.csv(m.price, "m_price.csv")
# use dcast to reorder dataframe by date;
# library(data.table)
library(reshape2)
mprice.reorder = dcast(m.price,date~id)
dim(mprice.reorder)
head(mprice.reorder)
mprice.reorder1 <- mprice.reorder[, 1:15]

# example
month <- "200003"
as.Date(as.yearmon(month, format = "%Y%m"))-1

# Create year-month-day date series
# method 1:
date <- as.Date(as.yearmon(as.character(mprice.reorder1$date), format = "%Y%m"))-1
head(date)
date <- c(date[-1], as.Date('2017-12-31'))
# method 2: 
date <- seq(as.Date("1990-02-01"), length=336, by="1 month") - 1
head(date)

# create xts object
mprice.reorder.xts <- xts(mprice.reorder1[,-1], order.by = date)
head(mprice.reorder.xts)
tail(mprice.reorder.xts)
dim(mprice.reorder.xts)

# compute monthly returns
mret <- diff(log(mprice.reorder.xts))
(mprice.reorder.xts[-1,] - lag(mprice.reorder.xts, k = 1))
# After checking the data, we find that 1203 has NAs from 200111 - 200206
# we need to fill NAs with values
t <- na.locf(mprice.reorder.xts)
mprice.reorder.xts <- na.locf(t, fromLast = TRUE)
mret <- diff(log(mprice.reorder.xts))
mret <- mret[-1,]
summary(mret)




