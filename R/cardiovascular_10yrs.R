#' @title cardivascular mortality risk
#'
#' @description
#' \code{calc_card_10} returns 10 years cardivascular mortality risk score
#'
#' @details
#' This is the main function: which returns framingham cardivascular risk score
#'
#' @param data A dataframe
#' @param gender A character
#' @param age A number
#' @param hdl A number
#' @param cholesterol A number
#' @param sbp_treated A number
#' @param sbp_untreated A number
#' @param smoking_status A boolean
#' @return framingham cardivascular risk scores \code{data} and \code{...}
#' @examples
#' calc_card_10(df, gender=M, age=10)
calc_card_10 <- function(data, ...) {
  # check to see if it is a dataframe
  stopifnot(is.data.frame(data))
  print("Hello, world!")
}



