library(tidyverse)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(reshape)

# Set up data
state_income <- read.csv("data/household_median_income_2017.csv")
overdose_deaths <- read.csv("data/drug_overdose_deaths.csv")

# Merge Datasets
income_vs_deaths <- merge(state_income, overdose_deaths, by = 'State')
income_vs_deaths_2017 <- income_vs_deaths %>% select(State, X2017, X2017.Number.of.Deaths)
names(income_vs_deaths_2017)[2] <- "income"
names(income_vs_deaths_2017)[3] <- "deaths"
mdata <- melt(income_vs_deaths_2017, id="State")

# Making plot
income_vs_deaths_2017_plot <- ggplot(mdata, aes(fill=value, y=variable, x=State)) + 
  geom_bar(position="dodge", stat="identity")
