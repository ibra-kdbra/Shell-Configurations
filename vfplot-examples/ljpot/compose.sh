#!/bin/sh

set -e

SCALAR=$1

N=256
XMIN=-0.25
XMAX=1
YMIN=-0.75
YMAX=0.75

RNG="-R$XMIN/$XMAX/$YMIN/$YMAX"
INC="-I$N+/$N+"
DIM="5i/6i"
PRJ="-JX$DIM"

CPT='compose.cpt'
EPS='compose.eps'

gmt grdimage $SCALAR $RNG $PRJ -C$CPT -K >  $EPS
gmt grdcontour $SCALAR $RNG $PRJ -C$CPT -W1,white -A- -K -O >> $EPS
gmt psxy $RNG $PRJ -Wthick -L -K -O >> $EPS <<EOF
0  0.5
0 -0.5
0.866025 0
EOF
gmt psimage vfplot.eps -Dx0/0 -W$DIM -O >> $EPS

gmt psconvert -A -Tf $EPS
gmt psconvert -A -E150 -Tg $EPS

rm -f $CPT $EPS
