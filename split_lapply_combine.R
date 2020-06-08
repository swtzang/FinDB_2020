#===================================================================================
# https://coolbutuseless.bitbucket.io/2018/03/03/split-apply-combine-my-search-for-a-replacement-for-group_by---do/
#===================================================================================
finreport <- read.table("finreport.txt", header = T)
finreport <- finreport[, -2]

con = gzcon(url('http://www.systematicportfolio.com/sit.gz', 'rb'))
source(con)
close(con)
#
library(xts)
load(file='data.fund.Rdata')
#
data(data.fund)
names(data.fund)
aa <- data.fund$AA
str(data.fund)
glimpse(data.fund)
#
date.fund.data <- function(data)
{
  # construct date
  quarter.end.date = as.Date(paste(data['quarter end date',], '/1', sep=''), '%Y/%m/%d')  
  quarterly.indicator = data['quarterly indicator',]
  date.preliminary.data.loaded = as.Date(data['date preliminary data loaded',], '%Y-%m-%d') + 1
  
  months = seq(quarter.end.date[1], tail(quarter.end.date,1)+365, by='1 month') 
  index = match(quarter.end.date, months)
  quarter.end.date = months[ iif(quarterly.indicator == '4', index+3, index+2) + 1 ] - 1
  
  fund.date = date.preliminary.data.loaded
  fund.date[is.na(fund.date)] = quarter.end.date[is.na(fund.date)] 
  
  return(fund.date)
}

fund.date = date.fund.data(aa)  
tickers <- names(data.fund)
tickers <- c("DD", "XOM")
#
data <- new.env()
getSymbols(tickers, src = 'yahoo', from = '1970-01-01', env = data, auto.assign = T)
for(i in ls(data)) data[[i]] = adjustOHLC(data[[i]], use.Adjusted=T) 
bt.prep(data, align='keep.all', dates='1995::2011')


library(quantmod)
i = "DD"
for(i in tickers) {
  fund = data.fund[[i]]
  fund.date = date.fund.data(fund)
  
  EPS.Q = as.double(fund['Diluted EPS from Total Operations',])
  EPS.Q = as.xts(EPS.Q, fund.date)    
  EPS = runSum(EPS.Q, 4)
  
  data[[i]] = merge(data[[i]], EPS)
}

#*****************************************************************
# Compute monthly factors
#****************************************************************** 
prices = data$prices
prices = bt.apply.matrix(prices, function(x) ifna.prev(x))

# create factors
factors = list()

# E/P
data[, 'EPS']
EPS = bt.apply(data, function(x) ifna.prev(x[, 'EPS']))
factors$EP = EPS / prices

# VOMO - Volume x Momentum
volume = bt.apply(data, function(x) ifna.prev(Vo(x)))
factors$VOMO = (prices / mlag(prices,10) - 1) * bt.apply.matrix(volume, runMean, 22) / bt.apply.matrix(volume, runMean, 66)


# find month ends
month.ends = endpoints(prices, 'months')

prices = prices[month.ends,]
n = ncol(prices)
nperiods = nrow(prices)

ret = prices / mlag(prices) - 1
next.month.ret = mlag(ret, -1)

factors$EP = factors$EP[month.ends,]    
factors$VOMO = factors$VOMO[month.ends,]    
#
#*****************************************************************
# Combine fundamental and pricing data
#******************************************************************
# https://systematicinvestor.wordpress.com/2012/02/04/multiple-factor-model-building-fundamental-factors/
i = 'DD'
for(i in tickers) {
  fund = data.fund[[i]]
  fund.date = date.fund.data(fund)
  
  # Earnings per Share        
  EPS = get.fund.data('Diluted EPS from Total Operations', fund, fund.date, is.12m.rolling=T)
  
  # Sales, exception not available for financial firms
  SALE = get.fund.data('total revenue', fund, fund.date, is.12m.rolling=T)
  
  # Common Shares Outstanding
  CSHO = get.fund.data('total common shares out', fund, fund.date)
  
  # Common Equity
  CEQ = get.fund.data('total equity', fund, fund.date)
  
  # Dividends
  DV.PS = get.fund.data('dividends paid per share', fund, fund.date, is.12m.rolling=T)
  
  # Cash Flow, exception not available for financial firms
  CFL = get.fund.data('net cash from operating activities', fund, fund.date, cash.flow=T, is.12m.rolling=T)
  
  # merge
  data[[i]] = merge(data[[i]], EPS, SALE, CSHO, CEQ, DV.PS, CFL)
}
label = 'Diluted EPS from Total Operations'
#
get.fund.data <- function
(
  label,
  fund,
  fund.date,
  is.12m.rolling=F,
  cash.flow=F
)
{
  index = get.fund.data.index(label, fund)
  if( len(index) == 0 ) return(as.xts(rep(NA,len(fund.date)), fund.date))
  temp.q = as.double(gsub(',', '', fund[index,]))
  temp.q = ifna(temp.q, 0)
  if(cash.flow) {
    quarterly.indicator = fund['quarterly indicator',]
    temp.q = iif(quarterly.indicator == '1', temp.q, temp.q - mlag(temp.q))
  }
  temp.q = as.xts(temp.q, fund.date)
  iif(is.12m.rolling, runSum(temp.q, 4), temp.q)
}

