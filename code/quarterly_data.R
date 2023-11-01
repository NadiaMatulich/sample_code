# Quarterly Data

quarterly_msi<-semi_rsd %>% 
  mutate(qdate = ceiling_date(date, "quarter")-days(1)) %>%
  group_by(qdate, index) %>%
  arrange(desc(date)) %>% 
  summarise(values = mean(semi_rsd)) %>% 
  pivot_wider(names_from="index", values_from="values") %>% 
  rename(date=qdate)

data <- left_join(econ_data,repo, by = "date") %>%
  left_join(gold, by="date") %>%
  left_join(dollar, by="date") %>% 
  left_join(jse, by="date") %>% 
  left_join(ber_data, by = "date") %>% 
  left_join(quarterly_msi, by="date") %>% 
  filter(date<="2023-01-01") %>% 
  select(-resid,-gde,-emi,-environment)

# sector_data<-left_join(sectors, quarterly_msi, by = "date") %>%
#   left_join(gold, by="date") %>%
#   left_join(dollar, by="date") %>% 
#   left_join(jse, by="date") %>% 
#   left_join(repo, by="date") %>% 
#   left_join(ber_data, by = "date") %>% 
#   filter(date<="2023-01-01") %>% 
#   filter(date!="2020-03-31")
