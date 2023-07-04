#!/bin/sh

set -e

RNG='-R-0.25/0.75/-0.25/0.25'
DIM='8i/4i'
PRJ="-JX$DIM"

EPS='compose.eps'

# background scalar (vorticity)

GRD='scalar-fine.grd'
CPT='scalar.cpt'

gmt grdsample grd/scalar.grd -G$GRD $RNG -I1024+n/512+n
gmt grdimage $GRD $PRJ $RNG -C$CPT -K > $EPS
gmt grdcontour $GRD $PRJ $RNG -C$CPT -A- -O -K >> $EPS
rm -rf $GRD

# The half-cylinder in domain.xy

gmt psxy $PRJ $RNG -L -Gwhite -W1 domain.xy -O -K >> $EPS

# vfplot output

gmt psimage vfplot.eps -W$DIM -Dx0/0 -O >> $EPS

# results

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

# clean up

rm -r $EPS
