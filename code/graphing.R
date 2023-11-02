# Graphs

source("~/GitHub/sample_code/code/reading_econdata.R")
source("~/GitHub/sample_code/code/graph_theme.R")
source("~/GitHub/sample_code/code/data_wrangling.R")

g_data <- data %>%
  select(-`inflation`) %>% 
  pivot_longer(-date, names_to = "indicator", values_to = "values") %>%
  ggplot(aes(x = date, y = values, color = indicator)) +
  geom_line(size=0.7) +
  labs(title="National Accounts", 
       subtitle="South Africa",
       x = "Date",
       y = "Indicator")+
  facet_wrap(~indicator, scales= "free", nrow = 5)+
  scale_colour_manual(values=c(core))+
  graph_theme() +
  theme(legend.position="none")
core <- c("#14213D",    
          "#FCA311",    
          "#999999",    
          "#7D3400",    
          "#000000",    
          "#1B3A5A",    
          "#333333",    
          "#E86900",    
          "#FFFFFF")  
g_growth_rates <-
  ggplot() +
  geom_hline(
    yintercept = 0,
    linetype = "dotted",
    colour = "black",
    size = 0.3
  ) +
  geom_line(data=growth_rates %>% filter(account != "GDP"),
            aes(x = date, y = accounts_dot, color = account),
            size=0.7) +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account !="GDP") %>% 
      filter(date == last(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = c("#14213D", "#999999","#333333")) +
  labs(title="Growth Rates", 
       subtitle="South Africa",
       x = "Date",
       y = "Growth Rate")+
  scale_colour_manual(values=c(core))+
  graph_theme() +
  theme(legend.position="none",axis.line.x = element_blank())

g_growth_rates_gpd <-
  ggplot() +
  geom_hline(
    yintercept = 0,
    linetype = "dotted",
    colour = "black",
    size = 0.3
  ) +
  geom_line(data=growth_rates %>% filter(account != "GDP"),
            aes(x = date, y = accounts_dot, color = account),
            size=0.7) +
  geom_line(data=growth_rates %>% filter(account=="GDP"),
            aes(x = date, y = accounts_dot, color = account),
            size=0.7, colour="#E86900") +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account !="GDP") %>% 
      filter(date == last(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = c("#14213D", "#999999","#333333")) +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account=="GDP",date>="2003-06-30") %>% 
      filter(date == first(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = "#E86900") +
  labs(title="Growth Rates", 
       subtitle="South Africa",
       x = "Date",
       y = "Growth Rate")+
  scale_colour_manual(values=alpha(c(core),0.3))+
  graph_theme () +
  theme(legend.position="none",axis.line.x = element_blank())

g_proportions<- data %>% 
  mutate(date=as.Date(date)) %>% 
  select(date, Consumption, `Government Spending`, Investment) %>% 
  pivot_longer(-date, names_to="account", values_to="values") %>% 
  ggplot() +
  geom_area(
    aes(x = date, y = values, fill = account),
    position = "fill")+
  scale_y_continuous(
    expand = c(0, 0)) + 
  scale_x_date(
    expand = c(0, 0),
    date_breaks="2 years", 
    date_labels="%Y")+
  graph_theme() +
  scale_fill_manual(
    values = c(core), 
    guide = guide_legend(reverse = FALSE))

g_inflation <-
  ggplot() +
  geom_hline(
    yintercept = 0,
    linetype = "dotted",
    colour = "black",
    size = 0.3
  ) +
  geom_line(data=inflation %>% 
            pivot_longer(-date, names_to="variable", values_to="values"),
            filter(variable="inflation"),
            aes(x = date, y = values, color = variable),
            size=0.7) +
  geom_line(data=growth_rates %>% filter(account=="GDP"),
            aes(x = date, y = accounts_dot, color = account),
            size=0.7, colour="#E86900") +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account !="GDP") %>% 
      filter(date == last(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = c("#14213D", "#999999","#333333")) +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account=="GDP",date>="2003-06-30") %>% 
      filter(date == first(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = "#E86900") +
  labs(title="Growth Rates", 
       subtitle="South Africa",
       x = "Date",
       y = "Growth Rate")+
  scale_colour_manual(values=alpha(c("#14213D", "#999999","#333333"),0.3))+
  graph_theme () +
  theme(legend.position="none",axis.line.x = element_blank())


ggsave(file.path("figures","g_data.png"), plot=g_data, width=5, height=6)

ggsave(file.path("figures","g_growth_rates.png"), plot=g_growth_rates, width=5, height=6)

ggsave(file.path("figures","g_growth_rates_gdp.png"), plot=g_growth_rates_gpd, width=5, height=6)

ggsave(file.path("figures","g_proportions.png"), plot=plot_data, width=5, height=6)

ggsave(file.path("figures","g_inflation"), plot=g_inflation, width=5, height=6)



