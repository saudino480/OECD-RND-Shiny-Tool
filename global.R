library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(shinyWidgets)
library(googleVis)

data = read.csv("./data/Science_Math_Seventh_Clean.csv")

data = data[,-1]

names = colnames(data)[7:20]

raw_types = label_extractor(unique(data$Unit), c(1,2,4,10))

pc_types = label_extractor(unique(data$Unit), c(3,5,7))


source("./helper.R")
