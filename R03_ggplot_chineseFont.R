# Reference: 
# http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html
# https://yijutseng.github.io/DataScienceRBook/vis.html#ggplot2%E7%B0%A1%E4%BB%8B
# https://www.twblogs.net/a/5b8283e62b717766a1e8a2b4
# http://jianghao.wang/post/2018-01-23-rstudio-server/
#----------------------------------------------------------------------------------
# Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)

#簡單來說，做圖的文法包括兩個最主要元素：
#Aesthetic attributes：包括顏色、形狀、點的大小與線的粗細等
#Geometric objects：包括點、線、盒狀圖、直條圖等
# 其他元素包括：
# Facets：提供在同一張圖內做多個子圖的方法，只要使用Faceting功能設定子圖分類的依據參數即可
# Stats：將資料做統計轉換
# cales：修改點線的顏色、形狀、xy軸的範圍等


# data collected on Midwest states in the 2000 US census
data("midwest", package = "ggplot2")  # load the data
# midwest <- read.csv("http://goo.gl/G1K41K") # alt source 

# 1. Create a blank sheet ready for ploting
# Init Ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

# 2. How to Make a Simple Scatterplot
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

# 3. Add a smoothing layer
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
     geom_point() + 
     geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)

# 4. Adjusting the X and Y axis limits
# 4.1 By deleting the points outside the range
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
     geom_point() + 
     geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

# Delete the points outside the limits
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))   # deletes points
# g + xlim(0, 0.1) + ylim(0, 1000000)   # deletes points

# 4.2 Zooming In
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
     geom_point() + 
     geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

# Zoom in without deleting the points outside the limits. 
# As a result, the line of best fit is the same as the original plot.
g1 <- g + coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000))  # zooms in
plot(g1)

# 5. How to Change the Title and Axis Labels
# Sys.setlocale(category = "LC_ALL", locale = "zh_TW.UTF-8") # 避免中文亂碼
library(pacman)
p_load(showtextdb, showtext)
showtext_auto(enable = TRUE)
font.add("cwTeXMing", "/usr/share/fonts/truetype/cwtex/cwming.ttf") # 你的中文字體位置
# font.add("康熙字典體", "康熙字典體.otf")
#
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in

# Add Title and Labels
g1 + labs(title="面積 Vs Population", subtitle="From midwest dataset", 
          y="Population", x="Area", caption="Midwest Demographics",
          family = "AR PL UKai TW")

# or

g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("面積") + ylab("Population")



ggplot(data.frame(x = rnorm(100))) +
        geom_histogram(aes(x)) + labs(x = '數值', y = '數量') +
        theme(text = element_text(family = '康熙字典體')) +
        annotate("text", x = 0, y = 7, label = "這是康熙字典體",
                 family = '康熙字典體', size = 16)

df <- data.frame(
        RRT = c(72.724, 90.582, 118.956, 45.090, 183.071, 54.094),
        資料中心 = factor(rep(c("tokyo", "tokyo2", "singapore"), 2),
                      levels = c("tokyo", "tokyo2", "singapore")),
        測試環境 = factor(c(rep("Hinet ADSL", 3), rep("學術網路", 3))))
#
ggplot(df, aes(x = 資料中心, y = RRT, fill = 測試環境)) +
        geom_bar(position = position_dodge(), stat = "identity") +
        theme(text=element_text(family="cwTexMing", size=14))






























