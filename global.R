library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(shinyWidgets)
library(googleVis)

data = read.csv("./data/Science_Math_Fifth_Clean.csv")

data = data[,-1]

names = colnames(data)[7:51]

source("./helper.R")
