# The pricing accuracy of alternative equity valuation models: Scandinavian evidence
# 資料：TEJ IFRS 合併為主簡表累計

rm(list = ls())
#library(foreign)
# install.packages("RODBC")
install.packages("odbc")
#install.packages("RMariaDB")
#install.packages("RPostgreSQL")
#install.packages("dbConnect")
install.packages("DBI")
#install.packages("gWidgets")
install.packages("RMySQL")
install.packages("xlsx")
install.packages("RSQLite")
#================================================
#library(RODBC)
library(odbc)
#library(RPostgreSQL)
library(RMariaDB)
#library(dbConnect)
library(DBI)
#library(gWidgets)
library(RMySQL)
library(xlsx)
library(RSQLite)
#=================================================
funda <- read.table("tej_finstmt_2010_2020.txt", sep = ",", header = TRUE)
funda <- read.csv("tej_finstmt_2010_2020.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
# Use read_csv() so that some columns can be converted into numeric instead of character or strings.
funda <- read_csv("tej_finstmt_2010_2020.csv")
str(funda)

#nc <- c(7:11, 15:17)
#cols_to_change = nc
#for(i in nc){
#  class(funda[, i]) = "numeric"
#}

str(funda)
#funda[, nc] <- as.numeric(as.character(funda[, nc]))
str(funda)
# change column names
names(funda)[3] <- '年月'
colnames(funda)
# msf <- read.dta("msf.dta")
con <- dbConnect(SQLite(),":memory:")
dbWriteTable(con,"funda", funda, overwrite=TRUE)
dbListTables(con)

# let’s query the funda table for IBM’s total assets, at, and total liabilities, lt
query <- "SELECT * 
          FROM funda
          WHERE 公司 = 1101"
result <- dbGetQuery(con,query)
result
#
query <- "SELECT 公司, 年月, 季別, 資產總額, 負債總額, 股東權益總額, 營業收入淨額, 每股盈餘,
                 營業毛利率, 股利殖利率, 現金股利率
          FROM funda
          WHERE 公司 = 1101
          AND 季別  = 4"
result <- dbGetQuery(con,query)
result
#
query <- "SELECT 公司, 年月, 季別, 資產總額, 負債總額, 股東權益總額, 營業收入淨額, 每股盈餘,
                 營業毛利率, 股利殖利率, 現金股利率, 負債總額/股東權益總額 AS leverage 
          FROM funda
          WHERE 公司 = 1101
          AND 季別  = 4"
result <- dbGetQuery(con,query)
result
str(result)
#===============================================================================================
