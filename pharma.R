library(tidyverse)
# ---------- cleaning ------------------
pharma_rev_data <- read.csv("data/pharma_rev_2009_2012.csv")

pharma_rev_data$Revenue_millions <- gsub(",","",pharma_rev_data$Revenue_millions)

typeof(pharma_rev_data$Revenue_millions)

pharma_rev_data$Revenue_millions =  as.numeric(pharma_rev_data$Revenue_millions)


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


# bar chart of state overdoses (top 10)

#group by state
# add up deaths
# choose top 10 
# make bar chart
bc_data <- od_data %>% 
  group_by(State) %>% 
  summarize(deaths = sum(Deaths))

bc_data2 <- bc_data %>% 
  top_n(10) %>% 
  arrange(desc(deaths))

bar_chart_deaths <- ggplot(data = bc_data2, aes(x = State, y = deaths)) + 
  geom_bar(stat="identity") + coord_flip() +
  labs(title = "Top 10 States With Most Deaths by Opioid Overdoses, 1999-2014", x = "State", y = "Num. Deaths")

# prescription dispensed vs deaths 

sct_data <- od_data %>% 
  group_by(Year) %>% 
  summarize(dispensed = sum(Prescriptions.Dispensed.by.US.Retailers.in.that.year..millions.), 
            deaths = sum(Deaths))

scatter_pres_deaths <- ggplot(data=sct_data, aes(x = dispensed, y = deaths)) + 
  geom_point() + geom_smooth(method="auto", se=TRUE, fullrange=FALSE, level=0.95) +
  labs(title = "Prescriptions Dispensed (1999 - 2014) vs Opioid Deaths", x = "Prescriptions Dispensed (millions)", y = "Deaths")




