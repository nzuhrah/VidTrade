library(shiny)
library(plotly)
library(shinyWidgets)
tradedata <- read.csv("trade.value2019-2020.csv", header=TRUE) 
trans.data <- read.csv("transport.csv", header = TRUE)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    setBackgroundColor(
        # color = c("#FFE4E1", "#E6E6FA", "#E0FFFF"),
        color = c("#FFEFD5", "#FFC0CB", "#B0E0E6"),
        gradient = "linear",
        direction = "bottom"
    ),
    
    tags$h2(
        tags$style("h2{font-family: Marker Felt, fantasy;}")
    ), 
    tags$h3(
        tags$style("h3{font-family: OCR A Std, monospace;}")
    ), 
    tags$h4(
        tags$style("h4{font-family: OCR A Std, monospace;}")
    ), 
    
    navbarPage("VidTrade",
               
               tabPanel("About Apps",
                        mainPanel(
                        h3("VidTrade has been built
                        to create a useful product that provides 
                        visualization of trade and commercial transport 
                        activity before and after Covid-19 outbreaks."), 
                        
                        uiOutput("tab"),
                      br(),
                      
                        h2(strong("Apps User's Guide:")),
                        
                        h3("For Trade Activity: Users can select multiple country to view the trend"),
                        h3("For Commercial Transport Activity: Please hover your mouse on the legend and double click to select a country."))),
               
               tabPanel("Trade Activity",   
                # main panel title
                titlePanel("Trade Value from January 2019 until April 2020"),
                br(),
    
                # Show a plot 
                mainPanel(
                    
                    selectizeInput(
                        inputId = "Country", 
                        label = "Select a Country", 
                        choices = unique(tradedata$Country), 
                        selected = "Angola",
                        multiple = TRUE
                    ),  
                    
                plotlyOutput("tradechart"))
                ),
               
               tabPanel("Commercial Transport Activity",
                # main panel title
                titlePanel("Frequency of Commercial Transport for First Quarter (Q1) of 2019 and 2020"),
                br(),
                        
                        # Show a plot 
                        mainPanel(
                            
                            plotlyOutput("transport"))
               ),
               
               tabPanel("Documentation",
                        mainPanel(
                            h2(strong("Project Motivation"),
                               
                            h4 ("1. Transport is an essential to the 
                               efficient working of the economy, bringing 
                               together the inputs in the production of 
                               goods and services and getting outputs 
                               from the production process to customers."),
                            
                            
                            h4("2. Estimates suggest that if all other drivers of 
                                growth were to increase by 10% and transport 
                                infrastructure were to stay constant, then realised 
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
    url <- a("here", href="https://comtrade.un.org/data/")
    output$tab <- renderUI({
        tagList(h3("For such purpose, raw datasets can be found and retrieved from ", url))
    })
        
    output$tradechart <- renderPlotly({
        
        # output plot
        plot_ly(tradedata,x = ~Year_Month, y = ~Trade.Value, name=~Country, width = 1100) %>%
            filter(Country %in% input$Country) %>%
            group_by(Country) %>%
            add_lines()
        
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
