library(plotly)

source("conf/indicators.R")

# define user interface
ui <- fluidPage(

  # landing page COVID-19
  htmlTemplate("www/components/header.html"),

  # row for inputs
  fluidRow(
    column(6, wellPanel(
      # indicators selectable
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
      # geolocation selectable
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
                # date dimention selectable
                selectInput("time_segment", "Ragrouper date par:",
                             choices = c( "Jour" = "d", "Semaine" = "w", "Mois" = "m", "Trimestre" = "q"))
             )),

             # count bootstrap card
             column(6, htmlTemplate("www/components/card.html",
                                   color = "panel-danger",
                                   value = textOutput("val_total_count_var"),
                                   title = textOutput("txt_total_count_var"))),
           ),
           fluidRow(
              column(12,
                     # historic bar plot
                     h1(textOutput("historic_bars_title"), class = "text-center"),
                     plotlyOutput("val_historic_bars"))
           ),
    ),
    column(6,
           # map plot
           h1(textOutput("map_title"), class = "text-center"),
           plotlyOutput("map", height = "100%"))
  ),

  hr(),

  fluidRow(
    column(6,
           # tested vs positive plot
           h1(textOutput("historic_tests_title"), class = "text-center"),
           plotlyOutput("historical_tests")),
    column(6,
           # positives by age
           h1("Cas Positifs par Tranche d'age", class = "text-center"),
           plotlyOutput("positives_age"))
  )
)