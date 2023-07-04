default: all

include ../Common.mk

all: figure.pdf

domain.geojson: domain.py
	python3 domain.py > domain.geojson

scalar.cpt:
	gmt makecpt -Cpolar -T-80/80/10 -Z > scalar.cpt

scalar.png: scalar.sh gfs/frame-2.0.gfs scalar.cpt
	sh scalar.sh

vfplot.inc: vfplot.sh gfs/frame-2.0.gfs domain.geojson
	sh vfplot.sh

vfplot.png: vfplot.inc vfplot.pov scalar.png
	povray +L. +P +A0.1 +Q11 +Ivfplot.pov +W1920 +H1440 -D

figure.pdf: figure.tex version.sty vfplot.png
	pdflatex figure

RUBBISH +=

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
