library(tidyverse)
# ---------- cleaning ------------------
pharma_rev_data <- read.csv("data/pharma_rev_2009_2012.csv")

pharma_rev_data$Revenue_millions <- gsub(",","",pharma_rev_data$Revenue_millions)

typeof(pharma_rev_data$Revenue_millions)

pharma_rev_data$Revenue_millions =  as.numeric(pharma_rev_data$Revenue_millions)


