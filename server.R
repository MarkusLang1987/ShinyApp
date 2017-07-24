#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(highcharter)
library(dplyr)
library(shinythemes)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
    results <- reactive({
        data <- mtcars %>%
            filter(wt > min(input$data) & max(input$data)) %>%
            group_by(cyl) %>%
            summarise(Mean = round(mean(mpg),2))
        
    })
    
    
  output$table <- renderHighchart({
    hchart(results(), "column", hcaes(x = factor(cyl), y = Mean, group = cyl))
    
  })
  
  output$datatable <- DT::renderDataTable({
    DT::datatable(results()) 
  })
  
  output$text1 <- renderText({
      paste("<strong>Welcome!</strong><br><br> With this little tool you can analyze how much fuel a car uses. You can filter by weight, min and max. The data is grouped by cylinders<br>
            Have Fun exploring the App! :-)")
  })
  
  
  output$tb <- renderUI({
          tabsetPanel(tabPanel("Graph", highchartOutput("table")),tabPanel("Datatable", DT::dataTableOutput("datatable")), tabPanel("Interpretation", htmlOutput("text1"), style = "font-family: 'Jura'; font-size:18px")
    )
  })
  
})
