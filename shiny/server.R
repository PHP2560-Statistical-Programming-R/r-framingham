library(shiny)
library(ggplot2)
library(ggradar)
library(scales)
library(dplyr)
library(janitor)
# install.packages("devtools") #!important
#devtools::install_github("PHP2560-Statistical-Programming-R/r-framingham")
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
    cvd_single <- cvd_single_person(1)

    return(cvd_single$plot)
  })

  output$cvdTable <- renderTable({
    # calculate cvd for a single person
    sample_size <- 100
    dd <- data.frame(
      age = sample(30:70, sample_size, rep = TRUE),
      gender = sample(c("M", "F"), sample_size, rep = TRUE),
      bmi = sample(16:48, sample_size, rep = TRUE),
      hdl = sample(10:100, sample_size, rep = TRUE),
      chl = sample(100:400, sample_size, rep = TRUE),
      sbp = sample(90:200, sample_size, rep = TRUE),
      isSbpTreated = sample(c(TRUE, FALSE), sample_size, rep =
                              TRUE),
      smoking = sample(c(TRUE, FALSE), sample_size, rep = TRUE),
      diabetes = sample(c(TRUE, FALSE), sample_size, rep =
                          TRUE)
    )
    return(dd)

  })

})

#' @title cvd_single_person
#' @description
#' \code{cvd_single_person} returns relative risk and heart age
#' @param gender A character
#' @param points A number
#' @return list of data and plot
cvd_single_person <- function (sample_size=100) {
  # simulate patients data
  dd <- data.frame(
    age = sample(30:70, sample_size, rep = TRUE),
    gender = sample(c("M", "F"), sample_size, rep = TRUE),
    bmi = sample(16:48, sample_size, rep = TRUE),
    hdl = sample(10:100, sample_size, rep = TRUE),
    chl = sample(100:400, sample_size, rep = TRUE),
    sbp = sample(90:200, sample_size, rep = TRUE),
    isSbpTreated = sample(c(TRUE, FALSE), sample_size, rep =
                            TRUE),
    smoking = sample(c(TRUE, FALSE), sample_size, rep = TRUE),
    diabetes = sample(c(TRUE, FALSE), sample_size, rep =
                        TRUE)
  )
  # call cvd risk function
  patient1 <- calc_card_10_one(
    age = dd$"age",
    gender = dd$"gender",
    bmi = NA,
    cholesterol = dd$"chl",
    hdl = dd$"hdl",
    sbp = dd$"sbp",
    is_sbp_under_treatment = dd$"isSbpTreated",
    smoking_status = dd$"smoking",
    diabetes_status = dd$"diabetes"
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
