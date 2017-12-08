

library(shiny)


# Define UI for application
shinyUI(

  tagList(
    navbarPage(
      "CVD Risk App",
      tabPanel(
        "Individual Risk",
        sidebarPanel(
          textInput("name", "Name:", "Name"),
          numericInput("age", "Age:", 30, min = 30, max = 100),
          radioButtons(
            "gender",
            "Gender:",
            choices = c("Male" = "M", "Female" = "F"),
            selected = "M"
          ),
          numericInput(
            "sbp",
            "Systolic blood pressure:",
            90,
            min = 90,
            max = 200
          ),
          radioButtons(
            "isSbpTreated",
            "is SBP under treatment:",
            choices = c("NO" = 0, "YES" = 1),
            selected = 0
          ),
          radioButtons(
            "smoking_status",
            "Smoking:",
            choices = c("NO" = 0, "YES" = 1),
            selected = 0
          ),
          radioButtons(
            "diabetes_status",
            "Diabetic:",
            choices = c("NO" = 0, "YES" = 1),
            selected = 0
          ),
          tabsetPanel(
            tabPanel("BMI", numericInput(
              "bmi", "BMI:", 10, min = 10, max = 40
            )),
            tabPanel(
              "None-BMI",
              numericInput("hdl", "HDL:", 10, min = 10, max = 100),
              numericInput(
                "cholesterol",
                "Total Cholesterol:",
                100,
                min = 100,
                max = 405
              )
            )
          )
        ),
        mainPanel(
          tabsetPanel(
            tabPanel(
              "Result",
              plotOutput("cvdRadarPlot")
            )))
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
        mainPanel(
          tabsetPanel(
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
          )
        )
      ),
      tabPanel("About", "This panel is intentionally left blank")
    )
  )
)
