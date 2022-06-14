#' Plot Pixel Extraction
#' 
#' Extract map values at plot polygons for comparison
#'
#' @param surface Raster::RasterLayer or terra::SpatRaster
#' @param plots sf::sf or terra::SpatVector
#' @param id string indicating of column that identifies individual plots
#' @param na.rm boolean indicating wether or not NA pixels should be ignored 
#'   in the extraction
#'
#' @return an sf object with val column added 
#' @export
#'
plot_pixel_extraction <- function(surface, plots, agg_columns = NULL,
                                  id = "PLOT", na.rm = FALSE) {
    if (!nrow(plots)) {
        return(data.frame())
    }
    if (na.rm) {
        fun <- 'mean' # NApls in the extraction are ignored
    } else {
        fun <- weighted.mean # any NAs in the extraction will result in NA
    }
    plots <- plots |> 
        group_by(across(id)) |> 
        summarize(across(agg_columns, mean, na.rm = na.rm))
    plots$val <- exactextractr::exact_extract(
        as(surface, 'Raster'),
        plots,
        fun,
        progress = FALSE
    )
    return(plots)
}


#' Aggregate Unit Extraction
#'
#' Extract map values within aggregation units for comparison
#'
#' @inheritParams plot_pixel_extraction
#' @param agg_units sf::sf polygons demarking units over which comparisons 
#'   will be made
#' @param sampling_correction boolean. If TRUE only pixels coincident with 
#'   plot polygons will be extracted. If FALSE all pixels with an agg_unit
#'   will be extracted for copmarison.
#'
#' @return sf::sf object containing aggregation unit polygons and summarized
#'   values
#' @export
#'
agg_extraction <- function(surface, plots, agg_columns, agg_units, 
                           id = "PLOT", sampling_correction = TRUE,
                           na.rm = FALSE) {
    
    if (na.rm) {
        extract_fun <- 'mean' # NAs in the extraction are ignored
    } else {
        extract_fun <- weighted.mean # any NAs in the extraction will be NA
    }
    
    plot_centroids <- compute_plot_centroids(
        plots, 
        id = id, 
        agg_columns = agg_columns,
        na.rm = na.rm
    ) |> 
        dplyr::arrange({{id}})
    if (sampling_correction) {
        plot_pixel_values <- plot_pixel_extraction(
            surface, 
            plots, 
            id = id, 
            na.rm = na.rm
        ) |> 
            dplyr::arrange({{id}})
        plot_centroids$val <- plot_pixel_values$val
    }
    agg_results <- do.call(rbind, lapply(
        seq_len(nrow(agg_units)), 
        \(i) {
            agg_i <- agg_units[i,]
            agg_plots <- dplyr::filter(
                plot_centroids, 
                sf::st_intersects(plot_centroids, agg_i, sparse = FALSE)
            )
            if (!nrow(agg_plots)) {
                return(NULL)
            }
            if (sampling_correction) {
                agg_i$val <- mean(agg_plots$val, na.rm = na.rm)    
            } else {
                agg_i$val <- exactextractr::exact_extract(
                    as(surface, 'Raster'),
                    agg_i, 
                    extract_fun,
                    progress = FALSE
                )
            }
            agg_i <- cbind(
                agg_i, 
                agg_plots |> dplyr::summarize(
                    dplyr::across(agg_columns, mean, na.rm = na.rm),
                    num_plots = n()
                ) |> as.data.frame() |> dplyr::select(-geometry)
                
            ) 
            return(agg_i)
        }
    ))
    return(agg_results)
}

#' Aggregate plot pixel
#' 
#' Aggregate tabular results from plot_pixel_extraction
#'
#' @param plots results from plot_pixel_extraction
#' @param agg_units sf::sf polygons demarking units over which comparisons 
#'   will be made
#' @param x modeled value
#' @param y reference value
#' @param na.rm boolean indicating wether or not NA pixels should be ignored 
#'   in the extraction
#'
#' @return sf::sf object containing aggregation unit polygons and summarized
#'   values
#' @export
#'
aggregate_plot_pixel <- function(plots, agg_units, x, y, na.rm = FALSE) {
    
    agg_results <- do.call(rbind, lapply(
        seq_len(nrow(agg_units)), 
        \(i) {
            agg_i <- agg_units[i,]
            agg_plots <- dplyr::filter(
                plots, 
                sf::st_intersects(plots, agg_i, sparse = FALSE)
            )
            if (!nrow(agg_plots)) {
                return(NULL)
            }
            agg_i[[x]] <- mean(agg_plots[[x]], na.rm = na.rm)    
            agg_i <- cbind(
                agg_i, 
                agg_plots |> dplyr::summarize(
                    dplyr::across(y, mean, na.rm = na.rm),
                    num_plots = n()
                ) |> as.data.frame() |> dplyr::select(-geometry)
                
            ) 
            return(agg_i)
        }
    ))
    return(agg_results)
}


#' Compute plot centroids
#'
#' @param plots sf::sf or terra::SpatVector
#' @param id string indicating of column that identifies individual plots
#'
#' @return sf::sf object containing point geometries
#' @export
#'
compute_plot_centroids <- function(plots, id = "PLOT", agg_columns = NULL, 
                                   na.rm = FALSE) {
    
    plot_centroids <- sf::st_centroid(plots)    
    if (length(unique(plot_centroids[[id]])) < nrow(plot_centroids)) {
        plot_centroids <- plot_centroids |>
            dplyr::group_by(across(id)) |>
            summarize(across(agg_columns, mean, na.rm = na.rm)) |>
            sf::st_centroid()
    }
    return(plot_centroids)
}


