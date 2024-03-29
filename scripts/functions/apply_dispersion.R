#####################################################
### Main goal: Verify the effect of plasticity on adaptive evolution #####################
##### Diversification and Trait Evolution ~ Plasticity #####
##### Methods: Computational simulation #############
##### FUNCTION: APPLY DISPERSION WITH LIMIT #####

disperse2 <- function (species, landscape, distance_matrix, config) {
  if (!length(species[["abundance"]])) {
    return(species)
  }
  presence_spi_ti <- names(species[["abundance"]])
  all_cells <- rownames(landscape$coordinates)
  free_cells <- all_cells[!(all_cells %in% presence_spi_ti)]
  if(length(free_cells) >= 1){
    if(length(free_cells) >= 270){
      free_cells <- free_cells %>%
        sample(270) %>% as.numeric() %>%
        sort() %>% as.character()
    } else {
      half <- round(length(free_cells) - (length(free_cells) * 0.5))
      free_cells <- free_cells %>%
        sample(half) %>% as.numeric() %>%
        sort() %>% as.character()
    }
  }
  num_draws <- length(free_cells) * length(presence_spi_ti)
  r_disp <- config$gen3sis$dispersal$get_dispersal_values(num_draws, 
                                                          species, landscape, config)
  geo_disp <- distance_matrix[presence_spi_ti, free_cells, 
                              drop = FALSE]
  geo_disp <- geo_disp <= r_disp
  colonized <- rep(FALSE, length(all_cells))
  names(colonized) <- all_cells
  colonized[free_cells] <- apply(geo_disp, 2, any)
  tep_occ_id <- all_cells[colonized]
  if (length(tep_occ_id) > 0) {
    dest <- which(colonized == TRUE)
    if (length(presence_spi_ti) == 1) {
      orig <- rep(1, length(dest))
    }
    else {
      orig <- apply(geo_disp[, colonized[free_cells], 
                             drop = FALSE], 2, function(x) {
                               a <- which(x)
                               ifelse(length(a) > 1, sample(a, 1), a)
                             })
    }
    orig <- as.numeric(presence_spi_ti[orig])
    dest <- tep_occ_id
    species <- disperse_species(species, as.character(orig), 
                                dest, config)
  }
  return(species)
}