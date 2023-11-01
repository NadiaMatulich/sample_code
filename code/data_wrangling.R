
# Some Data Wrangling


# Convert inflation from monthly to quarterly

inflation<-inflation %>% 
  mutate(qdate = ceiling_date(date, "quarter")-days(1)) %>%
  group_by(qdate) %>%
  arrange(desc(date)) %>% 
  summarise(inflation = mean(inflation)) %>% 
  rename(date=qdate)

# Join Data to one table

data <- full_join(econ_data,inflation, by = "date") %>% 
  filter(date<="2020-03-31",date>="2003-03-31")

# Create growth rates table for C, I, G and GDP

growth_rates<-data %>% 
  select(date, `Consumption`, `Investment`, `Government Spending`, `GDP`) %>% 
  pivot_longer(-date, names_to="account", values_to="values") %>% 
  group_by(account) %>% 
  mutate(accounts_dot=round((((values/lag(values,1))-1)*100),2)) %>% 
  select(-values)

proportions<-data %>% 
  select(-`GDP`,-`GDE`,-`inflation`,-`Residual`) %>% 
  mutate(`Net Exports`=`Exports`-`Imports`) %>% 
  select(-`Exports`,-`Imports`) %>% 
  pivot_longer(-date, names_to="account", values_to="values") %>%
  group_by(date) %>% 
  mutate(proportion=round((values/sum(values)),3)) %>% 
  select(date,account,proportion)
