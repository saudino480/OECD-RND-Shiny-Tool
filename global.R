library(shiny)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)
library(shinyWidgets)
library(googleVis)

data = read.csv("./data/Science_Math_First_Clean.csv")

source("./helper.R")
