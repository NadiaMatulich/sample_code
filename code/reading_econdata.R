# Reading in Economic Data Using Codera

# National Accounts

library(tidyverse)
library(econdatar)
library(lubridate)
library(scales)
library(ggrepel)
library(tibbletime)
library(readxl)
library(lemon) 
library(tseries)
library(forecast)
library(stargazer)
library(gridExtra)
library(tinytex)
library(kableExtra)

# From Econdata portal by codera, import the key national accounts variables

# data is real seasonally adjusted 
econ_data<-function(){
  
  names<-c(
    "GDP",
    "Consumption",
    "Government Spending",
    "Investment",
    "Residual",
    "GDE",
    "Exports",
    "Imports"
    
  )
  
  econ_data<-read_econdata(
    agencyid = "ECONDATA",
    id = "NATL_ACC",
    version = "1.4",
    key = "KBP6006+KBP6007+KBP6008+KBP6009+KBP6010+KBP6011+KBP6012+KBP6013+KBP6014.R.S",
    provideragencyid = "ECONDATA",
    providerid = "SARB",
    releasedescription = "2023-08-01") %>% 
    imap_dfc(~ set_names(.x,.y)) 
  
  econ_data <- econ_data %>%
    rename(!!!setNames(names(econ_data), names)) %>% 
    mutate(date=rownames(.)) %>% 
    as_tibble() %>% 
    mutate(date=ymd(date)) %>% 
    select(date, everything()) %>% 
    filter(date>="2003-01-01")
}

econ_data<-econ_data() 

# next import inflation data from a file in the data folder
# monthly data is converted to quarterly using mean 

inflation<- read_excel("data/inflation.xlsx") %>% 
  as_tibble() %>% 
  rename(Inflation=inflation)
