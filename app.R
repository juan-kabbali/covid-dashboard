library(shiny)

source("server.R")
source("ui.R")

options(encoding = "UTF-8")
shinyApp(ui, server)