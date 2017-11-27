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

calc_sbp_points <- function (sbp, gender, isTreated= FALSE){
  points <- 0
  # logic
  if(gender=="M" || gender=="m"){
    # call function for male
    points <- calc_sbp_male(sbp,isTreated)
  }else if(gender=="F" || gender=="f"){
    # call function for female
    points <- calc_sbp_female(sbp,isTreated )
  }
  return(points)
}

# this is a male specific function that takes in SBP and treatment status and return Framingham CAD 10 years risk points
calc_sbp_male <- function (sbp, isTreated){ # SBP is neumeric and isTreated is boolean
  points <- 0
  # SBP less than 90 or more than 200 return NA ~  people with SBP outside the range of 90-200 is ineligible for framingham CAD10 risk score
  if (sbp < 90 || sbp > 200){
    points <- NA
  }else if (sbp >=  90 && sbp <  120 && isTreated== FALSE){
    points <- -2
  }else if (sbp >= 120 && sbp <= 129 && isTreated== FALSE){
    points <-  0
  }else if (sbp >= 130 && sbp <= 139 && isTreated== FALSE){
    points <-  1
  }else if (sbp >= 140 && sbp <= 159 && isTreated== FALSE){
    points <-  2
  }else if (sbp >= 160 && sbp <= 200 && isTreated== FALSE){
    points <-  3
  }else if (sbp >=  90 && sbp <  120 && isTreated== TRUE){
    points <-  0
  }else if (sbp >= 120 && sbp <= 129 && isTreated== TRUE){
    points <-  2
  }else if (sbp >= 130 && sbp <= 139 && isTreated== TRUE){
    points <-  3
  }else if (sbp >= 140 && sbp <= 159 && isTreated== TRUE){
    points <-  4
  }else if (sbp >= 160 && sbp <= 200 && isTreated== TRUE){
    points <-  5
  }
  return(points)
}

# this is a female specific function that takes in SBP and treatment status and return Framingham CAD 10 years risk points
calc_sbp_female <- function (sbp, isTreated=FALSE){ # SBP is neumeric and isTreated is boolean
  points <- 0
  # SBP less than 90 or more than 200 return NA ~  people with SBP outside the range of 90-200 is ineligible for framingham CAD10 risk score
  if (sbp < 90 || sbp > 200){
    points <- NA
  }else if (sbp >=  90 && sbp <  120 && isTreated== FALSE){
    points <- -3
  }else if (sbp >= 120 && sbp <= 129 && isTreated== FALSE){
    points <-  0
  }else if (sbp >= 130 && sbp <= 139 && isTreated== FALSE){
    points <-  1
  }else if (sbp >= 140 && sbp <= 149 && isTreated== FALSE){
    points <-  2
  }else if (sbp >= 150 && sbp <= 159 && isTreated== FALSE){
    points <-  4
  }else if (sbp >= 160 && sbp <= 200 && isTreated== FALSE){
    points <-  5
  }else if (sbp >=  90 && sbp <  120 && isTreated== TRUE){
    points <- -1
  }else if (sbp >= 120 && sbp <= 129 && isTreated== TRUE){
    points <-  2
  }else if (sbp >= 130 && sbp <= 139 && isTreated== TRUE){
    points <-  3
  }else if (sbp >= 140 && sbp <= 149 && isTreated== TRUE){
    points <-  5
  }else if (sbp >= 150 && sbp <= 159 && isTreated== TRUE){
    points <-  6
  }else if (sbp >= 160 && sbp <= 200 && isTreated== TRUE){
    points <-  7
  }
  return(points)
}



