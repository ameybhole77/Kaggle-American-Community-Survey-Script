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

# Visualize the number of Bachelor, Master and PhD holders   
ggplot(degree_holders, aes(x = Degree, y = count, fill = Degree)) +                        
  geom_bar(stat = "identity") +
  xlab("Degree") + 
  ylab("No of People") + 
  ggtitle("Comparing Degree Holders in the US")

# Take 5000 random samples of 1000 observations & calculate median income
over_thousand <- ac_survey_clean %>%
  filter(PINCP > 1000) %>% # exclude obserations with income under 1000
  group_by(Degree) 

freq <- 5000 # 5000 samples
income <- NULL
for (i in 1:freq) {
  # Select 1000 observations
  sample <-  sample_n(over_thousand, 1000)
  
  # Calculate stats by degree
  sample_stats <- summarise(sample, 
                            MinIncome = min(PINCP), 
                            MaxIncome = max(PINCP),
                            MedianIncome = median(PINCP),
                            IncomeRange = IQR(PINCP))
  
  income <- rbind(income, sample_stats)
}

# Create the boxplots
ggplot(income, aes(x = Degree, y = MedianIncome, fill = Degree)) +  
  geom_boxplot() +
  ggtitle("Comparing Income of Degrees Holders") 
