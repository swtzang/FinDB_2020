# http://jackthisisamazing.blogspot.com/2016/12/r-rmysql.html
library(pacman)
p_load(RODBC, dbConnect, DBI, gWidgets, RMySQL, xlsx)
#=====================================================
# or...
#install.packages("RODBC")
install.packages("odbc")
install.packages("RMariaDB")
install.packages("RPostgreSQL")
install.packages("dbConnect")
install.packages("DBI")
install.packages("gWidgets")
install.packages("RMySQL")
install.packages("xlsx")
#install.packages("RSQLite")

#library(RODBC)
library(odbc)
library(RPostgreSQL)
library(RMariaDB)
library(dbConnect)
library(DBI)
library(gWidgets)
library(RMySQL)
library(xlsx)
#library(RSQLite)
# =========================
# connect to AWS database
# 1. create connection first
# Note: leave dbname blank:
# connect = dbConnect(MySQL(), username = "swtzang", password = "68869104",
#                     host = "stock-prices.c7v1lylhbacf.us-east-1.rds.amazonaws.com")
# 2. create a database 'database1':
# dbSendQuery(connect,"create database database1")

# 3. create link to database1
# connect = dbConnect(MySQL(), dbname = 'database1', username = "swtzang", password = "68869104",
#                     host = "stock-prices.c7v1lylhbacf.us-east-1.rds.amazonaws.com")

connect = dbConnect(MySQL(), dbname = 'database1', username = "swtzang", password = "68869104"
                    ,host = "stock-prices.c7v1lylhbacf.us-east-1.rds.amazonaws.com")
# dbSendQuery(connect,"create database database1")
dbListTables(connect, "database1", database1)
dbWriteTable(connect, "mtcars1", mtcars1)
result = dbGetQuery(connect ,"SELECT * FROM mtcars1 WHERE cyl = 4")
result
dbDisconnect(connect)
# connect to localhost 
con = dbConnect(MySQL(), username = "root", password = "e121656070", host = "localhost")
#
con = dbConnect(MySQL(), user = 'root', password = '6886',host = 'localhost')
#
dbSendQuery(con,"create database database1")
#
localuserpassword <- "e121656070"
localuserpassword <- '6886'
storiesDb <- dbConnect(RMariaDB::MariaDB(), user='root', password= localuserpassword, 
                       host='localhost')
#
library(foreign)
funda <- read.dta("funda.dta")
msf <- read.dta("msf.dta")
