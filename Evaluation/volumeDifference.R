library( ggplot2 )

# whichEval <- 'Results_500Samples'
# whichEval <- 'ResultsMorphology_500Samples'
# whichEval <- 'ResultsOriginal_500Samples'
whichEval <- 'ResultsMorphologyOriginal_500Samples'

td <- read.csv( "trainingData.csv" )
ev <- read.csv( paste0( '~/Desktop/wmhEvaluation/', whichEval, '/evaluation', whichEval, '.csv' ) )

tdQ <- quantile( td$Volume, c( 0.3333333, 0.66666666, 1.0 ) )

types <- c( "FalseNegative", "FalsePositive", "TruePositive" )

boxPlotDataFrame <- data.frame( Subject = character( 0 ), Stage = character( 0 ),
                                Quantile = character( 0 ), Value = numeric( 0 ) )

for( i in 0:23 )
  {
  subjectIndex <- i

  for( stage in 1:2 )
    {
    for( j in 1:length( tdQ ) )
      {
      quantLeft <- 3
      if( j > 1 )
        {
        quantLeft <- tdQ[j-1]
        }
      quantRight <- tdQ[j]

      indicesFN <- which( ev$Type == "FalseNegative" & ev$SubjectIndex == subjectIndex & ev$Stage == stage & ev$TrueVolume >= quantLeft & ev$TrueVolume < quantRight )
      indicesFP <- which( ev$Type == "FalsePositive" & ev$SubjectIndex == subjectIndex & ev$Stage == stage & ev$PredictedVolume >= quantLeft & ev$PredictedVolume < quantRight )
      indicesTP <- which( ev$Type == "TruePositive" & ev$SubjectIndex == subjectIndex & ev$Stage == stage & ev$TrueVolume >= quantLeft & ev$TrueVolume < quantRight )

      numberOfFalseNegatives <- length( ev$TrueVolume[indicesFN] )
      numberOfFalsePositives <- length( ev$TrueVolume[indicesFP] )
      numberOfTruePositives <- length( ev$TrueVolume[indicesTP] )

      f1 <- 2 * numberOfTruePositives / ( 2 * numberOfTruePositives + numberOfFalseNegatives + numberOfFalsePositives )
      sensitivity <- numberOfTruePositives / ( numberOfTruePositives + numberOfFalseNegatives )
      ppv <- numberOfTruePositives / ( numberOfTruePositives + numberOfFalsePositives )

      if( ! is.nan( sensitivity ) )
        {
        boxPlotDataFrame <- rbind( boxPlotDataFrame, data.frame(
                                   Subject = as.factor( subjectIndex ),
                                   Stage = as.factor( stage ),
                                   Quantile = as.factor( j ),
                                   MeasureType = 'F1', Value = f1 )
                                 )
        boxPlotDataFrame <- rbind( boxPlotDataFrame, data.frame(
                                   Subject = as.factor( subjectIndex ),
                                   Stage = as.factor( stage ),
                                   Quantile = as.factor( j ),
                                   MeasureType = 'Sensitivity', Value = sensitivity )
                                 )
        boxPlotDataFrame <- rbind( boxPlotDataFrame, data.frame(
                                   Subject = as.factor( subjectIndex ),
                                   Stage = as.factor( stage ),
                                   Quantile = as.factor( j ),
                                   MeasureType = 'PPV', Value = ppv )
                                 )
        }
      }
    }
  }



boxPlotF1DataFrame <- boxPlotDataFrame[which( boxPlotDataFrame$MeasureType == 'F1' ),]
myBoxPlotF1 <- ggplot( boxPlotF1DataFrame, aes( x = Quantile, y = Value ) ) +
                   geom_boxplot( aes( fill = Stage ) ) +
                   scale_x_discrete( "Quantile" ) +
                   scale_y_continuous( "F1", limits = c( 0, 1 ) )
ggsave( filename = paste( '~/Desktop/wmhEvaluation/', whichEval, '/F1.pdf', sep = "" ), plot = myBoxPlotF1, width = 6, height = 4, units = 'in' )

boxPlotSensitivityDataFrame <- boxPlotDataFrame[which( boxPlotDataFrame$MeasureType == 'Sensitivity' ),]
myBoxPlotSensitivity <- ggplot( boxPlotSensitivityDataFrame, aes( x = Quantile, y = Value ) ) +
                   geom_boxplot( aes( fill = Stage ) ) +
                   scale_x_discrete( "Quantile" ) +
                   scale_y_continuous( "Sensitivity", limits = c( 0, 1 ) )
ggsave( filename = paste( '~/Desktop/wmhEvaluation/', whichEval, '/Sensitivity.pdf', sep = "" ), plot = myBoxPlotSensitivity, width = 6, height = 4, units = 'in' )

boxPlotPPVDataFrame <- boxPlotDataFrame[which( boxPlotDataFrame$MeasureType == 'PPV' ),]
myBoxPlotPPV <- ggplot( boxPlotPPVDataFrame, aes( x = Quantile, y = Value ) ) +
                   geom_boxplot( aes( fill = Stage ) ) +
                   scale_x_discrete( "Quantile" ) +
                   scale_y_continuous( "PPV", limits = c( 0, 1 ) )
ggsave( filename = paste( '~/Desktop/wmhEvaluation/', whichEval, '/PPV.pdf', sep = "" ), plot = myBoxPlotPPV, width = 6, height = 4, units = 'in' )




