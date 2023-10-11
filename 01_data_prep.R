# File name: 01_data_prep.R

# Written/ run on: RStudio
# R version 4.3.1 (2023-06-16) -- Beagle Scouts"

# Prepare data set for app 

# Output is saved to folder: 02_app_code\data

# Jessie, October 2023 

###############################################################################.
# Load packages
library(dplyr)

###############################################################################.
# Set working directory 
setwd("/Users/jessieli/Desktop/Projects/movies")

###############################################################################.
# Read in data set of interest 
movies <- read.csv(file = "input/movies.csv", header = TRUE) %>%
  # Remove row number field
  select(-X)

# Convert class of release date from character to date
# Add additional fields representing release year and release month
movies <- movies %>%
  mutate(release_date = as.Date(release_date, format = "%m/%d/%Y")) %>%
  mutate(release_year = as.numeric(format(release_date, "%Y"), .after = release_date)) 

# Save as RDS file 
saveRDS(movies, file = "02_app_code/data/movies.rds")

### END OF SCRIPT ####



