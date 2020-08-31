
packages <- c("shiny", 
              "shinythemes", 
              "shinyWidgets",
              "tidyverse", 
              "magrittr",
              "DT", 
              "RColorBrewer",
              "fgsea",
              "Scillus")

lapply(packages, require, character.only = TRUE)