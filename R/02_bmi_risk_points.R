#' @title calculate BMI risk factor
#'
#' @description
#' \code{calc_BMI_points} returns BMI risk factor points given BMI status and gender
#'
#' @param bmi A number
#' @return framingham BMI risk score \code{status} and \code{bmi}
#' @examples
#' calc_bmi_points(bmi)

calc_bmi_points <- function (bmi){
  if(bmi < 15 || bmi > 50){
    return(NA)
  }else if (bmi < 25){
    return(0)
  }else if (bmi >= 25 && bmi < 30){
    return(1)
  }else if (bmi >= 30){
    return(2)
  }
}


