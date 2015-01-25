library(shiny)
library(rCharts)
rates <- c("Armed.Forces","Unemployed", "Employed")
data<-longley
data$Year <- as.character(longley$Year)
year<-longley$Year
data$Armed.Forces <- format(longley$Armed.Forces/longley$Population, digits=2)
data$Unemployed <- format(longley$Unemployed/longley$Population, digits=2)
data$Employed <- format(longley$Employed, digits=3)
# Define server logic 
shinyServer(function(input, output) {
  
  # using Longley's Economic data from datasets package
  
  # Generate a plot of the data

  output$mychart <- renderChart({
    startYear <- input$year[1]
    endYear <- input$year[2]
    checked <- c(input$armed, input$unemployed, input$employed)
    m1 <- mPlot(x = "Year", y =rates[checked], type = "Line", 
                data = data[(year>=startYear)&(year<=endYear),])
    m1$set(pointSize = 1, lineWidth = 2)
    m1$set(dom = 'mychart', width = 600)
    return(m1)
  })
  
  # Generate a summary of the data
  output$datatable <- renderTable({
     dataOut <- longley[(year>=input$year2[1])&(year<=input$year2[2]),as.numeric(input$colsInd)]
     if (length(input$colsInd)==1){
         dataOut <- as.data.frame(dataOut)
         names(dataOut) <- names(longley)[as.numeric(input$colsInd)]
     }
     if (length(input$colsInd)==0){
         dataOut <- NULL
     }
     dataOut
      })
  
  output$value <- renderPrint({
      mean(longley$Employed[(year>=input$year2[1])&(year<=input$year2[2])])
  })
  
})