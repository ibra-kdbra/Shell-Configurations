default: all

include ../Common.mk

EXT = 0.03125
INC = -I256+
RNG = -R-$(EXT)/$(EXT)/-$(EXT)/$(EXT)
GFS = gfs/frame-19.30.gfs

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

scalar.cpt:
	gmt makecpt -C$(CPTDIR)/Andy_GIlmore_2.cpt \
	  -T-100/100/1 -Z -D -M > scalar.cpt

vfplot.eps: vfplot.sh grd/u.grd grd/v.grd
	sh vfplot.sh

compose.pdf compose.png: compose.sh vfplot.eps scalar.cpt grd/scalar.grd
	sh compose.sh

figure.pdf: figure.tex version.sty compose.pdf
	pdflatex figure

RUBBISH += gmt.history

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
