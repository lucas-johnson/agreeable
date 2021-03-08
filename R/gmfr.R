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
b_gmfr <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    b <- data %>% 
        dplyr::mutate(xbar = mean(x), ybar = mean(y)) %>% 
        dplyr::mutate(diff_xbar = abs(x - xbar), diff_ybar = abs(y - ybar)) %>% 
        dplyr::summarise(sum(diff_ybar ^ 2) / sum(diff_xbar ^ 2))
        
    return(b[[1]])
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
a_gmfr <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    b <-  data %>% b_gmfr(x, y, na.rm = na.rm)
    a <- data %>% 
        dplyr::summarise(xbar = mean(x), ybar = mean(y)) %>%
        dplyr::summarise(ybar - b * xbar)
    return(a[[1]])
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
gmfr <- function(data, x, y, na.rm = F) {
    new_gmfr(data, x, y, na.rm = na.rm)
}

new_gmfr <- function(data, x, y, na.rm) {
    
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    
    intercept <- data %>% a_gmfr(x, y, na.rm = na.rm)
    slope <- data %>% b_gmfr(x, y, na.rm = na.rm)
    data <- data %>% dplyr::mutate(
        gmfr_y = intercept + slope * x,
        gmfr_x = -intercept/slope + (1/slope) * y
    )
        
    gmfr_obj <- list(
        intercept = intercept,
        slope = slope,
        data = select(data, c(x = gmfr_x, y = gmfr_y))
    )
    class(gmfr_obj) <- "agreeable_gmfr"
    return(gmfr_obj)
}
