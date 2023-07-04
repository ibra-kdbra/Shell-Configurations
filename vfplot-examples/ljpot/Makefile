default: all

include ../Common.mk

SCALAR = grd/grocer-0750-1000.grd
CPT = $(CPTDIR)/db-a.cpt

all: figure.pdf compose.png

grd/u.grd: $(SCALAR)
	grdmath $(SCALAR) DDX NEG = grd/u.grd

grd/v.grd: $(SCALAR)
	grdmath $(SCALAR) DDY NEG = grd/v.grd

vfplot.eps: vfplot.sh grd/u.grd grd/v.grd
	sh vfplot.sh

compose.cpt: $(SCALAR) $(CPT)
	gmt grd2cpt $(SCALAR) -E20 -D -C$(CPT) > compose.cpt

compose.pdf compose.png: compose.sh compose.cpt vfplot.eps $(SCALAR)
	sh compose.sh $(SCALAR)

figure.pdf: figure.tex version.sty compose.pdf
	pdflatex figure

RUBBISH += gmt.history

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
