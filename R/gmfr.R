#' b_gmfr
#' 
#' Get the slope for the geometric mean functional relationship model.
#'
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#' @param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#'
#' @return a numeric value
#' @export
#'
#' @examples
b_gmfr <- function(x, y, na.rm = F) {
    assertthat::assert_that(length(x) == length(y))
    if (na.rm) {
        xy <- vec_narm(x, y)
        x <- xy$x
        y <- xy$y
    }
    xbar <- mean(x)
    ybar <- mean(y)
    diff_xbar <- abs(x - xbar)
    diff_ybar <- abs(y - ybar)
    b <- sqrt(sum(diff_ybar ^ 2) / sum(diff_xbar ^ 2))
    return(b)
}

#' a_gmfr
#'
#' Get the intercept for the geometric mean functional relationship model.
#'
#' @inheritParams b_gmfr
#' @return a numeric value
#' @export
#'
#' @examples
a_gmfr <- function(x, y, na.rm = F) {
    assertthat::assert_that(length(x) == length(y))
    if (na.rm) {
        xy <- vec_narm(x, y)
        x <- xy$x
        y <- xy$y
    }
    ybar <- mean(y, na.rm = na.rm)
    xbar <- mean(x, na.rm = na.rm)
    a <- ybar - b_gmfr(x, y, na.rm = na.rm) * xbar
    return(a)
}

#' gmfr 
#' 
#' Computes x and y coordinates along the GMFR line for input vectors x and y
#' 
#' @inheritParams b_gmfr
#'
#' @return a list of vectors (x, and y) 
#' @export
#'
#' @examples
gmfr <- function(x, y, na.rm = F) {
    if (na.rm) {
        xy <- vec_narm(x, y)
        x <- xy$x
        y <- xy$y
    }
    a <- a_gmfr(x, y, na.rm = na.rm)
    b <- b_gmfr(x, y, na.rm = na.rm)
    y_gmfr <- a + b * x
    x_gmfr <- -a/b + (1/b) * y
    return(list(x = x_gmfr, y = y_gmfr))
}