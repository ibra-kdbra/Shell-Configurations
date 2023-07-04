default: all

include ../Common.mk

INC = -I256+/128+
RNG = -R-0.5/1.5/-0.5/0.5
GFS = gfs/frame-2.0.gfs

all: figure.pdf compose.png

grd/scalar.grd: $(GFS)
	gfs-csv -s Vorticity $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/scalar.grd $(RNG) $(INC)

grd/u.grd: $(GFS)
	gfs-csv -s U $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/u.grd $(RNG) $(INC)

grd/v.grd: $(GFS)
	gfs-csv -s V $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/v.grd $(RNG) $(INC)

domain.geojson: domain.py
	python3 domain.py > domain.geojson

domain.xy: domain.geojson
	jq --raw-output \
	  '.coordinates[1][] | @csv' \
	  domain.geojson \
	  > domain.xy

vfplot.eps: vfplot.sh grd/u.grd grd/v.grd domain.geojson
	sh vfplot.sh

scalar.cpt:
	gmt makecpt -C$(CPTDIR)/polarity-RdBu.cpt -T-100/100/12.5 > scalar.cpt

compose.pdf compose.png: compose.sh domain.xy vfplot.eps scalar.cpt grd/scalar.grd
	sh compose.sh

figure.pdf: figure.tex version.sty compose.pdf
	pdflatex figure

RUBBISH += gmt.history

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
