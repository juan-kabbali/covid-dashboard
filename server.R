library(shinymaterial)

# define server logic
server <- function(input, output) {

  # output$caption and output$mpgPlot functions
  output$selected_indicator_name <- renderText({
    selected <- input$indicators
    indicators$selected$name
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