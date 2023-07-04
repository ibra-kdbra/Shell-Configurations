#!/bin/sh
vfplot \
    --verbose \
    --width 4in \
    --margin 2/2/0.2 \
    --scale 2e-4 \
    --iterations 250/2 \
    --symbol triangle \
    --pen 0 \
    --fill 0 \
    --domain domain.geojson \
    --output-format povray \
    --output vfplot.inc \
    gfs/frame-2.0.gfs
