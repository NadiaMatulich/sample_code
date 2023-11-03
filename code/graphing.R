# Graphs

source("~/GitHub/sample_code/code/reading_econdata.R")
source("~/GitHub/sample_code/code/graph_theme.R")
source("~/GitHub/sample_code/code/data_wrangling.R")


# Plotting data to establish first visualisation

g_data <- data %>%
  select(-`Inflation`) %>% 
  pivot_longer(-date, names_to = "indicator", values_to = "values") %>%
  ggplot(aes(x = date, y = values, color = indicator)) +
  geom_line(size=0.7) +
  labs(title="National Accounts", 
       subtitle="South Africa",
       x = "Date",
       y = "Amount (Rand, Millions)")+
  facet_wrap(~indicator, scales= "free", nrow = 5)+
  scale_colour_manual(values=c(core))+
  graph_theme() +
  theme(legend.position="none")

# Plotting growth rates for Consumption, Government Spending and Investment

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
    color = c("#14213D", "#999999","#1B3A5A")) +
  labs(title="Growth Rates", 
       subtitle="South Africa",
       x = "Date",
       y = "Growth Rate")+
  scale_colour_manual(values=c("#14213D", "#999999","#1B3A5A"))+
  graph_theme() +
  theme(legend.position="none",axis.line.x = element_blank())


# Plotting the same graph as above but with GDP growth superimposed 

# Hoping to see how sensitive GDP is (graphically) to spikes in C I and G

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
            size=1, colour="#E86900") +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account !="GDP") %>% 
      filter(date == last(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = alpha(c("#14213D", "#999999","#1B3A5A"),0.7)) +
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
  scale_colour_manual(values=alpha(c("#14213D", "#999999","#1B3A5A"),0.5))+
  graph_theme () +
  theme(legend.position="none",axis.line.x = element_blank())

# Observing relative sizes of Consumption, Government Spending and Investment

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
  labs(title="Proportions of National Accounts", 
       subtitle="South Africa",
       x = "Date",
       y = "Proportion")+
  graph_theme() +
  scale_fill_manual(
    values = c(core), 
    guide = guide_legend(reverse = FALSE))

# Plotting inflation and GDP to get a sense of how the two relate to each other

g_inflation <-
  ggplot() +
  geom_hline(
    yintercept = 0,
    linetype = "dotted",
    colour = "black",
    size = 0.3
  ) +
  geom_line(data=data %>% 
            pivot_longer(-date, names_to="variable", values_to="values") %>% 
            filter(variable=="Inflation"),
            aes(x = date, y = values, color = variable),
            colour="#14213D",
            size=0.7) +
  geom_line(data=growth_rates %>% filter(account=="GDP"),
            aes(x = date, y = accounts_dot, color = account),
            size=0.7, colour="#E86900") +
  geom_label_repel(
    data=data %>% 
      pivot_longer(-date, names_to="variable", values_to="values") %>% 
      filter(variable=="Inflation") %>% 
      filter(date == last(date)),
    aes(x = date, y = values, label=variable),
    color = "#14213D") +
  geom_label_repel(
    data = growth_rates %>% 
      filter(account=="GDP") %>% 
      filter(date == last(date)),
    aes(x = date, y = accounts_dot, label=account),
    color = "#E86900") +
  labs(title="Growth Rates", 
       subtitle="South Africa",
       x = "Date",
       y = "Growth Rate")+
  graph_theme () +
  theme(legend.position="none",axis.line.x = element_blank())

g_inflation

width<-6
height<-6

ggsave(file.path("figures","g_data.png"), plot=g_data, width=width, height=height)

ggsave(file.path("figures","g_growth_rates.png"), plot=g_growth_rates, width=width, height=height)

ggsave(file.path("figures","g_growth_rates_gdp.png"), plot=g_growth_rates_gpd, width=width, height=height)

ggsave(file.path("figures","g_proportions.png"), plot=g_proportions, width=width, height=height)

ggsave(file.path("figures","g_inflation.png"), plot=g_inflation, width=width, height=height)




