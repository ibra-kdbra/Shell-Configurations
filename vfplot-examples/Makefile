default: all clean

DIRS = bsnq bvk bvkp grating ljpot mhd rotcyl

all:
	for dir in $(DIRS) ; do \
	  $(MAKE) -C $$dir all || exit ; \
	done

clean:
	for dir in $(DIRS) ; do \
	  $(MAKE) -C $$dir clean || exit ; \
	done

lfs-prune:
	git lfs prune --verbose
