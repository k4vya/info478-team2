library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyverse)

# Set up data
state_income <- read.csv("data/household_median_income_2017.csv")
overdose_deaths <- read.csv("data/drug_overdose_deaths.csv")

# Merge Datasets
income_vs_deaths <- merge(state_income, overdose_deaths, by = 'State')
income_vs_deaths_2017 <- income_vs_deaths %>% select(State, X2017, X2017.Number.of.Deaths)

# Making plot
ggplot(income_vs_deaths_2017, aes(fill=X2017, y=X2017.Number.of.Deaths, x=State)) + 
  geom_bar(position="dodge", stat="identity")
ggplot() boxplot(income_vs_deaths_2017)    