library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(reshape)
library(ggrepel)

# Set up data
state_income <- read.csv("data/household_median_income_2017.csv")
overdose_deaths <- read.csv("data/drug_overdose_deaths.csv")

# Merge Datasets
income_vs_deaths <- merge(state_income, overdose_deaths, by = 'State')
income_vs_deaths_2017 <- income_vs_deaths %>% select(State, X2017, X2017.Number.of.Deaths)
names(income_vs_deaths_2017)[2] <- "income"
names(income_vs_deaths_2017)[3] <- "deaths"

# convert income to an integer 
income_vs_deaths_2017$income <- gsub(",","",income_vs_deaths_2017$income)
income_vs_deaths_2017$income =  as.numeric(income_vs_deaths_2017$income)

# Making plot
income_vs_deaths_2017_plot <- ggplot(income_vs_deaths_2017, aes(x = income, y= deaths, label =State)) + geom_point() +
  geom_label_repel(aes(label = State, x = income, y = deaths), box.padding = 0.35, point.padding = 0.5)

