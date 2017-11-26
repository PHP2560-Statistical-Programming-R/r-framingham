#' @title calculate age risk factor
#'
#' @description
#' \code{calc_age_points} returns age risk factor points given age and gender
#'
#' @details
#' \code{calc_age_points} returns TODO: add some details
#'
#' @param gender A character
#' @param age A number
#' @return framingham age risk scores \code{age} and \code{gender}
#' @examples
#' calc_age_points(gender='M', age=50)
#' calc_age_points(gender='F', age=28)
#' calc_age_points(gender='f', age=35)
calc_age_points <- function (age, gender){
  points <- 0
  # logic
  if(gender=="M" || gender=="m"){
    # call function for male
    points <- calc_age_male(age)
  }else  if(gender=="F" || gender=="f"){
    # call function for female
    points <- calc_age_female(age)
  }
  return(points)

}

# this male specific function takes in age and returns framingham point
calc_age_male <- function (age){  # age should be numeric

  # age less 30 returns NA ~ cardivascular not applicable to < 30
  if (age<30){
    points <- NA
  } else if(age>=30 && age<=34){
    points <- 0
  } else if(age>=35 && age<=39){
    points <- 2
  } else if(age>=40 && age<=44){
    points <- 5
  } else if(age>=45 && age<=49){
    points <- 6
  }else if(age>=50 && age<=54){
    points <- 8
  }else if(age>=55 && age<=59){
    points <- 10
  }else if(age>=60 && age<=64){
    points <- 11
  }else if(age>=65 && age<=69){
    points <- 12
  }else if(age>=70 && age<=74){
    points <- 14
  }else if(age>=75){
    points <- 15
  }

  return(points);
}

# this female specific function takes in age and returns framingham points
calc_age_female <- function (age){ # age should be numeric
  point <- 0
  # age less 30 returns NA ~ cardivascular not applicable to < 30
  if (age<30){
    points <- NA
  } else if(age>=30 && age<=34){
    points <- 0
  } else if(age>=35 && age<=39){
    points <- 2
  } else if(age>=40 && age<=44){
    points <- 4
  } else if(age>=45 && age<=49){
    points <- 5
  }else if(age>=50 && age<=54){
    points <- 7
  }else if(age>=55 && age<=59){
    points <- 8
  }else if(age>=60 && age<=64){
    points <- 9
  }else if(age>=65 && age<=69){
    points <- 10
  }else if(age>=70 && age<=74){
    points <- 11
  }else if(age>=75){
    points <- 12
  }

  return(points);
}





