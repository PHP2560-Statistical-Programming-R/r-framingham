library(shinythemes)



tagList(

  navbarPage(
    # theme = "cerulean",  # <--- To use a theme, uncomment this
    "CVD Risk App",
    tabPanel("Individual Risk",
             sidebarPanel(

               textInput("name", "Name:", "Name"),
               numericInput("age", "Age:", 0, min = 30, max = 100),
               numericInput("bmi", "BMI:", 0, min = 10, max = 40),
               numericInput("HDL", "HDL:", 0, min = 10, max = 100),
               numericInput("TOTCHOL", "Total Cholesterol:", 0, min = 100, max = 405),
               numericInput("sbp_treated", "Systolic blood pressure:", 0, min = 90, max = 200),
               numericInput("sbp_not_treated", "Systolic blood pressure (not treated):", 0, min = 90, max = 200),
               radioButtons("smoker", "Smoking:",
                            choices = c("NO","YES"),
                            selected = "NO"),
               radioButtons("diabetic", "Diabetic:",
                            choices = c("NO","YES"),
                            selected = "NO"),
               tags$h5("Deafult actionButton:"),
               actionButton("action", "Search"),

               tags$h5("actionButton with CSS class:"),
               actionButton("action2", "Action button", class = "btn-primary")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Tab 1",
                          h4("Table"),
                          tableOutput("table"),
                          h4("Verbatim text output"),
                          verbatimTextOutput("txtout"),
                          h1("Header 1"),
                          h2("Header 2"),
                          h3("Header 3"),
                          h4("Header 4"),
                          h5("Header 5")
                 )
                 )
             )
    ),
    tabPanel("Population Risk",
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
                 tabPanel("Visualization",
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


