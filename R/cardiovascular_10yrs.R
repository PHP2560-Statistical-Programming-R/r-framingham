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
#' @param bmi A number
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
#'               bmi=sample(16:48, rep = TRUE),
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
#'call frisk simple scoring function using BMI
#'calc_card_10(df, age="age", gender="gender", bmi= "BMI",
#'              sbp="sbp", is_sbp_under_treatment="isSbpTreated",
#'             smoking_status="smoking", diabetes_status="diabetes"


#' @export
calc_card_10 <- function(data, ...) {
  # check to see if it is a dataframe
  stopifnot(is.data.frame(data))
  params <- list(...)

  # calc points
  library(parallel) # enable parallel computing for extremely high speed
  if (!is.null(params$bmi) ){
  data$points =
    mcmapply(data[[params$gender]],
             data[[params$age]],
             data[[params$bmi]],
             NA,
             NA,
             data[[params$sbp]],
             data[[params$is_sbp_under_treatment]],
             data[[params$smoking_status]],
             data[[params$diabetes_status]],
             FUN = calc_framingham_points)

  #calculate f risk
  data$risk =
    mcmapply(data$points,
             data[[params$gender]],
             data[[params$bmi]],
             'risk',
             FUN = specific_point_converter)

  #calculate heart_age
  data$heart_age =
    mcmapply(data$points,
             data[[params$gender]],
             data[[params$bmi]],
             'heart_age',
             FUN = specific_point_converter)


  }else{ # case when bmi is not used
    data$points =
      mcmapply(data[[params$gender]],
               data[[params$age]],
               NA,
               data[[params$hdl]],
               data[[params$cholesterol]],
               data[[params$sbp]],
               data[[params$is_sbp_under_treatment]],
               data[[params$smoking_status]],
               data[[params$diabetes_status]],
               FUN = calc_framingham_points)

    #calculate f risk
    data$risk =
      mcmapply(data$points,
               data[[params$gender]],
               NA,
               'risk',
               FUN = specific_point_converter)

    #calculate heart_age
    data$heart_age =
      mcmapply(data$points,
               data[[params$gender]],
               NA,
               'heart_age',
               FUN = specific_point_converter)
  }


  # return origin df containing new columns: points, risk, heartAge
  return(data)
}

# function that calculate framingham points
calc_framingham_points <- function(gender,
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
  return(points)


}

specific_point_converter <- function (points,gender,bmi, type='risk'){
  data <- point_converter(points,gender,bmi)
  return(data[[type]])
}
