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

  output$val_historic_bars <- renderPlotly({
    data <- getHistoric(indicators[[input$indicators]][["column"]], indicators[[input$indicators]][["table"]],
                        cumulated = cumulated(), groupBy = input$time_segment)
    fig <- plot_ly(x = data$date, y = data$indicator_sum, type = "bar", name = "total", showskipes = TRUE, spikemode = "across+toaxis")

    if (cumulated()) {
      fig <- add_trace(fig, x = data$date, y = data$cumulative_sum, type = "scatter", mode = "lines+markers", name = "cumulé")
    }
    return(fig)
  })

  geo_segment <- reactive({ input$geo_segment })

  map_title <- reactive({
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
    fig <- fig %>% layout(geo = geo_conf, title = map_title())
    fig
  })

  # generate a plot of the requested variable against mpg
  #output$historicPlot <- renderPlot({
  #  boxplot(as.formula(formulaText()),
  #          data = mpgData,
  #          outline = input$outliers,
  #          col = "#75AADB", pch = 19)
  #})

  output$historicPlot <- renderText({ "HI" })

  output$totalCount <- renderText({ 58450 })

  output$cumulatedCount <- renderText({ "HI" })

}