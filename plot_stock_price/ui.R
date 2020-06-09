#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

library(shiny)

shinyUI(fluidPage(
  titlePanel("Stock Prices Series"),
  
  sidebarPanel(
    helpText("With this application you can visualize the behavior of a set of stocks in a period of time, from the point of view of prices or cumulative return"),
    br(),
    tags$b("Select the stocks you want to analyze"),
    checkboxInput("ts1", "AAPL", 1),
    checkboxInput("ts2", "CA", 2),
    checkboxInput("ts3", "CSIO", 3),
    checkboxInput("ts4", "ITX", 4),
    checkboxInput("ts5", "NOK", 5),
    checkboxInput("ts6", "YHOO", 6),
    
    dateRangeInput("dates", 
                   label = "Select the period of your analysis",
                   start = "2004-12-31", end = "2014-12-31"),
    
    selectInput("plottype", "Select the type of plot", c("Prices", "Cummulative Return")),
    
    helpText("The code necessary to generate this app is available here https://github.com/mallanegui/DevelopingDataProducts")
  ),
  
  mainPanel(
    plotOutput("plot",  height = 800)
  )
))