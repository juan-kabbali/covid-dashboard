library(shinymaterial)
library(plotly)
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
      checkboxInput("cumulated", "Montrer le cumulé", FALSE)
    )),
    column(6, wellPanel(
      selectInput("geo_segment", "Ragrouper par:", choices = c( "Région" = "region", "Département" = "departement")),
      br(),
      br()
    ))
  ),

  hr(),

  fluidRow(
    column(6,
           fluidRow(
             column(6, wellPanel(
                selectInput("time_segment", "Ragrouper date par:",
                             choices = c( "Jour" = "d", "Semaine" = "w", "Mois" = "m", "Quarter" = "q"))
             )),

             column(6, htmlTemplate("www/components/card.html",
                                   color = "panel-danger",
                                   value = textOutput("val_total_count_var"),
                                   title = textOutput("txt_total_count_var"))),
           ),
           fluidRow(
              column(12,
                     h1(textOutput("historic_bars_title"), class = "text-center"),
                     plotlyOutput("val_historic_bars"))
           ),
    ),
    column(6,
           h1(textOutput("map_title"), class = "text-center"),
           plotlyOutput("map", height = "100%"))
  ),

  hr(),

  fluidRow(
    column(6,
           h1(textOutput("historic_tests_title"), class = "text-center"),
           plotlyOutput("historical_tests")),
    column(6,
           h1("Cas Positifs par Tranche d'age", class = "text-center"),
           plotlyOutput("positives_age"))
  )
)