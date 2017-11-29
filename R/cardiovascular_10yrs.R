#' @title Cardivascular Disease 10 years risk
#'
#' @description
#' \code{calc_card_10} returns 10 years cardivascular relative risk score,
#'
#' @details
#' This package uses the widely used framingham risk scoring algorithm used to determine an individual's chances of developing cardiovascular disease.
#' This package gives an estimate of the probability that a person will develop cardiovascular disease within a specified amount of time (10 years)
#' @param data A dataframe
#' @param gender A character
#' @param age A number
#' @param hdl A number
#' @param cholesterol A number
#' @param sbp A number
#' @param is_sbp_under_treatment A boolean
#' @param smoking_status A boolean
#' @param diabetes_status A boolean
#' @return framingham cardivascular 10 years risk score \code{data} and \code{...}
#' @examples
#' # simulate patients data
#'df <- data.frame(age=sample(30:70,100,rep=TRUE),
#'               gender=sample(c("M","F"),100,rep=TRUE),
#'               hdl=sample(10:100,100,rep=TRUE),
#'               chl=sample(100:400,100,rep=TRUE),
#'               sbp=sample(90:200,100,rep=TRUE),
#'               isSbpTreated=sample(c(TRUE,FALSE),100,rep=TRUE),
#'               smoking=sample(c(TRUE,FALSE),100,rep=TRUE),
#'               diabetes=sample(c(TRUE,FALSE),100,rep=TRUE)
#')
#'
#'# call frisk function
#'calc_card_10(df, age="age", gender="gender", cholesterol="chl",
#'             hdl="hdl", sbp="sbp", is_sbp_under_treatment="isSbpTreated",
#'             smoking_status="smoking", diabetes_status="diabetes"
#' )
#'


#' @export
calc_card_10 <- function(data, ...) {
  # check to see if it is a dataframe
  stopifnot(is.data.frame(data))
  params <- list(...)

  # calc points
  library(parallel) # enable parallel computing for extremely high speed
  data$points =
    mcmapply(df[[params$gender]],
             df[[params$age]],
             df[[params$hdl]],
             df[[params$cholesterol]],
             df[[params$sbp]],
             df[[params$is_sbp_under_treatment]],
             df[[params$smoking_status]],
             df[[params$diabetes_status]],
             FUN = calc_framingham_points)



  # return origin df containing new columns: points, risk, heartAge
  return(data)
}

# function that calculate framingham points
calc_framingham_points <- function(gender,
                                   age,
                                   hdl,
                                   cholesterol,
                                   sbp,
                                   is_sbp_under_treatment,
                                   smoking_status,
                                   diabetes_status) {
  #calculate age points
  age_points <-  calc_age_points(gender, age)
  #calculate hdl_points
  hdl_points <- calc_hdl_points(hdl)
  #calculate cholesterol_points
  cholesterol_points <- calc_cholesterol_points(gender, cholesterol)
  #calculate sbp_points
  sbp_points <- calc_sbp_points(sbp, gender, is_sbp_under_treatment)
  #calculate smoking_points
  smoking_points <- calc_smoking_points(smoking_status, gender)
  #calculate diabetes_points
  diabetes_points <-  calc_diabetes_points(diabetes_status, gender)

  # do summation
  points <-
    age_points + hdl_points + cholesterol_points + sbp_points + smoking_points +
    diabetes_points

  return(points)


}

calc_other_scores <- function(point) {

}
