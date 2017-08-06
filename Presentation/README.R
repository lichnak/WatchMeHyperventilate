#!/usr/bin/env Rscript
#
# ants wip / future work
#
library(ggplot2)
library(shiny)
library(rmarkdown)

srcdir<-"./"
buildrmd='wmhBuild.Rmd'

# first presentation
# rawrmds <- c( "format.Rmd",
#               "antsBackground.Rmd",
#               "wmh.Rmd"
#                )

# Second presentation:  August 11, 2017
rawrmds <- c( "format.Rmd",
              "wmh.Rmd"
               )


for ( x in 1:length(rawrmds) ) {
  if ( x == 1 )  
    {
    cmd<-paste( "cat ",rawrmds[x]," > ",buildrmd ) 
    } else { 
    cmd<-paste( "cat ",rawrmds[x]," >> ",buildrmd )
    }
  system(cmd)
}
render(buildrmd, clean=TRUE )
