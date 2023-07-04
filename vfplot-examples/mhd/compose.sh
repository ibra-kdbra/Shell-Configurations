#!/bin/sh

set -e

EPS='compose.eps'

RNG='-R0/1/0/1'
DIM='7i'
PRJ="-JX$DIM"

# the background scalar field (temperature)

gmt grdimage grd/scalar.grd $PRJ $RNG -Cscalar.cpt -K > $EPS

# vfplot output

gmt psimage vfplot.eps -W$DIM -Dx0/0 -O >> $EPS

# convert to output formats

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

# clean up

rm -r $EPS
