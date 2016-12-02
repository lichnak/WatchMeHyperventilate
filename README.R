library( rmarkdown )
library( ggplot2 )
library( RISmed )

formatFile <- "format.Rmd"

######################################
#
#  Clean
#
stitchedFile <- "stitched.Rmd";

rmdFiles <- c( formatFile,
               "abstract.Rmd",
               "intro.Rmd",
               "methods.Rmd",
               "results.Rmd",
               "discussion.Rmd",
               "acknowledgementsDisclaimers.Rmd"
   )

for( i in 1:length( rmdFiles ) )
  {
  if( i == 1 )
    {
    cmd <- paste( "cat", rmdFiles[i], ">", stitchedFile )
    } else {
    cmd <- paste( "cat", rmdFiles[i], ">>", stitchedFile )
    }
  system( cmd )
  }

cat( '\n Pandoc rendering', stitchedFile, '\n' )
render( stitchedFile, output_format = c( "pdf_document", "word_document" ) )

######################################
#
#  Annotated
#
stitchedFile <- "stitchedX.Rmd";

rmdFiles <- c( formatFile,
               "abstractX.Rmd",
               "introX.Rmd",
               "methodsX.Rmd",
               "resultsX.Rmd",
               "discussionX.Rmd",
               "acknowledgementsDisclaimers.Rmd"
   )

for( i in 1:length( rmdFiles ) )
  {
  if( i == 1 )
    {
    cmd <- paste( "cat", rmdFiles[i], ">", stitchedFile )
    } else {
    cmd <- paste( "cat", rmdFiles[i], ">>", stitchedFile )
    }
  system( cmd )
  }

cat( '\n Pandoc rendering', stitchedFile, '\n' )
render( stitchedFile, output_format = "pdf_document" )


singleRmdFiles <- c(
               "responseToReviewers2.Rmd",
               "figureCaptions.Rmd"
   )

for( i in 1:length( singleRmdFiles ) )
  {
  cat( '\n Pandoc rendering', singleRmdFiles[i], '\n' )
  render( singleRmdFiles[i], output_format = c( "pdf_document", "word_document" ) )
  }


