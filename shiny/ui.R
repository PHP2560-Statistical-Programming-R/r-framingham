
library(plotly)
library(shiny)

# load css library
devtools::install_github('andrewsali/shinycssloaders')
library(shinycssloaders)


# for spinners 2-3 match the background color of wellPanel
options(spinner.color.background="#F5F5F5")

# Custom user friendly error css
css <- "
.shiny-output-error { visibility: hidden; }
.shiny-output-error:before {
  visibility: visible;
  content: 'An error occurred. Please check your input data for validation.'; }
}"

# Define UI for application
shinyUI(

  tagList(
    #initialize css
    tags$style(type="text/css", css),
    navbarPage(
      "CVD Risk App",
      tabPanel(

        # title
        "Individual Risk",
        sidebarPanel(style = "overflow-y:scroll; max-height: 550px",

          # persone name input text
          textInput("name", "Name:", "_"),

          # numeric input for age
          numericInput("age", "Age:", 30, min = 30, max = 74),

          # gender option button
          radioButtons(
            "gender",
            "Gender:",
            choices = c("Male" = "M", "Female" = "F"),
            selected = "M"
          ),

          # sbp numeric input
          numericInput(
            "sbp",
            "Systolic blood pressure:",
            90,
            min = 90,
            max = 200
          ),

          # SBP under treatment option button
          radioButtons(
            "isSbpTreated",
            "is SBP under treatment:",
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),

          # Smoking option button
          radioButtons(
            "smoking_status",
            "Smoking:",
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),

          # diabetes option button
          radioButtons(
            "diabetes_status",
            "Diabetic:",
            choices = c("NO" = FALSE, "YES" = TRUE),
            selected = FALSE
          ),
          tabsetPanel(  id = "bmiTab",

            # tab panel for bmi
            tabPanel("BMI", value="bmi", numericInput(
              "bmi", "BMI:", 15, min = 15, max = 50
            )),

            # tab panel for non-bmi
            tabPanel(
              "None-BMI",  value="nonBmi",
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

              # plot the radar plot
              fluidRow(withSpinner(
                plotOutput("cvdRadarPlot"),
                type = 4
              ),
              textOutput("cvdOneText")
              )
            ),
            tabPanel(
              "Data",

              # plot data
              fluidRow(withSpinner(
                tableOutput("cvdOneTable"),
                type = 4
              )

              # Display output text

              )
            )
          )
        )
      ),
      tabPanel(
        "Population Risk",
        sidebarPanel(
          tabsetPanel( id = "populationTab",
             # slider for sample size
            tabPanel("Simulation", value="simulation",
                     sliderInput("sample_size", "Sample Size:", 1, 500, 50)
            ),
            # upload panel for csv
            tabPanel(
              "Upload Data", value="upload",
              fileInput('file1', 'Choose CSV File',
                        accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))
              ,
              tags$hr(),

              # headr checkbox
              checkboxInput('header', 'Header', TRUE),

              # separator
              radioButtons('sep', 'Separator',
                           c(Comma=',',
                             Semicolon=';',
                             Tab='\t'),
                           ','),
              # quote
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

              # plot 3d plot
              fluidRow(withSpinner(
                plotlyOutput("cvdPopulationPlot"),
                type = 4
              ))


            ),
            tabPanel("Data Table",

                     # plot the data table
                     fluidRow(withSpinner(
                       dataTableOutput(outputId = 'cvdPopulationDT'),
                       type = 4
                     ))

                  )
          )
        )
      ),

      # Tab about the app and authors
      tabPanel("About", "This panel is intentionally left blank: TODO Add info")
    )
  )
)



