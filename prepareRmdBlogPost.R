###
###
###
###   Purpose:   Prepare directory structure for a new Rmd post
###   started:   2014/11/04 (pvr)
###
### ############################################################# ###
###
### # global constants
default.blogdir <- "/Users/peter/Data/Projects/GitHub/charlotte-ngs.github.io"

prepareRmdBlogPost <- function(psBlogPost, psWorkDir = default.blogdir) {
  ###
  ###   prepareRmdBlogPost(psBlogPost, psWorkDir): changes the current
  ###      working directory to psWorkDir and creates a subdirectory 
  ###      rmd/psBlogPost to start a new post.
  ### ################################################################# ###
  ### # change current working directory to psWorkDir
  setwd(psWorkDir)
  ### # create subdirectory rmd/psBlogPost
  dir.create(path = file.path("rmd", psBlogPost))
  
}