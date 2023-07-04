#!/bin/sh
vfplot \
    --verbose \
    --width 8in \
    --margin 5/5/-0.4 \
    --scale 1e-4 \
    --iterations 300/5 \
    --pen 0.1mm \
    --fill 100 \
    --length 0/1in \
    --cache 256 \
    --aspect 3.0 \
    --symbol triangle \
    --output vfplot.eps \
    grd/u.grd grd/v.grd
