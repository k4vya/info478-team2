library(tidyverse)
# ---------- cleaning ------------------
pharma_rev_data <- read.csv("data/pharma_rev_2009_2012.csv")

pharma_rev_data$Revenue_millions <- gsub(",","",pharma_rev_data$Revenue_millions)

typeof(pharma_rev_data$Revenue_millions)

pharma_rev_data$Revenue_millions = as.numeric(pharma_rev_data$Revenue_millions)


od_data <- read.csv("data/overdose_1999_2014.csv")
od_data$Deaths = as.numeric(od_data$Deaths)

od_data<- od_data %>% drop_na(Deaths)

meep <- pharma_rev_data %>% 
  group_by(Year) %>% 
  summarize(Sum_Revenue = sum(Revenue_millions))

herm <- od_data %>% 
  group_by(Year) %>% 
  summarize(deaths_total = sum(Deaths)) %>% 
  filter(Year >= 2009, Year <= 2012)

deaths_sales <- data.frame(herm$Year, herm$deaths_total, meep$Sum_Revenue)

comp_scatter <- ggplot(data = deaths_sales, aes(x = herm.deaths_total, 
                      y = meep.Sum_Revenue)) + geom_point() + geom_text(label = deaths_sales$herm.Year) + labs(title = "Opiate Related Deaths vs Pharma Company Revenues, 2009 to 2012", x = "Deaths by Opiates", y = "Pharma Company Revenues (millions)")

deaths_2011 <- herm$deaths_total[3]
revenue_2012 <- meep$Sum_Revenue[4]


