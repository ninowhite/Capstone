library("ggplot2")

library(shiny)
shinyUI(fluidPage(
        titlePanel("John Hopkins Capstone Project"),
        headerPanel(
                tags$style(type="text/css",
                ".shiny-output-error { visibility: hidden; }",
                ".shiny-output-error:before { visibility: hidden; }")),
        sidebarPanel(
                h3("How to Use App"),
                p("Simply start typing text in the Input Text box and the top prediction will begin to display."),
                h6("Note: please use lowercase"),
                textInput("id1", label = "Input Text", value = ""),
                h5("Next Word Choices"),
                verbatimTextOutput("words")),
        mainPanel(
                tabsetPanel(type = "tabs",
                            tabPanel("WordCloud", h3("Top 50 Corpus Non-StopWords", align = "center"),
                                plotOutput("plot2")),
                            tabPanel("BiGram", h3("Top 10 Corpus BiGrams"), align = "center",
                                plotOutput("plot5")),
                            tabPanel("TriGram", h3("Top 10 Corpus TriGrams"), align = "center",
                                plotOutput("plot4")),
                            tabPanel("4Gram", h3("Top 10 Corpus 4Grams"), align = "center",
                                plotOutput("plot3"))
                            ))
        ))


