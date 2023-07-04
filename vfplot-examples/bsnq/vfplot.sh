#!/bin/sh
vfplot \
    --verbose \
    --width 8in \
    --crop 0/0/2in/1in \
    --margin 6/6/-0.4 \
    --scale 1e-3 \
    --iterations 500/5 \
    --pen 0.1mm \
    --fill darkred \
    --length 0/1in \
    --cache 512 \
    --aspect 4.5 \
    --symbol triangle \
    --output vfplot.eps \
    grd/u.grd grd/v.grd
