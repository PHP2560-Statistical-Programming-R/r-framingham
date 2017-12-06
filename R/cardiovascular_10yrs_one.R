#' @title Cardivascular Disease 10 years risk for one patient
#'
#' @description
#' \code{calc_card_10_one} returns 10 years cardivascular relative risk score for a single patient,
#'
#' @details
#' This package uses the widely used framingham risk scoring algorithm used to determine an individual's chances of developing cardiovascular disease.
#' This package gives an estimate of the probability that a person will develop cardiovascular disease within a specified amount of time (10 years)
#' @param gender A character
#' @param age A number
#' @param bmi A number
#' @param hdl A number
#' @param cholesterol A number
#' @param sbp A number
#' @param is_sbp_under_treatment A boolean
#' @param smoking_status A boolean
#' @param diabetes_status A boolean
#' @return framingham cardivascular 10 years risk score \code{gender} and \code{...}
#' @examples
#' # call frisk function
#' calc_card_10_one(age=45, gender="F", cholesterol=89,
#'             hdl=89, sbp=65, is_sbp_under_treatment=TRUE,
#'             smoking_status=F, diabetes_status=T
#' )
#'
#' call frisk simple scoring function using BMI
#' calc_card_10_one(age=45, gender="M", bmi= 173,
#'              sbp=54, is_sbp_under_treatment=T,
#'             smoking_status=F, diabetes_status=T


#' @export
calc_card_10_one <- function(gender,
                                   age,
                                   bmi,
                                   hdl,
                                   cholesterol,
                                   sbp,
                                   is_sbp_under_treatment,
                                   smoking_status,
                                   diabetes_status) {
  #calculate age points
  age_points <-  calc_age_points(gender, age)
  #calculate BMI points
  bmi_points <- calc_bmi_points(bmi)
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
  #use simple scoring if BMI was added
  if (!is.na(bmi)){ # case if BMI is specified i.e not na
    points <-
      age_points + bmi_points + sbp_points + smoking_points +
      diabetes_points

  }else{
    points <-
      age_points + hdl_points + cholesterol_points + sbp_points + smoking_points +
      diabetes_points
  }

  #calculate heart age and risk
  list_risk <- point_converter(points,gender,bmi)
  # create list point
  list_points <-list(
    points=points,
    age_points= age_points,
    hdl_points =hdl_points,
    cholesterol_points = cholesterol_points,
    sbp_points=sbp_points,
    smoking_points =smoking_points,
    diabetes_points=diabetes_points,
    bmi_points=bmi_points
  )
  return(c(list_points,list_risk))


}


