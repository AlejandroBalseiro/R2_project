#' @title main
#' @description Main package function
#' 
#' @param path The environment of project
#' 
#' @export
#' @import logging
#'
#' @author Javi Gil, Mar, Andreea, Alex
#' 
main <- function (path){
  tryCatch(expr = {
    
    library(logging)
    
    addHandler(writeToFile, logger = 'log', file = paste0(path, "/log/logfile.log"))
    loginfo("Starting program", logger = 'log')
    
    #Config
    loginfo("Reading config...", logger = 'log')
    config <- read_config(path)
    loginfo("Config readed", logger = 'log')
    
    #data
    loginfo("Reading data...", logger = 'log')
    df_1 <- read_data(config, path)
    loginfo("Data readed", logger = 'log')
    
    #Data Cleaning and data wrangling
    loginfo("Data cleaning and data wrangling process: ON", logger = 'log')
    df_1 <- reshape_data(config, df_1)
    loginfo("Data cleaning and data wrangling process: Finished", logger = 'log')
    
    #Machine Learning process
    loginfo("Loading Machine learning process...", logger = 'log')
    output <- to_ML(df_1, config)
    loginfo("Machine Learning model generated", logger = 'log')
    
    #Output
    loginfo("Output generation...", logger = 'log')
    createOutput(output, config, path)
    loginfo("Output generated", logger = 'log')
    
  }, error = function(e){
    
    logerror("ERROR", logger = 'log')
    stop()
    
  }, finally = {
    
    loginfo("Program finished.", logger = 'log')
    removeHandler(writeToFile, logger = 'log')
    
  })
}