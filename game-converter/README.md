# Shell script GUI single or batch game format converter for chdman and ciso.

## Features:
* single or batch convert cue, gdi, or toc to chd (option of chdman v4 or v5)
* Single or batch convert chd to gdi/bin/raw (creates gamename folder)
* Single or batch convert chd to bin/cue (creates gamename folder)
* Single or batch convert iso to cso (with compression options)
* Single or batch convert cso to iso
* Will not overwrite files or folders, if they already exist
* Will delete incomplete file if you start a conversion, and cancel before it's finished
* Creates a shortcut in your menu - Menu > Accessories > Game Converter

### [To Do List]
The progress bar for chdman single conversion just pulsates. I would like to make the progress bar actually work by echoing the percentage. This involves writing current line only of stderr to a temp file, and cutting the lines for the percentage (as far as I know, anyway). Any help would be appreciated.
If you tried game-converter on a distro other than Linux Mint, Please give some feedback 
