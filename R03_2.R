# Reference: Hadley Wickham ggplot2: Elegant graphics for data analysis
#
library(pacman)
p_load(tidyverse, ggplot2)

#1. 直方圖(Histograms)與次數多邊圖 (Frequency polygons)----

mpg %>% ggplot(aes(hwy)) + geom_histogram()

mpg %>% ggplot(aes(hwy)) + geom_freqpoly()

mpg %>% ggplot(aes(hwy)) +
  geom_freqpoly(binwidth = 2.5)

mpg %>% ggplot(aes(hwy)) +
  geom_freqpoly(binwidth = 1)

# 2. map categorical variables ----
mpg %>% ggplot(aes(displ, colour = drv)) +
        geom_freqpoly(binwidth = 0.5)

mpg %>% ggplot(aes(displ, fill = drv)) +
        geom_histogram(binwidth = 0.5) +
        facet_wrap(~drv, ncol = 1)

mpg %>% ggplot(aes(manufacturer)) +
        geom_bar()

# 3. Time series line and path plots----
data(economics)
class(economics)
str(economics)
#
economics %>% ggplot(aes(date, unemploy / pop)) +
              geom_line()
# or
ggplot(economics) + 
  geom_line(aes(date, unemploy))
# or
economics %>% ggplot(aes(x = date, y = unemploy)) + 
              geom_line()
#
g1 <- economics %>% ggplot(aes(date, uempmed)) +
              geom_line()
#
economics %>% ggplot(aes(unemploy / pop, uempmed)) +
              geom_path() +
              geom_point()
# 
data(presidential)
presidential <- subset(presidential, start > economics$date[1])
# 4. 標示特定範圍的資料: geom_rect()
ggplot(economics) + 
      geom_rect(aes(xmin = start, xmax = end, fill = party),
      ymin = -Inf, ymax = Inf, alpha = 0.2, data = presidential) +
  geom_vline(
    aes(xintercept = as.numeric(start)),
    data = presidential,
    colour = "grey50", alpha = 0.5
  ) +
  geom_text(
    aes(x =start, y =2500, label = name),
    data = presidential,
    size = 3, vjust = 0, hjust = 0, nudge_x = 50
  ) +
  geom_line(aes(date, unemploy)) +
  scale_fill_manual(values = c("blue", "red"))

# 
year <- function(x) as.POSIXlt(x)$year + 1900

as.POSIXlt(economics$date)$year + 1900 

ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path(colour = "grey50") +
  geom_point(aes(colour = year(date)))

# 
# Another Example
library(quantmod)
getSymbols("^GSPC", src = "yahoo", start = '1900-01-01')
head(GSPC)
# convert xts to data frame
# rownames to columns
GS1 <- GSPC %>% as.data.frame() %>% rownames_to_column('date')
class(GS1)
str(GSPC1)
GS1$date <- as.Date(GS1$date, format = "%Y-%m-%d")
head(GS1)
str(GS1)
# 
p_load(tbl2xts)
xts_tbl(GSPC)
#
GSPC.ad <- Ad(GSPC) %>% xts_tbl()
ggplot(GSPC.ad, aes(x = date, y = GSPC.Adjusted)) + 
  geom_line()
# 
recess<-data.frame(begin=as.Date(c("2008-01-01", "2011-01-01", "2015-01-01", "2020-02-01")), 
                   end = as.Date(c("2009-06-30", "2013-05-30", "2015-12-31", "2020-05-01")))
#
ggplot(GSPC.ad, aes(x = date, y = GSPC.Adjusted)) + 
          geom_line() +
          geom_rect(data = recess, 
                    aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf),
                    inherit.aes = FALSE, 
                    fill = "grey", 
                    alpha = 0.7)+
          scale_x_date(date_breaks = "2 year", 
                       labels = function(x) paste0("'", substr(x, 3, 4)))








