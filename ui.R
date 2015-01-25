library(shiny)
library(rCharts)
minY = min(longley$Year) 
maxY = max(longley$Year)
n<- dim(longley)[2]
columns <- as.list(c(1:n))
names(columns)<-names(longley)
# Define UI for random distribution application 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Longley's Economic Data"),
    tabsetPanel(
        
        tabPanel("Visualized Data", 
                 helpText("The time series plot represents the changes in 
                              proportions of employed, unemployed and people in the armed forces 
                              in the US from 1947 to 1962. 
                              You can choose any subset of the groups and determine the period of interest."),
                 br(),
                 sidebarPanel(
                     checkboxInput("armed", "% of people in the armed forces", value = TRUE),
                     checkboxInput("unemployed", "% of unemployed", value = TRUE),
                     checkboxInput("employed", "% of employed", value = FALSE),
                     br(),
                     
                     sliderInput("year", 
                                 "Period of interest in years:", 
                                 min = minY-1, 
                                 max = maxY+1,
                                 value = c(minY,maxY),
                                 step = 1,
                                 format="####"
                     )
                 ),
                 mainPanel(
                     showOutput('mychart', lib = "morris")
                 )
        ),
        tabPanel("Dataset",
                 sidebarPanel(
                     sliderInput("year2", 
                                 "Period of interest in years:", 
                                 min = minY, 
                                 max = maxY,
                                 value = c(minY,maxY),
                                 step = 1,
                                 format="####"
                     ),
                     br(),
                     checkboxGroupInput("colsInd", "Columns shown:",
                                  columns,
                                  selected = c(1:n)
                                  ),
                     hr(),
                     HTML("<small>The description of the variables you can see on 
                          <i><strong>Description</strong></i> tab.</small>")

                 ),
                 mainPanel(
                     tableOutput("datatable"),
                     helpText("An average proportion of employed for selected period (%):"),
                     textOutput("value")
                 )
        ),
        tabPanel("Description", 
                 HTML("<p>The application visualizes the <i>Longley's Economic Data</i> 
                      dataset from R <code> datasets</code> package.</p>
                      <p>Visualization techniques help to explore the data and, on the other hand, 
                      to present the results. The app focuses on the first part, 
                      it is a tool for primary data exploration.</p>
                      The dataset includes 7 variables observed yearly from 1947 to 1962:
                      <ul>
                        <li> <code>GNP.deflator</code> -- GNP implicit price deflator (1954=100)
                        <li> <code>GNP</code> -- Gross National Product
                        <li> <code>Unemployed</code> -- number of unemployed (in tens)
                        <li> <code>Armed.Forces</code> -- number of people in the armed forces (in tens)
                        <li> <code>Population</code> -- noninstitutionalized population more than 14 years old (in thousands)
                        <li> <code>Year</code> -- the year (time)
                        <li> <code>Employed</code> -- proportion of people employed
                      </ul>
                      <p> <i><strong> Visialized Data</strong></i> tab shows a time series plot
                      for proportions of employed, unemployed and people in the 
                      armed forces from 1947 to 1962. </p>
                      <p> <i><strong> Dataset</strong></i> tab presents the data in table form and includes 
                      widgets to manipulate with the table.</p>"),
                 hr(),
                 HTML("<small>Data source: J. W. Longley (1967) An appraisal of least-squares 
                      programs from the point of view of the user. 
                      <i>Journal of the American Statistical Association</i> 
                      <strong>62</strong>, 819–841.</small>")
        )
    )
    
    
))