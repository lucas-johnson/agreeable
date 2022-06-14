
#' Summary agreement metrics
#'
#' @param data a data.frame containing two datasets to compare (x and y)
#' @param x name of column in data (predicted)
#' @param y name of column in data (response)
#' @param na.rm boolean indicating whether or not to ignore NA values
#'
#' @return a data.frame
#' @export
#'
summary_table <- function(data, x, y, na.rm = FALSE) {
    
    data.frame(
        rmse = rmse(data, {{ x }}, {{ y }}, na.rm = na.rm),
        p_rmse = p_rmse(data, {{ x }}, {{ y }}, na.rm = na.rm),
        rmse_se = rmse_se(data, {{ x }}, {{ y }}, na.rm = na.rm),
        mae = mae(data, {{ x }}, {{ y }}, na.rm = na.rm),
        p_mae = p_mae(data, {{ x }}, {{ y }}, na.rm = na.rm),
        mae_se = mae_se(data, {{ x }}, {{ y }}, na.rm = na.rm),
        mbe = mbe(data, {{ x }}, {{ y }}, na.rm = na.rm),
        mbe_se = mbe_se(data, {{ x }}, {{ y }}, na.rm = na.rm),
        r2 = r2(data, {{ x }}, {{ y }}, na.rm = na.rm),
        r2_se = r2_se(data, {{ x }}, {{ y }}, na.rm = na.rm),
        gmfr_slope = gmfr_slope(data, {{ x }}, {{ y }}, na.rm = na.rm),
        gmfr_intercept = gmfr_intercept(data, {{ x }}, {{ y }}, na.rm = na.rm),
        ac = ac(data, {{ x }}, {{ y }}, na.rm = na.rm),
        acu = acu(data, {{ x }}, {{ y }}, na.rm = na.rm),
        acs = acs(data, {{ x }}, {{ y }}, na.rm = na.rm)
    )
}

#' Plot pixel summary
#'
#' Compute agreement summary over plots
#'
#' @param surface RasterLayer or SpatRaster containing predictions
#' @param plots sf::sf object containing plot polygons of reference data
#' @param y name of response contained in plots
#' @param agg_columns vector of column names that we want to aggregate over
#' @param id name of field uniquely identifying plots
#' @inheritParams summary_table
#'
#' @return a data.frame
#' @export
#'
plot_pixel_summary <- function(surface, plots, y, agg_columns = NULL, 
                               id = "PLOT", na.rm = FALSE) {
    
    plot_pixel_comparison <- plot_pixel_extraction(
        surface, 
        plots, 
        agg_columns = y, 
        id = id, 
        na.rm = na.rm
    )
    list(
        n = nrow(plot_pixel_comparison),
        summary = summary_table(
            as.data.frame(plot_pixel_comparison), 
            "val", 
            {{ y }},
            na.rm = na.rm
        )
    )
    
}

#' Aggregate summary
#' 
#' Compute agreement summary over aggregation units
#'
#' @param agg_units sf::sf polygons demarking units over which comparisons 
#'   will be made
#' @param sampling_correction boolean. If TRUE only pixels coincident with 
#'   plot polygons will be extracted. If FALSE all pixels with an agg_unit
#'   will be extracted for copmarison.
#' @inheritParams plot_pixel_summary
#' @return a data.frame
#' @export
#'
agg_summary <- function(surface, plots, y, agg_units, 
                        id = "PLOT", sampling_correction = TRUE, 
                        na.rm = FALSE) {
    
    
    agg_comparison <- agg_extraction(
        surface, 
        plots,
        agg_columns = y, 
        agg_units,
        id = id,
        sampling_correction = sampling_correction,
        na.rm = na.rm
    )
    list(
        n = nrow(agg_comparison),
        summary = summary_table(agg_comparison, "val", {{ y }}, na.rm = na.rm),
        ppu = mean(agg_comparison, n, na.rm = TRUE)
    )
}