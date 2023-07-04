default: all

include ../Common.mk

all: figure.pdf compose.png

grd/u.grd grd/v.grd: csv/uv.csv
	csv-grd \
	  --verbose \
	  --input csv/uv.csv \
	  --pixel \
	  --grid-size 128/128 \
	  --grid-range 0/1/0/1 \
	  grd/u-pixel.grd grd/v-pixel.grd
	gmt grdsample -T -I513+n -Ggrd/u.grd grd/u-pixel.grd
	gmt grdsample -T -I513+n -Ggrd/v.grd grd/v-pixel.grd
	rm -f grd/u-pixel.grd grd/v-pixel.grd

grd/scalar.grd: grd/u.grd grd/v.grd
	gmt grdmath grd/u.grd DDX grd/v.grd DDY ADD = grd/scalar.grd

scalar.cpt:
	gmt makecpt -C$(CPTDIR)/Andy_GIlmore_2.cpt \
	  -T-40/40/2.5 -Z -D -M > scalar.cpt

vfplot.eps: vfplot.sh grd/u.grd grd/v.grd
	sh vfplot.sh

compose.pdf compose.png: compose.sh vfplot.eps scalar.cpt grd/scalar.grd
	sh compose.sh

figure.pdf: figure.tex compose.pdf
	pdflatex figure

RUBBISH += gmt.history

clean:
	$(RM) $(RUBBISH)

.PHONY: default all clean
