# common Make variables

SHARE := ../share
BIN := ../bin
CPTDIR := $(SHARE)/cpt

version.sty:
	$(BIN)/vfplot-version > version.sty

RUBBISH += figure.aux figure.log
