#' Hexagonal Tesselation
#' 
#' Produce a hexaganal tesselation across a shape
#'
#' @param separation distance between hexagonal centroids in km
#' @param bounds a bounding shape (sf::sf object) in a projected coordinate 
#'   system with units in meters
#'
#' @return an sf::sf object
#' @export
#'
hex_tesselation <- function(separation, bounds) {
    
    hex_polys <- sf::st_sf(
        sf::st_make_grid(
            bounds,
            cellsize = separation * 1000,
            square = F
        )
    )
    hex_polys <- hex_polys |>
        dplyr::filter(sf::st_intersects(hex_polys, bounds, sparse = F))
    
    hex_polys$object_id <- 1:nrow(hex_polys)
    
    return(hex_polys)
}
