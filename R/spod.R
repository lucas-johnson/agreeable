#' spod
#'
#' Sum of potential difference 
#'
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#' @param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#'
#' @return numeric value
#' @export
#'
#' @examples
spod <- function(x, y, na.rm = F) {
    
    # TODO: check na.rm...
    
    assertthat::assert_that(length(x) == length(y))
    xbar <- mean(x, na.rm = na.rm)
    ybar <- mean(y, na.rm = na.rm)
    diff_xbar <- abs(x - xbar)
    diff_ybar <- abs(y - ybar)
    sum(
        (abs(xbar - ybar) + diff_xbar) * (abs(xbar - ybar) + diff_ybar),
        na.rm = na.rm
    )
}