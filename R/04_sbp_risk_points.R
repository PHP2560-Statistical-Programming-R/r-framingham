#' @title calculate sbp risk factor
#'
#' @description
#' \code{calc_sbp_points} returns sbp risk factor points given hdl and gender
#'
#' @param gender A character
#' @param age A number
#' @param sbp A number
#' @param isTreated A boolean
#' @return framingham hdl risk score \code{sbp} and \code{gender} and \code{isTreated}
#' @examples
#' calc_sbp_points(sbp, gender)

calc_sbp_points <- function (sbp, gender, isTreated=FALSE){
  if(gender=="M"){
    # call function for male
  }else{
    # call function for female
  }
}


