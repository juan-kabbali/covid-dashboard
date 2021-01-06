library(shinymaterial)
library(plotly)

source("data/db.R")

# define server logic
server <- function(input, output) {

  cumulated <- reactive({ input$cumulated })

  output$txt_total_count_var <- renderText({
    paste("Comptage total de ", indicators[[input$indicators]][["name"]])
  })

  output$txt_cumulated_count_var <- renderText({
    paste("Comptage Cumulé de ", indicators[[input$indicators]][["name"]])
  })

  output$val_total_count_var <- renderText({
    getIndicatorCount(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]])
   })

  output$val_cumulated_count_var <- renderText({
    getIndicatorCount(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]])
  })

  output$historic_bars_title <- renderText({
    paste("Total", indicators[[input$indicators]][["name"]], "par", time_segments[[input$time_segment]][["name"]])
  })

  output$val_historic_bars <- renderPlotly({
    data <- getHistoric(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]],
                        cumulated = cumulated(), groupBy = input$time_segment)
    fig <- plot_ly(x = data$date, y = data$indicator_sum, type = "bar", name = "total")

    if (cumulated()) {
      fig <- add_trace(fig, x = data$date, y = data$cumulative_sum, type = "scatter", mode = "lines+markers", name = "cumulé")
    }
    return(fig)
  })

  geo_segment <- reactive({ input$geo_segment })

  output$map_title <- renderText({
    paste("Total", indicators[[input$indicators]][["name"]], "par", input$geo_segment)
  })

  output$map <- renderPlotly({
    if ( geo_segment() == "departement") {
      geojson <- deparments
    }
    if ( geo_segment() == "region") {
      geojson <- regions
    }
    data <- getIndicatorCountBy(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]],
                                "id_location", geolocation[[geo_segment()]], geolocation[["table"]],
                                geolocation[["id"]])
    geo_conf <- list(fitbounds = "locations", visible = FALSE)
    fig <- plot_ly()
    fig <- fig %>% add_trace( type="choropleth", geojson=geojson, locations=data$segment, z=data$indicator_sum,
                              colorscale="Viridis", featureidkey="properties.nom")
    fig <- fig %>% layout(geo = geo_conf)
    fig
  })

  output$historic_tests_title <- renderText({
    paste("Tests positifs vs Nombre de Tests par", time_segments[[input$time_segment]][["name"]])
  })

  output$historical_tests <- renderPlotly({
    table_name <- "fact_test_virology"
    data_positives <- getHistoric("n_positive_test", table_name, cumulated = FALSE, groupBy = input$time_segment)
    data_tests <- getHistoric("n_test", table_name, cumulated = FALSE, groupBy = input$time_segment)

    fig <- plot_ly(x = data_positives$date, y = data_tests$indicator_sum, type = "scatter", name = "# tests",
                   mode = "lines+markers", fill = "tozeroy")
    fig <- add_trace(fig, x = data_positives$date, y = data_positives$indicator_sum, mode = "lines+markers",
                     name = "# positifs")
    return(fig)
  })

  output$positives_age <- renderPlotly({
    data <- getIndicatorCountBy("n_positive_test", "fact_test_virology", "id_age",
                                "AGE_RANGE", "dim_age", "ID_AGE")

    fig <- plot_ly(data, labels = ~segment, values = ~indicator_sum, type = 'pie')
    fig <- fig %>% layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
}