#!/bin/sh

set -e

EPS='compose.eps'

RNG='-R-0.5/0.5/-0.25/1.375'
DIM='8i/13i'
PRJ="-JX$DIM"

# the background scalar field (temperature)

gmt grdimage grd/scalar.grd $PRJ $RNG -Cscalar.cpt -K > $EPS

# the vertical walls, these are at the edge of the plot
# so when we draw them, half of the pen-stroke is lost,
# so we double it

gmt psxy $PRJ $RNG -W0.2c -K -O <<EOF >> $EPS
-0.5 -0.25
-0.5 1.375
>
0.5 -0.25
0.5 1.375
EOF

# the heated cylinder, since a simple circle we can just
# use the GMR circle symbol, the original GFS source is
# radius 1/16 at (0, -0.15), but GMT symbols are specified
# as diameter in projected size, so 1/16 x 8in x 2 = 1in

gmt psxy $PRJ $RNG -Sc1i -W0.1c -Gwhite -K -O <<EOF >> $EPS
0 -0.15
EOF

# vfplot output

gmt psimage vfplot.eps -W$DIM -Dx0/0 -O >> $EPS

# convert to output formats

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

# clean up

rm -r $EPS
