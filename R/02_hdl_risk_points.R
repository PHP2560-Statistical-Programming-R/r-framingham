#' @title calculate hdl risk factor
#'
#' @description
#' \code{calc_hdl_points} returns hdl risk factor points given hdl
#'
#' @param hdl A number
#'
#' @return framingham CAD10 hdl risk score \code{hdl}
#' @examples
#' calc_hdl_points(60)
#' calc_hdl_points(30)

# this function takes HDl and returne framingham CAD10 years risk HDL points
calc_hdl_points <- function (hdl){# HDL should be numeric
  points <- 0 #set default point to be 0

   # HDL not between 10 and 100 will returne NA ~ values outside this range are not applicable to the score.
  if (hdl < 10 || hdl > 100 || is.na(hdl)){
    points <- NA
  }else if (hdl >= 60 && hdl <= 100){ #specify other HDL groups
    points <- -2
  }else if (hdl >= 50 && hdl <= 59){
    points <- -1
  }else if (hdl >= 45 && hdl <= 49){
    points <- 0
  }else if (hdl >= 35 && hdl <= 44){
    points <- 1
  }else if (hdl >= 10 && hdl <= 35){
    points <- 2
  }

  return(points);
}


