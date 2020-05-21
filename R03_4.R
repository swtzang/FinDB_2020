# Import data from TEJ
# 0050, 0052, 0056
rm(list=ls())
library(pacman)
p_load(tidyverse, lubridate, readxl, highcharter, tidyquant, 
       timetk, tibbletime, quantmod, PerformanceAnalytics, scales)
p_load(reshape2)

# import data
# Make sure to convert to UTF-8
etf3 <- read.table("tw_ETF_2008_2020.txt", header = TRUE)
# etf3 <- read_csv("tw_ETF_2008_2020.csv", col_names = TRUE)
etf3 <- etf3[, -2]
colnames(etf3) <- c('id', 'date', 'close')
etf3.1 <- dcast(etf3, date~id)
# check to see if there is any NA value
apply(is.na(etf3.1), 2, sum)
str(etf3.1)
# convert into xts 
etf3.xts <- xts(etf3.1[, -1], order.by = as.Date(as.character(etf3.1$date), 
                                               format = '%Y%m%d'))
head(etf3.xts)
# compute returns
etf3.ret <- Return.calculate(etf3.xts, method = 'log') %>% 
             na.omit()
head(etf3.ret)
# convert into weekly and monthly prices
etf3.w <- to.weekly(etf3.xts, indexAt = "lastof", OHLC = FALSE)
etf3.m <- to.monthly(etf3.xts, indexAt = "lastof", OHLC = FALSE)
head(etf3.m)
# compute monthly returns
etf3.ret.m <- Return.calculate(etf3.m, method = 'log') %>% 
              na.omit()
head(etf3.ret.m)
# converting daily prices to monthly returns in tidyverse
# options(digits = 4)
# etf3.ret.m1 <- etf3.xts %>% 
#                to.monthly(indexAt = 'lastof', OHLC = FALSE) %>% 
#                data.frame(date = index(.)) %>% 
#                remove_rownames() %>% 
#                gather(key = asset, value = prices, -date) %>% 
#                group_by(asset) %>% 
#                mutate(returns = (log(prices) - log(lag(prices)))) %>%
#                select(-prices) %>%
#                spread(key = asset, value = returns) %>% 
#                ungroup()
# 
# head(etf3.ret.m1)
#

etf3.ret.m2 <- etf3.xts %>%
               tk_tbl(preserve_index =TRUE, rename_index ="date") %>%
               gather(asset, prices, -date) %>%
               group_by(asset) %>%
               tq_transmute(mutate_fun =periodReturn,
                           period ="monthly",
                           type ="log") %>%
               spread(asset, monthly.returns) %>% 
               
head(etf3.ret.m2)
#
etf3.ret.m3 <- etf3.xts %>%
               tk_tbl(preserve_index =TRUE, rename_index ="date") %>%
               # this is the the tibbletime function
               as_tbl_time(index = date) %>%
               as_period(period = "month", side ="end") %>%
               gather(asset, returns, -date) %>%
               group_by(asset) %>%
               tq_transmute(mutate_fun =periodReturn,
                           type ="log") %>%
               spread(asset, monthly.returns) %>%
               slice(-1)

head(etf3.ret.m3)

#
p_load(fPortfolio)
p_load(tbl2xts)
#
summary(etf3.ret.m3)
# convert tibble to xts
etf3.ret.m3.xts <- etf3.ret.m3 %>% tk_xts(silent = TRUE) 
basicStats(etf3.ret.m3.xts)
                   
#X50 <- etf3.ret.m3.xts$`50`
#drawdownsStats(X50)

etf3.ret.m3 %>% gather(asset, returns, -date) %>% 
                ggplot(aes(x = returns, fill = asset)) +
                geom_histogram(alpha = 0.45, binwidth = .005) +
                ggtitle("Monthly Returns Since 2008")
#
etf3.ret.m3 %>% gather(asset, returns, -date) %>% 
                ggplot(aes(x = returns, fill = asset)) +
                geom_histogram(alpha = 0.45, binwidth = .01) +
                facet_wrap(~asset) +
                ggtitle("Monthly Returns Since 2008") +
                theme_update(plot.title = element_text(hjust = 0.5))
#
etf3.ret.m3 %>% gather(asset, returns, -date) %>% 
                ggplot(aes(x = returns, colour = asset)) +
                geom_density(alpha = 1) +
                ggtitle("Monthly Returns Density Since 2013") +
                xlab("monthly returns") +
                ylab("distribution") +
                theme_update(plot.title = element_text(hjust = 0.5))
#
etf3.ret.m3 %>% gather(asset, returns, -date) %>% 
                ggplot(aes(x = returns)) +
                geom_density(aes(color = asset), alpha = 1) +
                geom_histogram(aes(fill = asset), alpha = 0.45, binwidth = .01) +
                guides(fill = FALSE) +
                facet_wrap(~asset) +
                ggtitle("Monthly Returns Since 2013") +
                xlab("monthly returns") +
                ylab("distribution") +
                theme_update(plot.title = element_text(hjust = 0.5))






