# File name: ui.R

# Written/ run on: RStudio
# R version 4.3.1 (2023-06-16) -- Beagle Scouts"

# Create Shiny Dashboard, User Interface 

# Jessie, October 2023 

###############################################################################.

ui <- fluidPage(
  
  # Live theme selector used in development stage
  # shinythemes::themeSelector(),
  
  # Set theme of app
  theme = shinytheme("sandstone"), 
  
  # Add icon on top left of navbar with link to GitHub profile
  navbarPage(title = div(tags$a(img(src = "jessil07_logo.png", 
                                    width = 50, height = 50, 
                                    alt = "jessil07 logo",
                                    # Open link in new browser 
                                    target = "_blank"), 
                                 href = "https://github.com/jessil07"), 
                         style = "position:relative; top: -15px;", 
                         # Title for navbar 
                         "@jessil07"
                         ),
             
             # Information tab ----
             tabPanel(title = "Overview", 
                       icon = icon("film"), 
                       fluidRow(
                         column(9, 
                                h2("Short Overview")
                                ), # end of column
                         column(3, 
                                br(), 
                                actionButton("reference", 
                                             tags$b("Acknowledgements"), 
                                             icon = icon("book"))
                                ) # end of column
                         
                         ), # end of fluidRow
                      
                      fluidRow(
                        column(12,
                               h3(tags$b("Introduction")), 
                               p("Movies have long been a source of entertainment, artistic expression, and cultural reflection. The film industry has evolved over the years, becoming a major player in the global entertainment landscape. One of the key measures of a movie's success is its gross profit, which is often used as a benchmark to assess a film's financial performance."), 

                               h3(tags$b("Aim")), 
                               p("We will delve into the world of movies to explore the relationship between a film's gross profit and the various factors that can affect it.")
                               ) # end of column
                        ) # end of fluidRow
                      ), # end of tabPanel
             
             # Summary statistics tab ----
             tabPanel(title = "Summary Statistics", 
                      icon = icon("chart-simple"), 
                      h2("Summary Statistics", align = "center"), 
                      h3(tags$b("Descriptive Statistics")),
                      
                      sidebarLayout(
                        sidebarPanel(strong("Filters"), 
                                     br(), br(),
                                     p("Please use the menus below to adjust data to your interest."),
                                     br(), 
                                     
                          radioButtons(inputId = "ch_field", 
                                      label = "Select measurement of interest", 
                                      choices = list("Production Budget", "Domestic Gross Profit", "Worldwide Gross Profit")), 
                          
                          br(),
                          
                          sliderInput(inputId = "ch_no_bins", 
                                                 label = "Number of bins:", 
                                                 min = 1, max = 50, value = 30) # end of sliderInput
                          ), # end of sidebarPanel
                        mainPanel(
                          p(style = "text-align: center;", 
                            "This graph represents the frequency distribution of the selected measurement of interest by genre."), 
                          plotOutput("hist_chart"), 
                          
                          br(),
                          hr(),
                          
                          p(style = "text-align: center;", 
                            "Features of selected measurement."), 
                          
                         DT::dataTableOutput("summary_table"), 
                         
                         br(), br()
                          
                          ), # end of mainPanel
                      ), # end of sidebarLayout
        
                      ), # end of tabPanel
             
             # Budget vs gross profit tab ----
             tabPanel(title = "Budget and Profit", 
                      icon = icon("dollar-sign"), 
                      h2("Production Budget and Gross Profit", align = "center"), 
                      h3(tags$b("Exploration Work")),
                      sidebarLayout(
                        sidebarPanel(strong("Filters"), 
                                     br(), br(),
                                     p("Please use the filters from drop-down menus below to select the data that you are interested in."),
                                     br(), 
                                     
                                     radioButtons(inputId = "ch_geography", 
                                                  p("Select domestic or worldwide gross profit:"), 
                                                  choices = list("Domestic", "Worldwide")), # end of radioButtons
                                     
                                     selectizeInput(inputId = "ch_genre", 
                                                    p("Select one or genres (up to five)", ), 
                                                    choices = genre_list, 
                                                    multiple = TRUE, 
                                                    selected = "Horror", 
                                                    options = list(maxItems = 5L)), # end of selectizeInput
                                     
                                     selectInput(inputId = "ch_distributor", 
                                                    p("Select one or more distributor (up to two)", ), 
                                                    choices = dist_list, 
                                                    selected = "Dreamworks SKG"), # end of selectInput
                                     
                                     
                                     ), # end of sidebarPanel
                        mainPanel(p(style = "text-align: center;", 
                                    "This chart shows the", tags$i("potential"), "relationship between production budget (dollars) and gross profit (dollars)."), 
                                  p(style = "text-align: center;", 
                                    "Points represent recorded observations. The line of best fit (dashed line) has been superimposed onto the chart."),
                                  
                                  plotlyOutput("chart", width = "100%", height = "350px")) # end of mainPanel
                      ), # end of sidebarLayout
                      hr(),
                      h3(tags$b("Performance by Movie")), 
                      
                      sidebarLayout(
                        position = "right",
                        sidebarPanel("test"), # end of sidebarPanel
                        mainPanel(downloadButton(outputId = "download_table_csv", label = "Download data"),) # end of mainPanel
                      ) # end of sidebarLayout

                      
                      
                      ) # end of tabPanel
             
             ## Add through the years tab, trends with time
             
             ), # end of navbarPage
  


  ) # end of fluidPage



