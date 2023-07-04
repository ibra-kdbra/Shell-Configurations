#!/bin/sh

set -e

RNG='-R-0.5/1.5/-0.50/0.50'
DIM='8i/4i'
PRJ="-JX$DIM"

EPS='compose.eps'

# background scalar (vorticity)

GRD='scalar-fine.grd'
gmt grdsample grd/scalar.grd -G$GRD $RNG -I1024+n/512+n
gmt grdimage $GRD $PRJ $RNG -Cscalar.cpt -K > $EPS
rm -f $GRD

# upper/lower wall

gmt psxy $PRJ $RNG -W0.1c -K -O <<EOF >> $EPS
-0.5 0.5
1.5 0.5
>
-0.5 -0.5
1.5 -0.5
EOF

# the grating elements

gmt psxy $PRJ $RNG -W0.05c -Sc0.48i -Gwhite -K -O <<EOF >> $EPS
0 -0.5625
>
0 -0.3750
>
0 -0.1875
>
0 0
>
0 0.1875
>
0 0.3750
>
0 0.5625
EOF

# vfplot output

gmt psimage vfplot.eps -W$DIM -Dx0/0 -O >> $EPS

# results

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

# clean-up

rm -r $EPS
