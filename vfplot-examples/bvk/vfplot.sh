#!/bin/sh
vfplot \
    --verbose \
    --width 12in \
    --crop 1.5in/4.5in/1.5in/1.5in \
    --margin 4/4/0.4 \
    --scale 2.5e-4 \
    --iterations 300/5 \
    --pen 0.6 \
    --fill 255 \
    --length 3mm/1in \
    --symbol arrow \
    --aspect 6.5 \
    --domain domain.geojson \
    --output vfplot.eps \
    grd/u.grd grd/v.grd
