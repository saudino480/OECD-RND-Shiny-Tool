library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(shinyWidgets)
library(googleVis)
library(DT)

source("./helper.R")

data = read.csv("./data/Science_Math_Seventh_Clean.csv")

#remove index column

data = data[,-1]

#fix column names that have had a "." introducted.

temp = colnames(data)[7:20]

temp = unlist(lapply(temp, gsub, pattern = "[.]", replacement = " "))

names = temp

colnames(data)[7:20] = names

#lets get some data labels for later

data_labels = colnames(data)[1:6]

raw_types = label_extractor(unique(data$Unit), c(1,2,4,10))

pc_types = label_extractor(unique(data$Unit), c(3,5,7))


