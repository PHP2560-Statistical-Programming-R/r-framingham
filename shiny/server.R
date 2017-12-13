library(shiny)
library(ggplot2)
library(ggradar)
library(scales)
library(dplyr)
library(plotly)
library(janitor)
# install.packages("devtools") #!important
devtools::install_github("PHP2560-Statistical-Programming-R/r-framingham")
# load frisk library
library(frisk)

#shiny server defintion
shinyServer(function(input, output, session) {


  # render output text
  output$txtout <- renderText({
    paste(input$txt, input$slider, format(input$date), sep = ", ")
  })

  # render output table - testdata
  output$table <- renderTable({
    head(cars, 4)
  })

  # individual person plot
  output$cvdRadarPlot <- renderPlot({
    # calculate cvd for a single person
    cvd_single <- cvd_single_person(input)
    return(cvd_single$plot)
  })

  # render cvd table for single person tab
  output$cvdOneTable <- renderTable({
    # calculate cvd for a single person
    cvd_single <- cvd_single_person(input)
    return(head(cvd_single$data))
  })

  # render cvd text for single person tab
  output$cvdOneText <- renderText({
    # calculate cvd for a single person
    cvd_single <- cvd_single_person(input)
    resultData <- as.list(cvd_single$data)

    #regex expression to determine tails
    extreme <- ":" #not extreme
    if(grepl(">", resultData$risk)) {
      extreme <- ": >" #greater than
    } else if(grepl("<", resultData$risk)){
      extreme <- ": <" #less than
    }

    # conver to numeric
    risk <- gsub("[^0-9\\.]", "", resultData$risk)
    risk <- as.numeric(as.character(risk))

    # construct display message
    paste('Dear', input$name,
          'your estimated 10 years risk of having a Cardiovascular disease is',
          extreme,risk*10, '%.',
          'Due to your risk factors, your heart age is:',
          resultData$heart_age, 'years.', sep = " ")
  })

  # Population plot
  output$cvdPopulationPlot <- renderPlotly({
    if(input$populationTab=="simulation"){ #specify input for plot option
      # calculate cvd for a single person
      cvd_population <- cvd_population(input)

      return(cvd_population$plot)
    } else {
      return(plot_ly())
    }

  })

  # upload data and render on table
  output$cvdPopulationDT <- renderDataTable({
    if(input$populationTab=="upload"){ #specify input for upload and table option

      return(uploadFile(input))
    } else{
      cvd_population <- cvd_population(input)

      return(cvd_population$data)
    }
  },options = list(scrollX = TRUE))



})

#' @title cvd_single_person
#' @description
#' \code{cvd_single_person} returns relative risk and heart age
#' @param input A dataframe
#' @return list of data and plot
cvd_single_person <- function (input) {

  # call cvd risk function
  if(input$bmiTab=="nonBmi"){ #specify calculation using no BMI of points
    # call cvd risk function
      patentCvd <- calc_card_10_one(
        age = input$"age",
        gender = input$"gender",
        bmi = NA,
        cholesterol = input$"cholesterol",
        hdl = input$"hdl",
        sbp = input$"sbp",
        is_sbp_under_treatment = input$"isSbpTreated",
        smoking_status = input$"smoking_status",
        diabetes_status = input$"diabetes_status"
      )
  } else { #specify calculation using BMI
    # call cvd risk function
    patentCvd <- calc_card_10_one(
      age = input$"age",
      gender = input$"gender",
      bmi = input$"bmi",
      cholesterol = NA,
      hdl = NA,
      sbp = input$"sbp",
      is_sbp_under_treatment = input$"isSbpTreated",
      smoking_status = input$"smoking_status",
      diabetes_status = input$"diabetes_status"
    )
  }
  print(head(patentCvd))

  # clean data
  cleanPatentCvd <- as.data.frame(patentCvd) %>%
    remove_empty_cols() %>%
    subset(select = -c(risk, heart_age))
  # outputCvd
  outputCvd <- as.data.frame(patentCvd) %>%
    remove_empty_cols() %>%
    subset(select = c(points, risk, heart_age))

  # radar plot
  plot_radar <- ggradar(
    cleanPatentCvd,
    axis.labels = colnames(cleanPatentCvd)[-1],
    centre.y = -5,
    label.centre.y = TRUE,
    grid.min = 0,
    grid.mid = 8,
    grid.max = 15,
    values.radar = c("0", "8", "15"),
    grid.line.width = 0.3,
    grid.label.size = 4,
    gridline.label.offset = 0,
    axis.label.size = 3,
    axis.line.colour = "gray40",
    gridline.max.colour = "black",
    plot.legend = TRUE,
    legend.text.size = 10,
    font.radar = "Arial"
  )

  return(list(plot = plot_radar,
              data = outputCvd)
         )
}

#' @title cvd_population
#' @description
#' \code{cvd_population} returns relative risk and heart age of a population
#' @param input A dataframe
#' @return list of data and plot
cvd_population <- function (input) {

  sample_size <- input$sample_size
  # simulate patients data
  sample <- data.frame(age=sample(30:70,sample_size,rep=TRUE),
                       gender=sample(c("M","F"),sample_size,rep=TRUE),
                       bmi=sample(16:48, sample_size, rep = TRUE),
                       hdl=sample(10:100,sample_size,rep=TRUE),
                       chl=sample(100:400,sample_size,rep=TRUE),
                       sbp=sample(90:200,sample_size,rep=TRUE),
                       isSbpTreated=sample(c(TRUE,FALSE),sample_size,rep=TRUE),
                       smoking=sample(c(TRUE,FALSE),sample_size,rep=TRUE),
                       diabetes=sample(c(TRUE,FALSE),sample_size,rep=TRUE)
  )

  # call frisk function case no bmi
  patients <-calc_card_10(sample, age="age", gender="gender", cholesterol="chl",
                          hdl="hdl", sbp="sbp", is_sbp_under_treatment="isSbpTreated",
                          smoking_status="smoking", diabetes_status="diabetes"
  )

  #plot the graph of distribution of cholesterol, systolic blood pressure and HDL
  plot_graph <- plot_ly(patients, x = ~chl, y = ~sbp, z = ~hdl,
          marker = list(color = ~points, colorscale = c('#FFE1A1', '#683531'), showscale = TRUE)) %>%
    add_markers() %>%
    layout(scene = list(xaxis = list(title = 'cholesterol'),
                        yaxis = list(title = 'sbp'),
                        zaxis = list(title = 'hdl')),
           annotations = list(
             x = 1.13,
             y = 1.05,
             text = 'Effects of hdl, chl and sbp on CVD Risk',
             xref = 'paper',
             yref = 'paper',
             showarrow = FALSE
           ))

  return(list(plot = plot_graph,
              data = patients)
  )
}


# helper function to upload
uploadFile <- function(input){
  inFile <- input$file1

  if (is.null(inFile))
    return(NULL)
  tbl <-  read.csv(
    inFile$datapath,
    header = input$header,
    sep = input$sep,
    quote = input$quote
  )
  return(
    tbl ^ 2

  )
}

