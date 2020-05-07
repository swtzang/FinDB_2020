# Reference: 
# http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html
# https://yijutseng.github.io/DataScienceRBook/vis.html#ggplot2%E7%B0%A1%E4%BB%8B
# if: 
# error writing to connection Graphics error: Plot rendering error
# ctl + shift + F10 to restart Rstudio
#----------------------------------------------------------------------------------
# Setup
rm(list=ls())
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

# 1. Create a blank sheet ready for ploting----
# Init Ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

# 2. How to Make a Simple Scatterplot----
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

# 3. Add a smoothing layer----
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
     geom_point() + 
     geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)

# 4. Adjusting the X and Y axis limits----
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

# 5. How to Change the Title and Axis Labels----
Sys.setlocale(category = "LC_ALL", locale = "zh_TW.UTF-8") # 避免中文亂碼
#
g <- ggplot(midwest, aes(x=area, y=poptotal)) + geom_point() + geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in

# Add Title and Labels
g1 + labs(title="Map Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# or

g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("area") + ylab("Population")

# 6. How to Change the Color and Size of Points----

ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(col="steelblue", size=3) +   # Set static color and size for points
        geom_smooth(method="lm", col="firebrick") +  # change the color of line
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")

# How to Change the Color To Reflect Categories in Another Column? 
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

plot(gg)

# Now each point is colored based on the state it belongs because of aes(col=state). 
# Not just color, but size, shape, stroke (thickness of boundary) and fill (fill color) 
# can be used to discriminate groupings.

# the legend can be removed
gg + theme(legend.position="None")  # remove legend

# You can change the color palette entirely
gg + scale_colour_brewer(palette = "Set1")  # change color palette
#
library(RColorBrewer)
head(brewer.pal.info, 10)  # show 10 palettes

# 7. How to Change the X Axis Texts and Ticks Location----

# breaks and labels: 

# Step 1: Set the breaks
# The breaks should be of the same scale as the X axis variable. 
# Note that I am using scale_x_continuous because, the X axis variable is a continuous variable. 
# Had it been a date variable, scale_x_date could be used. 
# Like scale_x_continuous() an equivalent scale_y_continuous() is available for Y axis.

# Base plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

# Step 2: Change the labels You can optionally change the labels at the axis ticks. 
# labels take a vector of the same length as breaks.

# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change breaks + label
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11])

# Reverse the scale
library(ggplot2)
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Reverse X Axis Scale
gg + scale_x_reverse()


# How to Write Customized Texts for Axis Labels, by Formatting the Original Values?
library(ggplot2)

# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change Axis Texts
gg1 <- gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = sprintf("%1.2f%%", seq(0, 0.1, 0.01))) + 
        scale_y_continuous(breaks=seq(0, 1000000, 200000), labels = function(x){paste0(x/1000, 'K')})

# 
width = 11.69
height = 8.27
# save as .pdf file
ggsave(paste('gg1', '.pdf', sep=""), gg1, width = width, height = height)
# save as .eps file
postscript(file = paste('gg1', '.eps', sep=""), width = width, height = height)
print(gg1)
dev.off()
# save .png file
png(file = paste('gg1', '_.png', sep=""), width = width * 100, height = height * 100)
print(gg1)
dev.off()

# 8. How to Customize the Entire Theme in One Shot using Pre-Built Themes?----

gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

gg <- gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

# method 1: Using theme_set()
theme_set(theme_classic())  # not run
gg

# method 2: Adding theme Layer itself.
gg + theme_bw() + labs(subtitle="BW Theme")
gg + theme_classic() + labs(subtitle="Classic Theme")





























