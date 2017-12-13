#' @title calculate diabetes risk factor
#'
#' @description
#' \code{calc_diabetes_points} returns diabetes risk factor points given diabetes status and gender
#'
#' @param gender A character
#' @param status boolean
#' @return framingham smoking risk score \code{status} and \code{gender}
#' @examples
#' calc_diabetes_points(status, gender)

calc_diabetes_points <- function (status, gender){
  if(gender=="M" || gender=="m"){
    # logic for male
    if(status==TRUE){ #logic for diabetes
      return(3)
    } else { #logic for no diabetes
      return(0)
    }
  }else{
    # logic for female
    if(status==TRUE){ #logic for diabetes
      return(4)
    } else { #logic for no diabetes
      return(0)
    }
  }
}


