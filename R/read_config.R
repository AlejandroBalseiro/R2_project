
#' @title read_config
#' 
#' @description This function is called by the skeleton function and read the config
#' 
#' @param path The environment of project
#'
#' @return
#' 
#' @import XML
#' @import logging
#'
#install.packages("XML")
#install.packages("logging")
path <- directory

library(logging)
read_config <- function (path){

  library(XML)

  configPath <- paste0(path, "/config/config.xml")
  
  
  tryCatch(expr = {
    
    #Read xml and convert it to a list
    config <- XML::xmlToList(xmlParse(configPath))
    
    library("methods")
    result <- xmlParse(file = configPath)
    config <- xmlToList(result, addAttributes = TRUE, simplify = FALSE)
    
  }, error = function(e){
    
    logerror("Config was not find on the path. Check if it´s call config.xml",
             logger = 'log')
    stop()
  })
  
  loginfo("Config readed.", logger = 'log')
  
  validateConfigNodes(config)
  
  config$data$predictors <- trimws(strsplit(config$data$predictors, ",")[[1]])
  
  target <- is.null(config$data$target)
  if(target){
    logerror("Target is ampty, choose another one", logger = 'log')
    stop()
  }
  
  country <- is.null(config$data$prediction$country)
  if(country){
    logerror("You need to choose one country", logger = 'log')
    stop()
  }
  
  year <- is.null(config$data$prediction$year)
  
  if(year){
    logerror("You need to choose the year", logger = 'log')
    stop()

  }else{
    
    config$data$prediction$year <- as.numeric(config$data$prediction$year)
    
  }
  
  year_na <- is.na(config$data$prediction$year)
  
  if(year_na){
    logerror("The year should be a number", logger = 'log')
    stop()
    
  } 
 
  testRate <- is.null(config$testRate)
  
  if(testRate){
    
    logerror("You need to choose the test rate", logger = 'log')
    stop()
    
  }else{
    
      config$testRate <- as.numeric(config$testRate)
  } 
  
  minorUno <- config$testRate < 1
  mayorZero <- config$testRate > 0
  
  if(!(minorUno && mayorZero)){
    
    logerror("The test rate should ne a number between 0 and 1 ", logger = 'log')
    stop()    
    
  }
  
  testRate_Na <- is.na(config$testRate)
  
  if(testRate_Na){
    
    logerror("The test rate should be a number", logger = 'log')
    stop()
    
  }
  
  outputFile <- is.null(config$outputFile)
  if(outputFile){
    
    logerror("No output file, create it", logger = 'log')
    
    stop()
  }

  separador <- config$sep %in% c(",", ";")
  if(!separador){
    loggeror("Sep just can be , or ;", logger = "log")
    stop()
  }
  
  return(config)
  
} 


# validateConfigNodes function
 
validateConfigNodes <- function(config){
  
  nodoPrincipal <- identical(names(config), c("sep", "data", "testRate","outputFile"))
  nodoData <- identical(names(config$data), c("predictors", "target", "prediction"))
  nodoPrediction <- identical(names(config$data$prediction), c("country", "year"))

  nodos <- c("nodoPrincipal" = nodoPrincipal, "nodoData" = nodoData, 
             "nodoPrediction" = nodoPrediction)
  
  check <- all(nodos)
  
  if(!check){
    
    nodosMalos <- names(nodos)[!nodos]
    
    logerror(paste0("The nodes: ", paste(nodosMalos, collapse = ", "),
                    " are poorly structured"), logger = 'log')
    stop()
    
  }
  
}

x=read_config(path)
print(x)
