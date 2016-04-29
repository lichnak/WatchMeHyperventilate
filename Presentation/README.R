#!/usr/bin/env Rscript
#
# ants wip / future work
#
library(ggplot2)
library(shiny)
library(ggvis)
library(rmarkdown)

srcdir<-"./"
buildrmd='wmhBuild.Rmd'

rawrmds <- c( "format.Rmd",
              "antsBackground.Rmd",
              "wmh.Rmd"
               )

for ( x in 1:length(rawrmds) ) {
  if ( x == 1 )  cmd<-paste( "cat ",rawrmds[x]," > ",buildrmd ) else cmd<-paste( "cat ",rawrmds[x]," >> ",buildrmd )
  system(cmd)
}
render(buildrmd, clean=TRUE )
