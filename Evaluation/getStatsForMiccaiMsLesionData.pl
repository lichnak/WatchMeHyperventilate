#/usr/bin/perl -w

use strict;

use Cwd 'realpath';
use File::Find;
use File::Basename;
use File::Path;
use File::Spec;
use FindBin qw($Bin);

my $usage = qq{
  Usage:
 };

my @miccaiDirectories = ();

$miccaiDirectories[0] = '/Users/ntustison/Downloads/CHB_train_Part1/';
$miccaiDirectories[1] = '/Users/ntustison/Downloads/CHB_train_Part2/';
$miccaiDirectories[2] = '/Users/ntustison/Downloads/UNC_train_Part1/';
$miccaiDirectories[3] = '/Users/ntustison/Downloads/UNC_train_Part2/';

my $statsFile = '/Users/ntustison/Desktop/miccaiMsLesionStats.csv';
open( FILE, ">${statsFile}" );

print FILE "SubjectId,LesionLabel,PixelVolume,Volume\n";

for( my $i = 0; $i < @miccaiDirectories; $i++ )
  {
  my @lesionImages = <${miccaiDirectories[$i]}/*//*lesion.nhdr>;

  for( my $j = 0; $j < @lesionImages; $j++ )
    {
    print "Processing ${lesionImages[$j]}\n";

    ( my $tmpLesion = ${lesionImages[$j]} ) =~ s/\.nhdr/\Tmp\.nii\.gz/;

    my ( $filename, $path, $suffix ) = fileparse( $lesionImages[$j], ".nhdr" );

    my $spacingString = `GetImageInformation 3 $lesionImages[$j] 1`;
    my @spacing = split( 'x', $spacingString );
    my $pixelVolume = $spacing[0] * $spacing[1] * $spacing[2];

    `GetConnectedComponents 3 $lesionImages[$j] $tmpLesion`;
    my @out = `LabelGeometryMeasures 3 $tmpLesion`;

    for( my $k = 1; $k < @out; $k++ )
      {
      my @stats = split( ' ', ${out[$k]} );

      print "  Label ${stats[0]}\n";

      print FILE "${filename},${stats[0]},$pixelVolume,${stats[1]}\n";
      }
    }
  }


close( FILE )