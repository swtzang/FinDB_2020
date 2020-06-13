# FinDB_2020
## R02_1
===========================================
## R_MySQL.R
### https://db.rstudio.com/best-practices/drivers/
## Installing problems in package odbc 

> install.packages("odbc")  
Installing package into ‘/usr/local/lib/R/site-library’  
(as ‘lib’ is unspecified)  
trying URL 'https://cloud.r-project.org/src/contrib/odbc_1.2.2.tar.gz'  
Content type 'application/x-gzip' length 311557 bytes (304 KB)  
==================================================  
downloaded 304 KB  
* installing *source* package ‘odbc’ ...  
** package ‘odbc’ successfully unpacked and MD5 sums checked  
** using staged installation  
Found pkg-config cflags and libs!  
PKG_CFLAGS=  
PKG_LIBS=-lodbc  
<stdin>:1:10: fatal error: sql.h: No such file or directory  
compilation terminated.  
------------------------- ANTICONF ERROR ---------------------------
Configuration failed because odbc was not found. Try installing:
 * deb: unixodbc-dev (Debian, Ubuntu, etc)
 * rpm: unixODBC-devel (Fedora, CentOS, RHEL)
 * csw: unixodbc_dev (Solaris)
 * brew: unixodbc (Mac OSX)
=======================================================

## Try the following commands  
 ### Install UnixODBC, which is required for all databases
  ### Install the unixODBC library
  apt-get install unixodbc unixodbc-dev 
 ### Install common DB drivers (optional)
  ### SQL Server ODBC Drivers (Free TDS)
  apt-get install tdsodbc
 ### PostgreSQL ODBC ODBC Drivers
  apt-get install odbc-postgresql
  ### MySQL ODBC Drivers
  apt-get install libmyodbc
 ### SQLite ODBC Drivers
  apt-get install libsqliteodbc
=========================================================== 

To use a custom odbc set INCLUDE_DIR and LIB_DIR and PKG_LIBS manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=... PKG_LIBS=...'

## Try the following commands
sudo apt-get install unixodbc-dev

