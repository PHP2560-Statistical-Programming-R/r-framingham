library(shinythemes)
library(shiny)


# Define UI for application
shinyUI(
  tagList(
    navbarPage(
      # theme = "cerulean",  # <--- To use a theme, uncomment this
      "CVD Risk App",
      tabPanel(
        "Individual Risk",
        sidebarPanel(
          fluidPage(
            textInput("name", "Name:", "Name"),
            numericInput("age", "Age:", 0, min = 30, max = 100),
            radioButtons(
              "gender",
              "Gender:",
              choices = c("Male"="M", "Female"="F"),
              selected = "M"
            ),
            numericInput("bmi", "BMI:", 0, min = 10, max = 40),
            numericInput("hdl", "HDL:", 0, min = 10, max = 100),
            numericInput(
              "TOTCHOL",
              "Total Cholesterol:",
              0,
              min = 100,
              max = 405
            ),
            numericInput(
              "sbp",
              "Systolic blood pressure:",
              0,
              min = 90,
              max = 200
            ),
            radioButtons(
              "is_sbp_under_treatment",
              "is SBP under treatment:",
              choices = c("NO"=0, "YES"=1),
              selected = 0
            ),
            radioButtons(
              "smoking_status",
              "Smoking:",
              choices = c("NO"=0, "YES"=1),
              selected = 0
            ),
            radioButtons(
              "diabetes_status",
              "Diabetic:",
              choices = c("NO"=0, "YES"=1),
              selected = 0
            ),
            tags$h5("Deafult actionButton:"),
            actionButton("action", "Search"),

            tags$h5("actionButton with CSS class:"),
            actionButton("action2", "Action button", class = "btn-primary")
          )
        )
        ,
        mainPanel(tabsetPanel(
          tabPanel(
            "Result",
            plotOutput("cvdRadarPlot"),


            h4("Table"),
            tableOutput("cvdTable"),
            h4("Verbatim text output"),
            verbatimTextOutput("txtout"),
            h1("Header 1"),
            h2("Header 2"),
            h3("Header 3"),
            h4("Header 4"),
            h5("Header 5")
          )
        ))
      ),
      tabPanel(
        "Population Risk",
        sidebarPanel(
          fileInput("file", "File input:"),
          textInput("txt", "Text input:", "general"),
          sliderInput("slider", "Slider input:", 1, 100, 30),
          tags$h5("Deafult actionButton:"),
          actionButton("action", "Search"),

          tags$h5("actionButton with CSS class:"),
          actionButton("action2", "Action button", class = "btn-primary")
        ),
        mainPanel(tabsetPanel(
          tabPanel(
            "Visualization",
            h4("Table"),
            tableOutput("table"),
            h4("Verbatim text output"),
            verbatimTextOutput("txtout"),
            h1("Header 1"),
            h2("Header 2"),
            h3("Header 3"),
            h4("Header 4"),
            h5("Header 5")
          ),
          tabPanel("Data Table", "This panel is intentionally left blank"),
          tabPanel("Tab 3", "This panel is intentionally left blank")
        ))
      ),
      tabPanel("About", "This panel is intentionally left blank")
    )
  )
)

simulate <- function() {

}
