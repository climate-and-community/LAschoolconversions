library(tidyverse)
library(tidycensus)
library(janitor)

v23 <- load_variables(2023, "acs5", cache = TRUE)
# B25031_001 Estimate!!Median gross rent --!!Total:  Median Gross Rent by Bedrooms

# This function pulls median gross rents from ACS 5-year estimates 2019-2023 and compiles them into a single data frame. Note that these 5-year estimates overalap with each other which generally isn't advised, but I manually checked against 1-year estimates and the results were similar - plus 1-year estimates are missing for the year 2020.  
get_rent_data_5 <- function(start_year = 2019, end_year = 2023) {
  purrr::map_dfr(start_year:end_year, ~ {
    get_acs(
      geography = "place", 
      variables = c(grossrent = "B25064_001"), 
      state = "California", 
      year = .x, 
      survey = "acs5",
      output = "wide"
    ) %>% 
      clean_names() %>% 
      filter(name == 'Los Angeles city, California') %>% 
      mutate(year = .x)
  })
} 

# Run the function
rent_data_5 <- get_rent_data_5()

# salary data - l-tables.csv is a CSV downloaded from the manually created 'salary data.gsheet' in this folder. That data is hand-compiled from https://www.lausd.org/page/4045 using the lowest salary for teachers with alternate certifications.
starting_salary <- read_csv('salary data - l-tables.csv') %>%
  pivot_longer(cols = -classification, names_to = "year", values_to = "starting_salary") %>%
  mutate(year = as.numeric(year))

# Combine rent and salary tables
starting_salary_rent_data <- rent_data_5 %>%
  left_join(starting_salary, by = "year") %>%
  mutate(ratio = grossrent_e * 12 * 100 / starting_salary)

# plot
starting_salary_rent_plot <- ggplot(starting_salary_rent_data, aes(year, ratio)) +
  geom_line(size = 1, color = "#D55E00") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank()
  ) +
  scale_x_continuous(breaks = starting_salary_zillow$year) +
  scale_y_continuous(limits = c(35, 45), breaks = seq(0,100, by = 1))


# Save the plot as an SVG file. I then modified it in Illustrator for the memo.
ggsave("startingsalaryrentburden.svg", starting_salary_rent_plot, device = "svg")
