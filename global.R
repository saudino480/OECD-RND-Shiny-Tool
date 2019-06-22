library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(shinyWidgets)
library(googleVis)

data = read.csv("./data/Science_Math_Seventh_Clean.csv")

data = data[,-1]

names = colnames(data)[7:51]

B_ALL = "BERD performed in all industries (current PPP $)"
B_XALL = "Percentage of BERD performed in all industries (current PPP $)"

rnd = c(unique(data$MSTI.Variables), B_ALL, B_XALL)


source("./helper.R")
