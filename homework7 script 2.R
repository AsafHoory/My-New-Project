#script 2 done by Asaf Hoory at 21/12/2024

#loading df
load("C:/Users/LENOVO/Desktop/R/df.rdata")
library(dplyr)

#Filtering of non-relevant trials
number_of_participnants = n_distinct(df$subject)
df <- df |> filter(!is.na(rt))
df <- df |> filter(rt <= 3000 & rt >= 300)

#calculating the valid trials percentage
df |> group_by(subject) |>
  summarise(percentage = n() / 400) |> 
  print (n = Inf)

#calculating the mean and sd of removed trials
df_summary <- df |> 
  group_by(subject) |> 
  summarise(percentage_removed = 1 - (n() / 400))
average_removed <- mean(df_summary$percentage_removed)
sd_removed <- sd(df_summary$percentage_removed)



