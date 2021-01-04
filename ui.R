library(shinymaterial)
source("conf/indicators.R")

# define user interface
ui <- fluidPage(

  # app title
  titlePanel("COVID-19 EN FRANCE"),

  # row for inputs
  fluidRow(
    column(6, wellPanel(
      selectInput("indicators", "Indicateur:",
                  choices = c( "Cas Positifs" = "cp",
                               "Décés" = "dec",
                               "Hospitalisations" = "hosp",
                               "Réanimation" = "rea",
                               "Rétour à Domicile" = "rad",
                               "Urgences" = "urgs")),
      checkboxInput("cumulated", "Montrer le cumulé", TRUE)
    )),
    column(6, wellPanel(
      selectInput("indicatore", "Indicateur:",
                  choices = c( "Cas positifssss" = "cp",
                               "Décés" = "dec",
                               "Hospitalisations" = "hosp",
                               "Réanimation" = "rea",
                               "Rétour à domicile" = "rad",
                               "Urgences" = "urgs")),
      checkboxInput("cumulated", "Montrer le cumulé", TRUE)
    ))
  ),

  hr(),

  fluidRow(
    column(6,
           fluidRow(
            column(6, htmlTemplate("www/components/card.html",
                                   color = "panel-warning",
                                   value = "cumulatedCount",
                                   title = paste("Comptage Cumulé de ", textOutput("selected_indicator_name")))),

            column(6, htmlTemplate("www/components/card.html",
                                   color = "panel-danger",
                                   value = "cumulatedCount",
                                   title = "Comptage Total")),
           )),

          fluidRow('totalCount'),
    column(6, "totalCount")
  ),

  fluidRow(
    column(6, 'totalCount'),
    column(6, "totalCount")
  )


  #htmlTemplate("www/components/card.html", value = textOutput("cumulatedCount"))
  #htmlTemplate("www/components/card.html", value = textOutput("totalCount"))

      # output: Formatted text for caption
      #h3(textOutput("caption")),

      # Output: Plot of the requested variable against mpg

      # Output: Plot of the requested variable against mpg
      #htmlOutput("cumulatedCount")
)