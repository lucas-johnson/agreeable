#' ssd
#' 
#' sum of square difference
#'
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#'
#' @return numeric value
#' @export
#'
#' @examples
ssd <- function(x, y) {
    return(sum((x - y) ^ 2))
}
