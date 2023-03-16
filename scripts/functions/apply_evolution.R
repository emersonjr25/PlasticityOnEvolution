#####################################################
### Main goal: Verify the effect of plasticity on adaptive evolution #####################
##### Diversification and Trait Evolution ~ Plasticity
##### Methods: Computational simulation #############
##### FUNCTION: APPLY EVOLUTION WITHOUT CLUSTERS #####

# config$gen3sis$mutation$apply_evolution <- function(species, cluster_indices, landscape, config) {
# 
#   trait_evolutionary_power <- 0.001
#   traits <- species[["traits"]]
#   cells <- rownames(traits)
#   #mutations
#   mutation_deltas <-rnorm(length(traits[, "temp"]), mean=0, sd=trait_evolutionary_power)
#   traits[, "temp"] <- traits[, "temp"] + mutation_deltas
#   return(traits)
# }