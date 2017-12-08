
library(plotly)
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
          numericInput("age", "Age:", 30, min = 30, max = 74),
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
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),
          radioButtons(
            "smoking_status",
            "Smoking:",
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),
          radioButtons(
            "diabetes_status",
            "Diabetic:",
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),
          tabsetPanel(
            tabPanel("BMI", numericInput(
              "bmi", "BMI:", 15, min = 15, max = 50
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
            ),
            tabPanel(
              "Data",
              tableOutput("cvdOneTable")
            )
          )
        )
      ),
      tabPanel(
        "Population Risk",
        sidebarPanel(
          tabsetPanel( id = "populationTab",
            tabPanel("Simulation", value="simulation",
                     sliderInput("sample_size", "Sample Size:", 1, 100, 50)
            ),
            tabPanel(
              "Upload Data", value="upload",
              fileInput('file1', 'Choose CSV File',
                        accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
              ,
              tags$hr(),
              checkboxInput('header', 'Header', TRUE),
              radioButtons('sep', 'Separator',
                           c(Comma=',',
                             Semicolon=';',
                             Tab='\t'),
                           ','),
              radioButtons('quote', 'Quote',
                           c(None='',
                             'Double Quote'='"',
                             'Single Quote'="'"),
                           '"')
            )
          )

        ),
        mainPanel(
          tabsetPanel(
            tabPanel(
              "Visualization",
              plotlyOutput("cvdPopulationPlot")

            ),
            tabPanel("Data Table", tableOutput(outputId = 'table.output'))
          )
        )
      ),
      tabPanel("About", "This panel is intentionally left blank")
    )
  )
)
