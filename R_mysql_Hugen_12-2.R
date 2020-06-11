# Reference:
# Financial analytics with R, Mark J. Bennett and Dirk L. Hugen, Cambridge University Press.
rm(list = ls())
library(foreign)
#setwd(paste(homeuser,"/FinAnalytics/ChapXII",sep=""))
funda <- read.dta("funda.dta")
msf <- read.dta("msf.dta")
con <- dbConnect(SQLite(),":memory:")
# We write them using dbWriteTable() so that we can query them. 
dbWriteTable(con,"funda", funda, overwrite=TRUE)
#
dbWriteTable(con,"msf", msf, overwrite=TRUE)
#
dbListTables(con)
# let’s query the funda table for IBM’s total assets, at, and total liabilities, lt
query <- "SELECT tic, at, lt 
          FROM funda 
          WHERE fyear = 2010 
          AND tic ='IBM'"
result <- dbGetQuery(con,query)
result
# We can also calculate the market-to-book ratio M/B for IBM at the end of ﬁscal year 2010. 
# csho: common shares outstanding; prcc_c: price per share close annual calendar;
query<-"SELECT tic, prcc_c, csho, at-lt AS bv 
        FROM funda 
        WHERE fyear = 2010 
        AND tic ='IBM'"
result <- dbGetQuery(con,query)
result
#
#market-to-book (M/B) ratio:
result$prcc_c * result$csho / result$bv
# we can also carry out the market-to-book ratio calculation in the
# database via the AS keyword
query<-"SELECT tic, at-lt AS bv, prcc_c*csho/(at-lt) AS mb 
        FROM funda 
        WHERE fyear = 2010 
        AND tic ='IBM'"
result <- dbGetQuery(con,query)
result
#We might be interested in the market-to-book ratio distribution over the whole market.
#So let’s remove the restriction to only IBM and obtain the market-to-book ratio for every
#company listed in 2010.

query <- "SELECT tic, prcc_c*csho/(at-lt) AS mb
          FROM funda
          WHERE fyear = 2010
          AND tic IS NOT NULL
          AND prcc_c IS NOT NULL
          AND csho IS NOT NULL
          AND seq IS NOT NULL"
result <- dbGetQuery(con,query)
result
result <- subset(result, mb > 0.0 & mb < 50)
summary(result$mb)
hist(result$mb, breaks=100, main="")
library(tidyverse)
result %>% ggplot(aes(x = mb)) +
           geom_histogram(bins = 50)
#-------------------------------------
# The Reshape2 Package
command <- "SELECT tsymbol, date, ret
            FROM msf 
            WHERE date BETWEEN '2010-01-01' AND '2010-12-31'
            AND tsymbol IN ('AAPL','GOOG')"
result <- dbGetQuery(con, command)
result
#
c1 <- result[result$tsymbol=='AAPL',]$ret
c2 <- result[result$tsymbol=='GOOG',]$ret
cbind(c1,c2)
#============================================
library(reshape2)
# We melt the query while naming tsymbol and date as id variables while ret is a measured variable.
result <- melt(result, id=c("tsymbol","date"))
result
# The result is now molten. At this point we can recast with date as the only row variable, 
# and both tsymbol and ret as column variables.
dcast(result, date ~ tsymbol + variable)
# We can also compute aggregation functions along variable values. For example, let’s
# ﬁnd the mean monthly return for each tsymbol.
dcast(result, tsymbol ~ variable, mean)
#
library(tseries)
#prices <- get.hist.quote(c('AAPL', 'GOOGL'), c(.5, .5), 252,
#                        start = "2010-01-01", end = "2010-12-31",
#                        startBck1 = "2009-12-31", startFwd1 = "2010-01-02")
#
#plotMultSeries(prices,c('AAPL','GOOG'),c(.5,.5),2,
#               cc="days",ret="",ylim=c(.6,1.5))
#==========================================================
# Case study: google
# We ﬁrst query the funda table to determine Google’s
# market-to-book ratio
#==========================================================
query <- "SELECT fyear, sich, (csho*prcc_f)/(at-lt) AS mb
          FROM funda
          WHERE fyear >= 2004
          AND tic IN ('GOOG')"

res1 <- dbGetQuery(con,query)
unique(res1$sich)
#----------------------------------------------------------
# and proceed to query the market-to-book ratio for all ﬁrms that share Google’s industry
# code: 7370.
# 
query <- "SELECT tic, fyear, (csho*prcc_f)/(at-lt) AS mb
          FROM funda
          WHERE fyear >= 2004
          AND fyear <= 2013
          AND sich = 7370
          AND tic NOT IN ('GOOG')
          AND mb IS NOT NULL
          ORDER BY tic, fyear"
res2 <- dbGetQuery(con, query)
# We can now melt the query and recast it, taking the median of all ﬁrm market-to-book
# by fyear.

library(reshape2)
res2 <- melt(res2,id=c("tic","fyear"), na.rm=TRUE)
res2 <- dcast(res2, fyear~variable, median)
res2
#
par(mar=c(4,4,2,2))
plot(res1$fyear, res1$mb, type='l', ylim=c(0,1.1*max(res1$mb)),col='blue',
     xlab='year', ylab='Google M/B ratio versus industry median M/B ratio')
lines(res2$fyear,res2$mb,type='l',col='red')
legend(x=2008, y=15, legend=c("GOOG M/B","industry 7370 M/B"),
       col=c('blue','red'),lwd=c(1.5,1.5))


# 台灣公司財務報表資料
fin_tw <- read.table('finStmt.csv', sep = ',', header = T)
class(fin_tw)
colnames(fin_tw)
names(fin_tw)[3] <- '年月'
con <- dbConnect(SQLite(),":memory:")
dbWriteTable(con,"fin_tw", fin_tw, overwrite=TRUE)
dbListTables(con)

query <- "SELECT 公司, 簡稱, 資產總額, 負債總額, 股東權益總額
          FROM fin_tw
          WHERE 公司 = 1101 "
#
query <- "SELECT *
          FROM fin_tw
          WHERE 公司 = 1101
          AND 月份 = 12"
res2 <- dbGetQuery(con, query)
res2


