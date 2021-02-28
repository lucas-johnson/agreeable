#' vec_narm
#' 
#' Helper to remove na vales from vectors of matching length
#'
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#'
#' @return a vector containing two vectors: c(x, y)
#'
#' @examples
vec_narm <- function(x, y) {
    x <- x[!is.na(y)]
    y <- y[!is.na(y)]
    y <- y[!is.na(x)]
    x <- x[!is.na(x)]
    return(list(x = x, y = y))
}