#' ssd
#' 
#' sum of square difference
#' 
#' @param x a vector of numeric values
#' @param y a vector of numeric values
#' @param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#'   
#' @return numeric value
#'
#' @examples
ssd <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    ssd <- data %>% dplyr::mutate(diff_sq = (x - y) ^ 2) %>%
        dplyr::summarise(sum(diff_sq))
    return(ssd[[1]])
}

#' msd
#' 
#' Mean squared difference
#'
#' @inheritParams ssd
#'
#' @return numeric value
#'
#' @examples
msd <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    n <- nrow(data)
    data %>% ssd(x, y, na.rm = na.rm) / n
}

#' spod
#'
#' Sum of potential difference 
#'
#' @inheritParams ssd
#'
#' @return numeric value
#'
#' @examples
spod <- function(data, x, y, na.rm = F) {
    
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    spod <- data %>% 
        dplyr::mutate(xbar = mean(x), ybar = mean(y)) %>%
        dplyr::mutate(diff_xbar = abs(x - xbar), diff_ybar = abs(y - ybar)) %>%
        dplyr::summarise(
            sum((abs(xbar - ybar) + diff_xbar) * (abs(xbar - ybar) + diff_ybar))
        )
    return(spod[[1]])
}

#' Unsystematic sum of product-difference
#'
#' @inheritParams spod
#'
#' @return numeric value
#'
#' @examples
spdu <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    gmfr_xy <- data %>% gmfr(x, y, na.rm)
    gmfr_xy$data$orig_x <- dplyr::pull(data, x)
    gmfr_xy$data$orig_y <- dplyr::pull(data, y)
    spdu <- gmfr_xy$data %>% dplyr::summarise(
        sum(abs(orig_x - x) * abs(orig_y - y))
    )
    return(spdu[[1]])
}


#' mpdu
#' 
#' Unsystematic mean product-difference.
#'
#' @inheritParams spdu
#'
#' @return numeric value
#'
#' @examples
mpdu <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    data %>% spdu(x, y, na.rm = na.rm) / nrow(data)
}

#' pud
#' 
#' Percentage of unsystematic difference
#'
#' @inheritParams mpdu
#'
#' @return numeric value bounded \[0, 1\]
#' @export
#'
#' @examples
pud <- function(data, x, y, na.rm = F) {
    data %>% mpdu(x, y, na.rm = na.rm) / data %>% msd(x, y, na.rm = na.rm)
}

#' spds
#' 
#' Systematic sum of product-difference
#'
#' @inheritParams spdu
#'
#' @return numeric value
#'
#' @examples
spds <- function(data, x, y, na.rm = F) {
    data %>% ssd(x, y, na.rm = na.rm) - data %>% spdu(x, y, na.rm = na.rm)
}

#' mpds
#'
#' Systematic mean product-difference
#' 
#' @inheritParams spds
#'
#' @return numeric value
#'
#' @examples
mpds <- function(data, x, y, na.rm = F) {
    if (na.rm) {
        data <- data %>% tidyr::drop_na()
    }
    n <- nrow(data)
    data %>% spds(x, y, na.rm = na.rm) / n
}

#' psd
#' 
#' Percentage of systematic difference
#'
#' @inheritParams mpds
#'
#' @return numeric value bounded \[0, 1\]
#' 
#' @export
#'
#' @examples
psd <- function(data, x, y, na.rm = F) {
    data %>% mpds(x, y, na.rm = na.rm) / data %>% msd(x, y, na.rm = na.rm)
}

#' ac
#' 
#' Compute agreement coefficient (AC) following Ji and Gallo 2006
#' 
#' AC is bounded between 0 and 1 where 1 represents perfect agreement and 0
#' represents no agreement.
#' 
#' @inheritParams spds
#' 
#' @return a numeric value bounded \[0, 1\]
#' @export
#'
#' @examples
ac <- function(data, x, y, na.rm = F) {
    1 - (data %>% ssd(x, y, na.rm = na.rm) / data %>% spod(x, y, na.rm = na.rm))
}


#' acs
#' 
#' Compute systematic agreement coefficient (ACs) following Ji and Gallo 2006
#' 
#' ACs is bounded between 0 and 1 where 1 represents perfect agreement and 0
#' represents no agreement.
#'
#' @inheritParams ac
#'
#' @return a numeric value bounded \[0, 1\]
#' @export
#'
#' @examples
acs <- function(data, x, y, na.rm = F) {
    
    1 - (data %>% spds(x, y, na.rm = na.rm) / data %>% spod(x, y, na.rm = na.rm))
}

#' acu
#' 
#' Compute unsystematic agreement coefficient (ACu) following Ji and Gallo 2006
#' 
#' ACu is bounded between 0 and 1 where 1 represents perfect agreement and 0
#' represents no agreement.
#'
#' @inheritParams ac
#' 
#' @return a numeric value bounded \[0, 1\]
#' @export
#'
#' @examples
acu <- function(data, x, y, na.rm = F) {
    
    1 - (data %>% spdu(x, y, na.rm = na.rm) / data %>% spod(x, y, na.rm = na.rm))
}
