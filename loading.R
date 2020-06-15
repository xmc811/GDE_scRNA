
packages <- c("shiny", 
              "shinythemes", 
              "shinyWidgets",
              "tidyverse", "magrittr","DT", 
              "RColorBrewer",
              "fgsea")

lapply(packages, require, character.only = TRUE)