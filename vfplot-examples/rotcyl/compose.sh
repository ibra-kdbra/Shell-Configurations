#!/bin/sh

set -e

EXT='0.03125'
RNG="-R-$EXT/$EXT/-$EXT/$EXT"
DIM='4i/4i'
PRJ="-JX$DIM"

EPS='compose.eps'

# background scaler

GRD='/tmp/scalar-fine.grd'
gmt grdsample grd/scalar.grd -G$GRD $RNG -I1024+n
gmt grdimage $GRD $PRJ $RNG -Cscalar.cpt -K > $EPS
rm -f $GRD

# central cylinder

gmt psxy $PRJ $RNG -Sc1.27i -G255 -W1p -K -O >> $EPS <<EOF
0 0
EOF

# vfplot output

gmt psimage vfplot.eps -W$DIM -Dx0/0 -O >> $EPS

# results

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

# cleanup

rm -r $EPS
