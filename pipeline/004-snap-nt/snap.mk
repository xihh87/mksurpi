## The directory where the reference is used
SNAP_REFERENCEDIR='/reference/FAST_SNAP'

## Here you should set aditional options for snap
##
## In example, SURPI defaults:
##
SNAP_OPTS='-x -f -h 250 -n 25'

## Only output aligned regions:
SNAP_OPTS=$SNAP_OPTS' -F a'

## Recommended options by organism:
##
## - Human:
SNAP_OPTS=$SNAP_OPTS' -d 12'

## Recommended cache options:
##
## - reference on cache:
#SNAP_OPTS=$SNAP_OPTS' -map'
##
## - reference not in cache:
SNAP_OPTS+=' -pre -map'

## By default SNAP uses all available cores.
## to use less cores, uncomment the following option,
## where 24 is the max number of cores you want to use:
SNAP_OPTS=$SNAP_OPTS' -t 24'
