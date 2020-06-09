#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Necessary libraries
library(PerformanceAnalytics)
library(lubridate)
library(reshape2)
library(ggplot2)
library(xts)

shinyServer(function(input, output) {
  
  getData <- reactive({
    
    # 1. DATA LOADING
    rawData <- read.csv("temp/rawData.csv", header = TRUE)
    
    # 2. DATA MANIPULATING
    # Characteristics
    str(rawData)
    # Head and tail
    head(rawData, n = 3)
    tail(rawData, n = 3)
    unique(rawData$Ticker)
    # Date range
    min(rawData$Date)
    max(rawData$Date)
    
    # Date format
    rawData$Date <- ymd(rawData$Date)
    class(rawData$Date)
    
    
    # Fill the missing values
    tidyData <- dcast(rawData, Date~Ticker, value.var = "Close")
    
    ffill <-  function(x){
      for (i in seq(length(x))){
        if (is.na(x[i])){
          if (i == 1){
            x[i] = x[min(which(!is.na(x)))]
          }
          else{x[i] = x[i-1]}
        }
      }
      return(x)
    }
    
    tidyData <- cbind(tidyData$Date, data.frame(apply(tidyData[2:7], 2, ffill)))
    colnames(tidyData)[1] <- "Date"
    
    # Convert to time series
    tidyData <- xts(tidyData[2:7], tidyData$Date)
    
    # 3. DATA VISUALIZATION
    
    # Selected stocks
    myidx <- c(input$ts1, input$ts2, input$ts3, input$ts4, input$ts5, input$ts6)
    tidyData <- tidyData[, myidx]
    
    # Selected dates
    ne <- new.env()
    ne$tidyData <- tidyData[paste(as.Date(input$dates[1]), as.Date(input$dates[2]), sep="::"),]
    
    # Colours
    colpal <- c("#00A600FF", "#63C600FF", "#E6E600FF", "#EAB64EFF", "#1d35e3", "#FF0000")
    ne$colores <- colpal[myidx]
    return(ne)
  })
  
  output$plot <- renderPlot({
    
    ne <- getData()
    tidyData <- ne$tidyData
    
    # Plot option "Prices"
    if (input$plottype == "Prices"){
      plot(as.zoo(tidyData), pch = 16, plot.type = "single", xlab = "Time", ylab = "Price", cex.main = 2, main = "Prices", col = ne$colores)
      legend("topleft", colnames(tidyData), fill = ne$colores, cex = 2)
      grid()
    }
    # Plot option "Cummulative Return"
    if (input$plottype == "Cummulative Return"){
      cumrets <- Return.calculate(xts(tidyData), method = "discrete")
      chart.CumReturns(cumrets, cex.legend = 2, legend.loc = "topleft", cex.main = 2, col = ne$colores, main = "Cummulative Return")
    }
    
  })
})