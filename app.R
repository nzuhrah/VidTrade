library(shiny)
library(plotly)
tradedata <- read.csv("trade.value2019-2020.csv", header=TRUE) 
trans.data <- read.csv("transport.csv", header = TRUE)

# Define UI for application that draws a histogram
ui <- fluidPage(
    navbarPage("VidTrade",
               
               tabPanel("About Apps",
                        mainPanel(
                        h3("VidTrade has been built
                        to create a useful product that provides 
                        visualization of trade and commercial transport 
                        activity before and after Covid-19 outbreaks."), 
                        
                        h3("For such purpose, datasets can be found and retrieved from https://comtrade.un.org/data/"),
                      
                      br(),
                      
                        h2(strong("Apps User's guide:")),
                        
                        h3("Please bring your mouse and click on the legend to select."))),
               
               tabPanel("Trade Activity",   
                # main panel title
                titlePanel("From January 2019 to April 2020"),
    
    
                # Show a plot 
                mainPanel(
                plotlyOutput("tradechart"))
                ),
               
               tabPanel("Commercial Transport Activity",
                # main panel title
                titlePanel("Frequency of commercial transport for first quater, Q1 of 2019 and 2020"),
                        
                        
                        # Show a plot 
                        mainPanel(
                            plotlyOutput("transport"))
               ),
               
               tabPanel("Documentation",
                        mainPanel(
                            h2(strong("Project Motivation"),
                               
                            h4 ("Transport is an essential to the 
                               efficient working of the economy, bringing 
                               together the inputs in the production of 
                               goods and services and getting outputs 
                               from the production process to customers."),
                            
                            
                            h4("Estimates suggest that if all other drivers of 
                                growth were to increase by 10% and transport 
                                infrastructure were to stay constant,then realised 
                                growth in income would be just 9%, means 1% point less 
                                than it otherwise would have been."),
                            
                            br(),
                            
                            h2(strong("Case for change"),
                               
                             h4("With Covid-19 hitting country at different time and rates,
                                access to global demand via open markets and continued
                                trade will be important for supporting and sustaining 
                                economic recovery. Hence, there is thus a need to consider 
                                how to interpret current or future investment possibilites."))
                            )
                            )
               )
))

# Define server logic required to draw a chart
server <- function(input, output) {
    
    output$tradechart <- renderPlotly({
        
        # output plot
        plot_ly(tradedata,
                type = "scatter",
                mode = "lines+markers",
                x = ~Year_Month, 
                y= ~Trade.Value, 
                name = ~Country, width = 1100)
        
    })

    output$transport <- renderPlotly({
        
        # output plot
        plot_ly(trans.data,
                type = "bar",
                x = ~Year, 
                y= ~Frequency, 
                name = ~Country, width = 1100)
    })
    }

# Run the application 
shinyApp(ui = ui, server = server)
