# miscellaneous_main

# directory set up


setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

directory <- setwd("..")

print(directory)

lapply(paste0("R/", list.files(path = "R/", recursive = TRUE)), source)


# Debugging and unbugging
debug(main)
main(directory)
undebug(main)