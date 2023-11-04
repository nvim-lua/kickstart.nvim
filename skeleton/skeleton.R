#   skeleton for *.R
#   PURPOSE:
#       observeEvent: side effect, print to console
#   USAGE:
#       interactive

library(shiny)

ui <- fluidPage(
    textInput("name", "What's your name?"),
    textOutput("greeting")
)

server <- function(input, output, session) {
    string <- reactive(paste0("Hello ", input$name, "!"))

    output$greeting <- renderText(string())
    observeEvent(input$name, {
        message("Greeting performed")
    })
}


shinyApp(ui, server)

vim:linebreak:nospell:nowrap:cul tw=78 fo=tqlnr foldcolumn=1 cc=+1 filetype=r