get.fund.data.index(label, fund)




#*****************************************************************
# Compute monthly factors
#****************************************************************** 
prices = data$prices
prices = bt.apply.matrix(prices, function(x) ifna.prev(x))

# create factors
factors = list()

# E/P
EPS = bt.apply(data, function(x) ifna.prev(x[, 'EPS']))
factors$EP = EPS / prices
#=============================================================
tej_3f <- read.table('tej_finstmt.csv', sep = ',', header = T)
colnames(tej_3f)
tej_3f_t <- t(tej_3f)
#1. split 2. lapply 3. do.call(rbind)
# 1:
tej_3f.1 <- split(tej_3f, tej_3f$公司)
names(tej_3f.1)
#tw1101 <- tej_3f.1$`1101`
#tw1102 <- tej_3f.1$`1102`
#class(tw1101)
#tw1101.1 <- t(tw1101)
#
adj_func <- function(df) {
                df <- t(df)
                df <- df[-c(1:2), ]
                colnames(df) <- df[1, ]
                return(df)
}
# 2:
result.ls.df <- lapply(tej_3f.1, adj_func)
names(result.ls.df)
tw1101 <- result.ls.df$`1101`
tw1101[1:20, 1:3]
# 3:
result.df<- do.call(rbind, result.ls.df)
#==========================================
# more advanced approach
#==========================================
tej_3f %>% group_by('簡稱')


#
label = '每股盈餘'
index <- which(rownames(result.ls.df[["1101"]])== label)
as.numeric(result.ls.df[["1101"]][88,])
#
tickers <- names(result.ls.df)
i = "1101"
for (i in tickers) {
      index <- which(rownames(result.ls.df[[i]])== label)
      temp.q = as.double(gsub(',', '', result.ls.df[[i]][index,]))
      temp.q = ifna(temp.q, 0)
}
# convert to tibble
tej_3f <- read.table('tej_finstmt.csv', sep = ',', header = T)
colnames(tej_3f)
tej_3f_t <- as.data.frame(t(tej_3f[, c(1, 3:ncol(tej_3f)) ]))

#library(tidyverse)
colnames(tej_3f_t) <- tej_3f[, 2]
tej_3f_tbl <- as_tibble(tej_3f_t)
colnames(tej_3f_tbl)
colnames(tej_3f_t)
#
p_load(DBI)
p_load(RSQLite)

mtcars1 <- mtcars %>% rownames_to_column(var = "rownames")
con <- dbConnect(SQLite(),":memory:")
dbWriteTable(con,"mtcars1", mtcars1)
dbListFields(con,"mtcars1")



result <- dbGetQuery(con, "SELECT * FROM mtcars1 WHERE cyl = 4")

p_load(foreign)
# setwd(paste(homeuser,"/FinAnalytics/ChapXII",sep=""))
funda <- read.dta("funda.dta")
msf <- read.dta("msf.dta")
con <- dbConnect(SQLite(),":memory:")
dbWriteTable(con,"funda",funda,overwrite=TRUE)
names(funda)
funda
dbWriteTable(con,"msf",msf,overwrite=TRUE)
dbListTables(con)

#==============================================================
# Example of split-lapply-combine
state_dat <- data.frame(state.name, state.area, state.center, state.division)
column_to_rownames(state_dat)
column_to_rownames(state_dat, 'state.name')
library(reshape2)
library(tibble)
# convert to tibble
# tej_3f_tb <- as_tibble(tej_3f)
# class(tej_3f_tb)
# tt <- melt(tej_3f, id.vars = c("公司", "簡稱", "年.月") )
data(mtcars)
big_df <- mtcars
#
complex_func <- function(df) {
                df$N <- nrow(df)
                df$func_has_ID <- 'ID' %in% colnames(df)
                df
}
#
split_df       <- split(big_df, big_df$cyl)
result_list_df <- lapply(split_df, complex_func)
result_df      <- do.call(rbind, result_list_df)
#
result_df <- plyr::ddply(big_df, "cyl", complex_func)
#
library(tidyverse)
result_df <- big_df %>%
             dplyr::group_by(cyl) %>%
             do(complex_func(.)) %>%
             ungroup() 
result_df
#
result_df <- big_df %>%
             group_by(cyl) %>%
             nest() %>%
             mutate(data = purrr::map(data, complex_func)) %>%
             unnest()
#
result_df <- big_df %>%
             split(.$cyl) %>%
             purrr::map_dfr(complex_func) 