# File name: global.R

# Written/ run on: RStudio
# R version 4.3.1 (2023-06-16) -- Beagle Scouts"

# Create Shiny Dashboard 

# Jessie, October 2023 

###############################################################################.
# Load packages 
library(shiny)
library(shinyWidgets)
library(shinythemes) # Theme of app
library(shinydashboard) # Value and info boxes
library(dplyr) # Data manipulation
library(plotly) # Charts 
library(DT) # Data tables
library(psych) # Summary statistics

###############################################################################.
# Set working directory 
setwd("/Users/jessieli/Desktop/Projects/movies/02_app_code")

###############################################################################.
# Load data ----
movies <- readRDS("data/movies.rds")

###############################################################################.
# Objects used in outputs ----
genre_list <- sort(unique(movies$genre))
year_list <- sort(unique(movies$release_year), decreasing = TRUE)
dist_list <- sort(unique(movies$distributor))

### END OF SCRIPT ####
