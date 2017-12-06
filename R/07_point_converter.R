
#' @title point converter
#'
#' @description
#' \code{point_converter} returns relative risk and heart age given framingham point and gender
#'
#' @details
#' \code{point_converter} returns TODO: add some details
#'
#' @param gender A character
#' @param points A number
#' @param bmi A number or NA
#' @return risk and heart_age given \code{points} and \code{gender}  and \code{bmi}
#' @examples
#' point_converter(points=1, gender='M', NA)

point_converter<-function(points, gender, bmi=NA){
  # initialize
  risk=NA
  heart_age=NA
  #convert
  if((gender=="M" || gender=="m") & !is.na(bmi)){
    table<-read.csv('male_simple_risk.csv')
    risk=table[which(table$female_point == points),2]
    heart_age=table[which(table$female_point == points),3]
  } else if ((gender=="M" || gender=="m") & is.na(bmi)){
    table<-read.csv('female_risk.csv')
    risk=table[which(table$female_point == points),2]
    heart_age=table[which(table$female_point == points),3]
  } else if ((gender=="F" || gender=="f") & !is.na(bmi)){
    table<-read.csv('female_simple_risk.csv')
    risk=table[which(table$female_point == points),2]
    heart_age=table[which(table$female_point == points),3]
  } else if ((gender=="F" || gender=="f") & is.na(bmi)){
    table<-read.csv('female_risk.csv')
    risk=table[which(table$female_point == points),2]
    heart_age=table[which(table$female_point == points),3]
  }
  return(list(
    risk=risk,
    heart_age=heart_age
  ))
}
