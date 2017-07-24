#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(highcharter)
library(dplyr)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("yeti"),
  
  # Application title
  titlePanel("Car Analyzer"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("data",
                   "Weight in 1000(lbs):",
                   min = 1,
                   max = 6,
                   value = c(1,6), step = 0.01),
       submitButton("Submit")
    ),
    
    
    # Show a plot of the generated distribution
    mainPanel(
        uiOutput("tb")
    )
  )
))
