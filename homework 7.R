# R course for beginners
# Week 7
# Asaf Hoory 211671714
# date: 20/12/2024

rm(list = ls()) #cleaning the variables 
library(dplyr)
files_names = dir("C:/Users/LENOVO/Downloads/stroop_data") #creating a vector with the names of the files

#creating one data frame and benfing all the separated files into one file
df <- data.frame()
for (file in files_names) {
  df <- rbind(df, read.csv(paste0("C:/Users/LENOVO/Downloads/stroop_data/", file)))
}

#adding task, congruency, accuracy, and deleting non-relevant columns 
df <- df |>
  mutate(
    task = ifelse(grepl('word', condition), 'word_naming', 'color_naming'),
    congruency  = ifelse(grepl('incong', condition), 'incongruent', 'congruent'),
    accuracy = ifelse(participant_response == correct_response, 1, 0)
  )

#removing all the non-relevant variabels 
df <- df |> select(subject, block, trial, task, congruency, accuracy, rt)

#saving as factors
df <- df |> mutate(
  subject = as.factor(subject),
  task = as.factor(task),
  congruency = as.factor(congruency),
  block = as.numeric(block),
  trial = as.numeric(trial),
  accuracy = as.numeric(accuracy),
  rt = as.numeric(rt)
)

#checking the contrast
contrasts(df$task)
contrasts(df$congruency)

#saving
save(df, file = "C:/Users/LENOVO/Desktop/R/df.rdata")


