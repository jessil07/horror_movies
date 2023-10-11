# File name: server.R

# Written/ run on: RStudio
# R version 4.3.1 (2023-06-16) -- Beagle Scouts"

# Create Shiny Dashboard, Server 

# Jessie, October 2023 

###############################################################################.

server <- function(input, output, session) {
  
  # Information tab ----
  # Additional information button 
  observeEvent(input$reference, 
               showModal(modalDialog(title = "Acknowledgements", 
                                     h4("Acknowledgement for Online Source of Data Set"), 
                                     p("Thanks to", 
                                       strong("R4DS Online Learning Community (2023). Tidy Tuesday: A weekly social data project"), 
                                              "for making the data set used throughout this project available."), 
                                     p("Please click link below to access their GitHub page"), 
                                     tags$a(href = "https://github.com/rfordatascience/tidytuesday", "Click here!"),
                                     size = "m", 
                                     easyClose = TRUE, 
                                     fade = FALSE, 
                                     footer = modalButton("Close (Esc)"))
                         ) # end of showModal
               ) # end of observeEvent
  
  # Summary Statistics tab ----
  
  # Histogram
  output$hist_chart <- renderPlot({
    
    if(input$ch_field == "Production Budget"){
      
      ggplot(movies, aes(production_budget, fill = genre)) +
        geom_histogram(bins = input$ch_no_bins, alpha = 0.5, position = "identity") +
        xlab("Production Budget (dollars)") +
        theme_minimal()
      
    } else if(input$ch_field == "Domestic Gross Profit"){
      
      ggplot(movies, aes(domestic_gross, fill = genre)) +
        geom_histogram(bins = input$ch_no_bins, alpha = 0.5, position = "identity") +
        xlab("Domestic Gross Profit (dollars)") +
        theme_minimal()
      
    } else if(input$ch_field == "Worldwide Gross Profit"){
      
      ggplot(movies, aes(worldwide_gross, fill = genre)) +
        geom_histogram(bins = input$ch_no_bins, alpha = 0.5, position = "identity") +
        xlab("Domestic Gross Profit (dollars)") +
        theme_minimal()
      
    }
  
    
  })
  
  # Summary figures table 
  
  # Filter movie to obtain field of interest. Calculate summary statistics
  movies_summ_fig <- reactive(
  
  if(input$ch_field == "Production Budget"){
    
    movies %>%
      select(production_budget, genre) %>%
      group_by(genre) %>%
      summarise(obs = n(), round(describe(production_budget), 1)) %>%
      select(genre, obs, mean, sd, median, min, max)
    
  } else if(input$ch_field == "Domestic Gross Profit"){
    
    movies %>%
      select(domestic_gross, genre) %>%
      group_by(genre) %>%
      summarise(obs = n(), round(describe(domestic_gross), 1)) %>%
      select(genre, obs, mean, sd, median, min, max)
    
  } else if(input$ch_field == "Worldwide Gross Profit"){
    
    movies %>%
      select(worldwide_gross, genre) %>%
      group_by(genre) %>%
      summarise(obs = n(), round(describe(worldwide_gross), 1)) %>%
      select(genre, obs, mean, sd, median, min, max)
    
  })
  
  
  output$summary_table <- renderDataTable({
    
    DT::datatable(movies_summ_fig(), 
                  options = list(paging = TRUE, scrollX = TRUE, autoWidth = TRUE, lengthChange = FALSE,
                                 dom = "Bfrtip"), 
                  rownames = FALSE)

    
  })
 
  
  # Budget vs Profit tab ----
  # Create budget vs gross profit chart
  output$chart <- renderPlotly({
    
    # filter data
    movie_subset <- movies %>%
      dplyr::rename(Domestic = domestic_gross, Worldwide = worldwide_gross) %>%
      subset(genre %in% input$ch_genre & distributor == input$ch_distributor) 
    
    ggplot(movie_subset, 
           aes_string(x = movie_subset$production_budget, y = input$ch_geography)) +
      geom_point(aes(colour = genre, pch = genre)) + 
      
      # Add line of best fit to plot
      geom_line(stat = "smooth", method = "lm", alpha = 0.3, linetype = "dashed", aes(colour = genre)) + 
      guides(colour = FALSE) +
      # Condition axis labelling
      labs(x = "Production Budget (dollars)", 
           y = ifelse(input$ch_geography == "Domestic", "Domestic Gross Profit (dollars)", "Worldwide Gross Profit (dollars)")) +
      theme_minimal() 
    
  })
  
  
}