#!MC	1100
#setdep @node|-1:all@

## Delete the top frame
$!FRAMECONTROL DELETETOP

## Load data in Tecplot using the SWB-Loader
$!READDATASET "n@node|-2@_des.tdr" DATASETREADER = "SWB-Loader"

## Fit the entire plot to the grid area
$!VIEW FIT
