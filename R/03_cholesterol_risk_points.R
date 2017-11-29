#' @title calculate cholesterol risk factor
#'
#' @description
#' \code{calc_cholesterol_points} returns cholesterol risk factor points given cholesterol and gender
#'
#' @param gender A character
#' @param cholesterol A number
#' @return framingham cholesterol risk score \code{cholesterol} and \code{gender}
#' @examples
#' calc_cholesterol_points(gender='f', chol=35)
calc_cholesterol_points <- function (gender,chol){
  points <- 0
  # logic
  if(gender=="M" || gender=="m"){
    # call function for male
    points <- calc_cholesterol_male(chol)
  }else  if(gender=="F" || gender=="f"){
    # call function for female
    points <- calc_cholesterol_female(chol)
  }
  return(points)

}

# this male specific function takes in chol and returns framingham CAD10 yeras risk points
calc_cholesterol_male <- function (chol){  # chol should be numeric
  point <- 0
  # chol less 100 or more than 405 returns NA
  if (chol<100 || chol >405|| is.na(chol)){
    points <- NA
  } else if(chol<160){
    points <- 0
  } else if(chol>=160 && chol<=199){
    points <- 1
  } else if(chol>=200 && chol<=239){
    points <- 2
  } else if(chol>=240 && chol<=279){
    points <- 3
  }else if(chol>=280){
    points <- 4
  }

  return(points);
}

# this female specific function takes in chol and returns framingham CAD10 yeras risk points
calc_cholesterol_female <-  function (chol){  # chol should be numeric
  point <- 0
  # chol less 100 or more than 405 returns NA
  if (chol<100 || chol >405 || is.na(chol)){
    points <- NA
  } else if(chol<160){
    points <- 0
  } else if(chol>=160 && chol<=199){
    points <- 1
  } else if(chol>=200 && chol<=239){
    points <- 3
  } else if(chol>=240 && chol<=279){
    points <- 4
  }else if(chol>=280){
    points <- 5
  }

  return(points);
}
