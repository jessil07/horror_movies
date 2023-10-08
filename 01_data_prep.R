# File name: 01_data_prep.R

# Written/ run on: RStudio
# R version 4.3.1 (2023-06-16) -- Beagle Scouts"

# Prepare data set for app 

# Output is saved to folder: \input

# Jessie, October 2023 

###############################################################################.
# Packages
library(dplyr)

###############################################################################.
# Read in data set of interest 
movies <- read.csv(file = "movies.csv", header = TRUE) %>%
  # Remove row number field
  select(-X)

# Convert class of release date from character to date
# Add additional fields representing release year and release month
movies <- movies %>%
  mutate(release_date = as.Date(release_date, format = "%m/%d/%Y")) %>%
  mutate(release_year = format(release_date, "%Y"), 
         release_month = format(release_date, "%b"), 
         .after = release_date)




