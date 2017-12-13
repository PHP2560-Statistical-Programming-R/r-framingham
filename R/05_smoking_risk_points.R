#' @title calculate smoking risk factor
#'
#' @description
#' \code{calc_smoking_points} returns smoking risk factor points given smoking status and gender
#'
#' @param gender A character
#' @param age A number
#' @param status boolean
#' @return framingham smoking risk score \code{status} and \code{gender}
#' @examples
#' calc_smoking_points(status, gender)

calc_smoking_points <- function (status, gender){
  if(gender=="M" || gender == "m"){
    # logic for male
    if(status==TRUE){ #logic for smoking
      return(4)
    } else { #logic for not smoking
      return(0)
    }
  }else{
    # logic for female
    if(status==TRUE){ # logic for smoking
      return(3)
    } else { #logic for not smoking
      return(0)
    }
  }
}


