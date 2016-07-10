# Load packages
library(dplyr)
library(data.table)
library(ggplot2)

# Turn of scientific notation 
options(scipen = 999)

# Load Data
load("/home/amey/ac_survey.RData")

# Print head of ac_survey
head(ac_survey , 20)

# Prepare degree codes
degree_codes <- data.frame(SCHL = c(21, 22, 24), 
                           Degree = c("Bachelor", "Masters", "Doctorate"))

# Use the pipe operator and chaining 
ac_survey_clean <- ac_survey %>%
  tbl_df() %>%
  na.omit() %>%
  filter(SCHL %in% c(21,22,24)) %>%
  inner_join(degree_codes)

# Group by SCHL and count each group
degree_holders <- ac_survey_clean %>%
  group_by(Degree) %>%
  summarize(count = n())

# Print out degree_holders
degree_holders
