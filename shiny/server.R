library(shiny)
library(ggplot2)
library(ggradar)
library(scales)
library(dplyr)
library(janitor)
# install.packages("devtools") #!important
devtools::install_github("PHP2560-Statistical-Programming-R/r-framingham")
# load frisk library
library(frisk)

#shiny server defintion
shinyServer(function(input, output, session) {


  #
  output$txtout <- renderText({
    paste(input$txt, input$slider, format(input$date), sep = ", ")
  })
  output$table <- renderTable({
    head(cars, 4)
  })

  # individual person plot
  output$cvdRadarPlot <- renderPlot({
    # calculate cvd for a single person
    cvd_single <- cvd_single_person(input)

    return(cvd_single$plot)
  })


})

#' @title cvd_single_person
#' @description
#' \code{cvd_single_person} returns relative risk and heart age
#' @param gender A character
#' @param points A number
#' @return list of data and plot
cvd_single_person <- function (input) {

  # call cvd risk function
  patient1 <- calc_card_10_one(
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

  # clean data
  pp <- as.data.frame(patient1) %>%
    remove_empty_cols() %>%
    subset(select = -c(risk, heart_age))

  # radar plot
  plot_radar <- ggradar(
    pp,
    axis.labels = colnames(pp)[-1],
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
              data = patient1))


}
