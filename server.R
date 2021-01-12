library(plotly)

source("data/db.R")

# define server logic
server <- function(input, output) {

  # flag to know if display cumulated line
  cumulated <- reactive({ input$cumulated })

  # dynamic text
  output$txt_total_count_var <- renderText({
    paste("Comptage total de ", indicators[[input$indicators]][["name"]])
  })

  # dynamic text
  output$txt_cumulated_count_var <- renderText({
    paste("Comptage Cumulé de ", indicators[[input$indicators]][["name"]])
  })

  # get the selected indicator count value
  output$val_total_count_var <- renderText({
    getIndicatorCount(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]])
   })

  # get the selected cumulated indicator value
  output$val_cumulated_count_var <- renderText({
    getIndicatorCount(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]])
  })

  # dynamic text
  output$historic_bars_title <- renderText({
    paste("Total", indicators[[input$indicators]][["name"]], "par", time_segments[[input$time_segment]][["name"]])
  })

  # plot bars
  output$val_historic_bars <- renderPlotly({
    data <- getHistoric(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]],
                        cumulated = cumulated(), groupBy = input$time_segment)
    fig <- plot_ly(x = data$date, y = data$indicator_sum, type = "bar", name = "total")

    if (cumulated()) {
      fig <- add_trace(fig, x = data$date, y = data$cumulative_sum, type = "scatter", mode = "lines+markers",
                       name = "cumulé")
    }
    return(fig)
  })

  # geosegment input value
  geo_segment <- reactive({ input$geo_segment })

  # dynamic text
  output$map_title <- renderText({
    paste("Total", indicators[[input$indicators]][["name"]], "par", input$geo_segment)
  })

  # map plot
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

  # dynamic text
  output$historic_tests_title <- renderText({
    paste("Tests positifs vs Nombre de Tests par", time_segments[[input$time_segment]][["name"]])
  })

  # tested vs positive plot
  output$historical_tests <- renderPlotly({
    table_name <- "fact_test"
    data_positives <- getHistoric("positive_tests", table_name, cumulated = FALSE, groupBy = input$time_segment)
    data_tests <- getHistoric("tests", table_name, cumulated = FALSE, groupBy = input$time_segment)

    fig <- plot_ly(x = data_positives$date, y = data_tests$indicator_sum, type = "scatter", name = "# tests",
                   mode = "lines+markers", fill = "tozeroy")
    fig <- add_trace(fig, x = data_positives$date, y = data_positives$indicator_sum, mode = "lines+markers",
                     name = "# positifs")
    return(fig)
  })

  # positives by age pie plot
  output$positives_age <- renderPlotly({
    data <- getIndicatorCountBy("positive_tests", "fact_test", "id_age",
                                "age", "dim_age", "id")

    fig <- plot_ly(data, labels = ~segment, values = ~indicator_sum, type = 'pie')
    fig <- fig %>% layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                          yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
}