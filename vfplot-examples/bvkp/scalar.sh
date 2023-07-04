#!/bin/sh

set -e

# this script creates scalar.png, a rough colour-map of vorticity
# which is used by vfplot.pov to colour the symbols in the plot.
# The tricky bit is to select a subimage which is the "right
# size" for the vfplot output

GFS='gfs/frame-2.0.gfs'

BASE='scalar'
CSV='/tmp/${BASE}.csv'
GRD='/tmp/${BASE}.grd'
EPS='/tmp/${BASE}.eps'

gfs-csv -v -s Vorticity $GFS -o $CSV
gmt xyz2grd -r -R-0.5/1.5/-0.5/0.5 -I256+/128+ $CSV -G$GRD

RNG="-R-0.3/0.7/-0.3/0.3"
PRJ="-JX4i/2.4i"

gmt grdimage $GRD $RNG $PRJ -Cscalar.cpt > $EPS

gmt psconvert -A -E300 -F$BASE -Tg $EPS

rm -f $CSV $GRD $EPS
