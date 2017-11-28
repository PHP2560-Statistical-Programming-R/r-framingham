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
#' @param sbp A number
#' @param is_sbp_under_treatment A boolean
#' @param smoking_status A boolean
#' @return framingham cardivascular risk scores \code{data} and \code{...}
#' @examples
#' df <- data.frame(age=sample(1:100,10,rep=TRUE),
#'                  gender=sample(c('M','F'),10,rep=TRUE)
#'                  )
#' calc_card_10(df, age="age", gender="gender")


calc_card_10 <- function(data, ...) {

  # check to see if it is a dataframe
  stopifnot(is.data.frame(data))
  params <- list(...)


    #calculate age points
    age_points <- mapply(calc_age_points, df[params$gender], df[params$age])
    #calculate hdl_points
    hdl_points <- mapply(calc_hdl_points, df[params$hdl])
    #calculate cholesterol_points
    cholesterol_points <- mapply(calc_cholesterol_points, df[params$gender], df[params$cholesterol])
    #calculate sbp_points
    sbp_points <- mapply(calc_cholesterol_points, df[params$sbp],df[params$gender], df[params$is_sbp_under_treatment])
    #calculate smoking_points
    smoking_points <- mapply(calc_smoking_points, df[params$status], df[params$gender])
    #calculate diabetes_points
    diabetes_points <- mapply(calc_diabetes_points, df[params$status], df[params$gender])

    # finally do the summation
    framingham_df <- data.frame(
      age_points=age_points,
      hdl_points=hdl_points,
      cholesterol_points=cholesterol_points,
      sbp_points=sbp_points,
      smoking_points=smoking_points,
      diabetes_points=diabetes_points
    )

    # return origin df containing new columns: points, risk, heartAge
    data$points = with(framingham_df, age_points+hdl_points+cholesterol_points+sbp_points+smoking_points+diabetes_points)
    return(data)
}



