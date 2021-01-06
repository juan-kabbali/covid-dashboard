library(shiny)

source("server.R")
source("ui.R")

options(encoding = "UTF-8")

# shinny app binding UI and SERVER
shinyApp(ui, server)