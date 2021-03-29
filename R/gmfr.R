#' gmfr_slope
#' 
#' Get the slope for the geometric mean functional relationship model.
#' @param data data.frame 
#' @param x column name for independent data in model
#' @param y column name for response data in model
#' @param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#'
#' @return a numeric value
#' @export
#'
#' @examples
gmfr_slope <- function(data, x, y, na.rm = F) {
    xbar <- ybar <- diff_xbar <- diff_ybar <- NULL
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    b <- data %>% 
        dplyr::mutate(xbar = mean({{ x }}), ybar = mean({{ y }})) %>% 
        dplyr::mutate(
            diff_xbar = abs({{ x }} - xbar), 
            diff_ybar = abs({{ y }} - ybar)) %>% 
        dplyr::summarise(sqrt(sum(diff_ybar ^ 2) / sum(diff_xbar ^ 2)))
        
    return(b[[1]])
}

#' gmfr_intercept
#'
#' Get the intercept for the geometric mean functional relationship model.
#'
#' @inheritParams gmfr_slope
#' @return a numeric value
#' @export
#'
#' @examples
gmfr_intercept <- function(data, x, y, na.rm = F) {
    xbar <- ybar <- NULL
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    b <-  data %>% gmfr_slope({{ x }}, {{ y }}, na.rm = na.rm)
    a <- data %>% 
        dplyr::summarise(xbar = mean({{ x }}), ybar = mean({{ y }})) %>%
        dplyr::summarise(ybar - b * xbar)
    return(a[[1]])
}

#' gmfr 
#' 
#' Computes x and y coordinates along the GMFR line for input vectors x and y
#' 
#' @inheritParams gmfr_slope
#'
#' @return a agreeable_gmfr object containing slope, intercept and a data.frame
#'   of x and y values on the gmfr line
#' @export
#'
#' @examples
gmfr <- function(data, x, y, na.rm = F) {
    new_gmfr(data, {{ x }}, {{ y }}, na.rm = na.rm)
}

new_gmfr <- function(data, x, y, na.rm) {
    gmfr_x <- gmfr_y <- NULL
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    
    intercept <- data %>% gmfr_intercept({{ x }}, {{ y }}, na.rm = na.rm)
    slope <- data %>% gmfr_slope({{ x }}, {{ y }}, na.rm = na.rm)
    data <- data %>% dplyr::mutate(
        gmfr_y = intercept + slope * {{ x }},
        gmfr_x = -intercept/slope + (1/slope) * {{ y }}
    )
        
    gmfr_obj <- list(
        intercept = intercept,
        slope = slope,
        data = dplyr::select(data, c(x = gmfr_x, y = gmfr_y))
    )
    class(gmfr_obj) <- "agreeable_gmfr"
    return(gmfr_obj)
}
