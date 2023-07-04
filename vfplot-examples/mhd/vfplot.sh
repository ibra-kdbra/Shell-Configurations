#!/bin/sh
vfplot \
    --verbose \
    --width 7in \
    --margin 0.5/3/0 \
    --aspect 4 \
    --scale 5e-4 \
    --iterations 400/5 \
    --pen 0.1mm \
    --fill 255 \
    --length 0/1in \
    --cache 513 \
    --symbol triangle \
    --output vfplot.eps \
    grd/u.grd grd/v.grd
