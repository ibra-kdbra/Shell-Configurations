#!/bin/sh
vfplot \
    --verbose \
    --width 8in \
    --margin 5/5/-0.4 \
    --scale 3e-4 \
    --iterations 500/5 \
    --pen 0.25mm \
    --fill 255 \
    --length 0/1in \
    --cache 256 \
    --aspect 4.0 \
    --symbol triangle \
    --output vfplot.eps \
    grd/u.grd grd/v.grd
