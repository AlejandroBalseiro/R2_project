# miscellaneous_main

# directory set up
<<<<<<< HEAD
 

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

directory <- setwd("..")

=======


#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#directory <- setwd("..")
directory <- getwd()
>>>>>>> Andreea
print(directory)

lapply(paste0("R/", list.files(path = "R/", recursive = TRUE)), source)


# Debugging and unbugging
debug(main)
main(directory)
undebug(main)