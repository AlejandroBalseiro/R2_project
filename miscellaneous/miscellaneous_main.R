# miscellaneous_main

# directory set up
directory <- "R2_project/R"

setwd(directory)

lapply(paste0("R/", list.files(path = "R/", recursive = TRUE)), source)


# Debugging and unbugging
debug(main)
main(directory)
undebug(main)