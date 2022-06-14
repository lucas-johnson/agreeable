#' rmse
#' 
#' compute the root mean squared error
#' 
#' @param data data.frame 
#' @param x column name for predicted data
#' @param y column name for response data
#' @param na.rm boolean flag indicating whether or not to remove NA values from
#'   computation
#'
#' @return a numeric value
#' @export
#'
rmse <- function(data, x, y, na.rm = FALSE) {
    
    data |>
        dplyr::summarize(
            rmse = sqrt(mean(({{ x }} - {{ y }})^2, na.rm = na.rm))
        ) |>
        dplyr::pull(rmse)
}

#' rmse standard error
#' 
#' compute a standard error estimate for rmse via 1000 bootstrap iterations
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
#' @examples
rmse_se <- function(data, x, y, na.rm = FALSE) {
    
    var(unlist(lapply(
        1:1000,
        \(i) {
            idx = sample(
                1:nrow(data) ,
                nrow(data),
                replace = TRUE
            )    
            rmse(data[idx, ], {{ x }}, {{ y }}, na.rm = na.rm)
        }
    )), na.rm = na.rm)
}

#' Percent rmse
#'
#' rmse divided by mean response value 
#'
#' @inheritParams rmse
#'
#' @return a numeric value
#' @export
#'
p_rmse <- function(data, x, y, na.rm = FALSE) {
    
    ybar <- data |> 
        dplyr::summarize(
            ybar = mean({{ y }}, na.rm = na.rm)
        ) |> 
        dplyr::pull(ybar)
    rmse(data, {{ x }}, {{ y }}, na.rm = na.rm) / ybar * 100
}

#' mae
#' 
#' compute mean absolute error
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
mae <- function(data, x, y, na.rm = FALSE) {
    
    data |>
        dplyr::summarize(
            mae = mean(abs({{ x }} - {{ y }}), na.rm = na.rm)
        ) |>
        dplyr::pull(mae)
}

#' Percent mae
#'
#' mae divided by mean response value
#'
#' @inheritParams rmse 
#'
#' @return
#' @export
#'
p_mae <- function(data, x, y, na.rm = FALSE) {
    
    ybar <- data |> 
        dplyr::summarize(
            ybar = mean({{ y }}, na.rm = na.rm)
        ) |> 
        dplyr::pull(ybar)
    mae(data, {{ x }}, {{ y }}, na.rm = na.rm) / ybar * 100
}

#' mae standard error
#' 
#' compute a standard error estimate for mae
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
mae_se <- function(data, x, y, na.rm = FALSE) {
    
    data |> 
        dplyr::summarize(
            mae_se = sqrt(var(abs({{ x }} - {{ y }}), na.rm = na.rm)) / 
                sqrt(dplyr::n())
        ) |> 
        dplyr::pull(mae_se)
}

#' mbe
#' 
#' compute mean bias error
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
mbe <- function(data, x, y, na.rm = FALSE) {
    
    data |>
        dplyr::summarize(
            mbe = mean({{ x }} - {{ y }}, na.rm = na.rm)
        ) |>
        dplyr::pull(mbe)
}

#' mbe standard error
#'
#' compute a standard error estimate for mbe
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
mbe_se <- function(data, x, y, na.rm = FALSE) {
    
    data |>
        dplyr::summarize(
            mbe_se = sqrt(var({{ x }} - {{ y }}, na.rm = na.rm)) /
                sqrt(dplyr::n())
        ) |> 
        dplyr::pull(mbe_se)
}

#' R-squared
#'
#' compute r-squared (coefficient of determination)
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
r2 <- function(data, x, y, na.rm = FALSE) {
    
    ybar <- data |> 
        dplyr::summarize(
            ybar = mean({{ y }}, na.rm = na.rm)
        ) |> 
        dplyr::pull(ybar)
    sst <- data |> 
        dplyr::summarize(
            sst = sum(({{ y }} - ybar)^2, na.rm = na.rm)
        ) |> 
        dplyr::pull(sst)
    data |>
        dplyr::summarize(
            r2 = 1 - (sum(({{ x }} - {{ y }})^2, na.rm = na.rm) / sst),
        ) |>
        dplyr::pull(r2)
}

#' R-squared standard error
#'
#' compute a standard error estimate for r-squared via 1000 bootstrap iterations
#'
#' @inheritParams rmse
#'
#' @return
#' @export
#'
r2_se <- function(data, x, y, na.rm = FALSE) {
    
    var(unlist(lapply(
        1:1000,
        \(i) {
            idx = sample(
                1:nrow(data) ,
                nrow(data),
                replace = TRUE
            )    
            r2(data[idx, ], {{ x }}, {{ y }}, na.rm = na.rm)
        }
    )), na.rm = na.rm)
}