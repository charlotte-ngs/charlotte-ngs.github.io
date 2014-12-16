###
###
###
###    Purpose:   Put a series of data frames into a list
###    started:   2014/10/28 (pvr)
###
### ####################################################### ###


### # functions
generateData <- function(psFnamePrefix, pnNrOutFiles) {
  
  for (i in 1:pnNrOutFiles) {
    fname <- paste(psFnamePrefix, i, ".txt", sep = "")
    colnorm <- rnorm(10)
    colbinom <- unlist(lapply(rep("AB", 10), function(x) paste(x, rbinom(1,20,0.3), sep = "")))
    colpois <- rpois(10, 0.2)
    cat("'*** writing data to file: ", fname, "\n")
    write.table(data.frame(colnorm,colbinom,colpois), file = fname, row.names = FALSE)
  } 
}

readDataToList <- function(psFnamePrefix) {
  ### # put files into a list of data frames
  files <- list.files(pattern = psFnamePrefix)
  
  ### # loop over files
  ldfr <- list()
  for (i in 1:length(files)) {
    curDfr <- read.table(file = files[i], header = TRUE, as.is = TRUE)
    ldfr <- c(ldfr, list(curDfr))
  }
  return(ldfr)  
}


### # generate data
nrOutFiles <- 3
fnamePrefix <- "chr_"


#generateData(psFnamePrefix = fnamePrefix, pnNrOutFiles = nrOutFiles)

# read the data
lResData <- readDataToList(psFnamePrefix = fnamePrefix)

