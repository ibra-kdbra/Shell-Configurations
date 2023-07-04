default: all

include ../Common.mk

INC = -I256+/512+
RNG = -R-0.5/0.5/-0.5/1.5
GFS = gfs/frame-9.8.gfs

all: figure.pdf compose.png

grd/scalar.grd: $(GFS)
	gfs-csv -s T $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/T.grd $(RNG) $(INC)
	gmt grdmath grd/T.grd 0 MAX = grd/scalar.grd
	rm grd/T.grd

grd/u.grd: $(GFS)
	gfs-csv -s U $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/u.grd $(RNG) $(INC)

grd/v.grd: $(GFS)
	gfs-csv -s V $(GFS) | \
	  gmt xyz2grd -rp -Ggrd/v.grd $(RNG) $(INC)

vfplot.eps: vfplot.sh grd/u.grd grd/v.grd
	sh vfplot.sh

compose.pdf compose.png: compose.sh vfplot.eps gmt.conf grd/scalar.grd
	sh compose.sh

figure.pdf: figure.tex version.sty compose.pdf
	pdflatex figure

RUBBISH += gmt.history

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
