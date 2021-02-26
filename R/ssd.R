#' ssd
#' 
#' sum of square difference
#'
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#'@param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#' @return numeric value
#' @export
#'
#' @examples
ssd <- function(x, y, na.rm = F) {
    assertthat::assert_that(length(x) == length(y))
    return(sum((x - y) ^ 2, na.rm = na.rm ))
}
