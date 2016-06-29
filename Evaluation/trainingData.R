library( ggplot2 )

td <- read.csv( "trainingData.csv" )

myPlot <- ggplot( data = td, aes( Volume ) ) +
          geom_histogram( binwidth = 1 )
ggsave( "myPlot.pdf", plot = myPlot, width = 10, height = 5 )

tdHist <- hist( td$Volume, breaks = 200 )
