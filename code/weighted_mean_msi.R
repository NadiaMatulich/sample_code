# Weighted Mean

merging_data<-semi_rsd %>% 
  select(date,semi_rsd,index) %>%
  pivot_wider(names_from="index",values_from="semi_rsd") %>% 
  select(-global)

weighted_mean<-function(){
  
  weighted_mean<-
    long_counts %>% 
    filter(index %in% c("economy","industry","markets","politics")) %>% 
    group_by(date) %>% 
    mutate(freq=counts/sum(counts)) %>% 
    select(date,index,freq) %>% 
    pivot_wider(names_from="index", values_from="freq") %>% 
    left_join(merging_data, by="date") %>% 
    replace(is.na(.),0) %>% 
    mutate(e=economy.x*economy.y,
           s=markets.x*markets.y,
           i=industry.x*industry.y,
           p=politics.x*politics.y)%>% 
    select(date,i,e,s,p) %>% 
    mutate(weighted_mean=rowSums(across(where(is.numeric)))) %>% 
    select(date,weighted_mean)
  
  weighted_mean
  
}

weighted_mean<-weighted_mean()


#wide_rsd<-semi_rsd %>% pivot_wider(names_from="index", values_from="semi_rsd")
