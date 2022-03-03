###############################################################################
###    State Overdose Rates    ################################################
###############################################################################

# Code to make a map of opiod overdose death rates (per 100,000) across states

# Load packages
library("tidyverse")
library("maps")
library("leaflet")
library("mapproj")

# Load raw data
overdose_df_raw <- data.frame(read.csv("data/drug_overdose_deaths.csv"))

# Clean up data, renaming column names 
# (USE THIS BASE DATA for future!) 
overdose_df <- overdose_df_raw %>% 
  dplyr::rename(c(state = State,
           abbrev = State.Abbreviation,
           aa_rate_2019 = X2019.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2019 = X2019.Number.of.Deaths,
           aa_rate_2018 = X2018.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2018 = X2018.Number.of.Deaths,
           aa_rate_2017 = X2017.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2017 = X2017.Number.of.Deaths,
           aa_rate_2016 = X2016.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2016 = X2016.Number.of.Deaths,
           aa_rate_2015 = X2015.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2015 = X2015.Number.of.Deaths,
           aa_rate_2014 = X2014.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2014 = X2014.Number.of.Deaths,
           aa_rate_2013 = X2013.Age.adjusted.Rate..per.100.000.population.,
           num_deaths_2013 = X2013.Number.of.Deaths,
           poverty_rate_2019 = X2019.Poverty.rate..percent.of.persons.in.poverty.,
           GDP_percap_2021 = GDP.per.capita.2021,
           perc_urban_pop_2010 = Urban.population.as.a.percentage.of.the.total.population.in.2010,
           pop_density = Population.density.per.km,
           population = Population,
           area_kmsq = Land.Area))


# Reformat state names in overdose_df to be all lowercase, for future merging
# with state shapefile
overdose_df$state = tolower(overdose_df$state)

# Load US state shapefile data 
# Rename "region" column name to "state" for future merging with overdose_df
state_shape <- map_data("state") %>% 
  dplyr::rename(state = region)

# Join overdose_df with US state shapefile
state_od_df <- left_join(state_shape, overdose_df, by="state")


# Develop a minimalist theme to apply to maps (set of formatting commands)
blank_theme <- theme_bw() +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Make a map of opioid overdose rates (age-adjusted in 2019) for each state
od_rate_2019_map <- ggplot(state_od_df) +
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = aa_rate_2019),
               color = "black",
               size = 0.1) +
  coord_map() +
  # scale_fill_continuous(low = "#132B43", high = "Red") +
  scale_fill_distiller(palette = "YlOrRd", direction = 1) +
  labs(fill = "Rate per 100,000",
       title = "Age-Adjusted Rate of Opiod Overdose by State (2019)") +
  blank_theme +
  # theme(panel.background = element_rect(fill = "#DCDCDC", color = "#DCDCDC"))
  theme(panel.background = element_rect(fill = "#505772"))







         